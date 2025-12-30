import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../models/artist_model.dart';
import 'artist_detail_screen.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  late Future<ArtistsData> _artistsDataFuture;
  List<Artist> _filteredArtists = [];
  List<Artist> _allArtists = [];
  String _searchQuery = '';
  String? _selectedGenre;
  String? _selectedMood;

  @override
  void initState() {
    super.initState();
    _loadArtistsData();
  }

  Future<void> _loadArtistsData() async {
    _artistsDataFuture = _fetchArtistsData();
  }

  Future<ArtistsData> _fetchArtistsData() async {
    final apiService = ApiService();
    final jsonData = await apiService.fetchJson(ApiEndpoints.artists);
    return ArtistsData.fromJson(jsonData);
  }

  void _applyFilters(ArtistsData data) {
    _allArtists = data.artists;
    _filteredArtists = _allArtists.where((artist) {
      final matchesSearch = _searchQuery.isEmpty ||
          artist.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          artist.genres.any((genre) =>
              genre.toLowerCase().contains(_searchQuery.toLowerCase())) ||
          artist.bestFor.any((bestFor) =>
              bestFor.toLowerCase().contains(_searchQuery.toLowerCase()));

      final matchesGenre = _selectedGenre == null ||
          artist.genres.contains(_selectedGenre);

      final matchesMood = _selectedMood == null ||
          artist.moods.contains(_selectedMood);

      return matchesSearch && matchesGenre && matchesMood;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArtistsData>(
      future: _artistsDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        if (snapshot.hasError) {
          return CustomErrorWidget(
            errorMessage: snapshot.error.toString(),
            onRetry: _loadArtistsData,
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data!;
          _applyFilters(data);

          return _buildScreenContent(data);
        }

        return const CustomErrorWidget(errorMessage: 'No data available');
      },
    );
  }

  Widget _buildScreenContent(ArtistsData data) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: EdgeInsets.all(16.w),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search artists, genres, or moods...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),

        // Filters
        _buildFilters(data.filters),

        // Artists Grid
        Expanded(
          child: _filteredArtists.isEmpty
              ? Center(
            child: Text(
              'No artists found',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          )
              : GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.8,
            ),
            itemCount: _filteredArtists.length,
            itemBuilder: (context, index) {
              return _buildArtistCard(_filteredArtists[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(FilterSection filters) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          // Genre Filter
          _buildFilterChip(
            label: 'Genre',
            options: filters.genres,
            selected: _selectedGenre,
            onSelect: (value) {
              setState(() {
                _selectedGenre = _selectedGenre == value ? null : value;
              });
            },
          ),
          SizedBox(width: 8.w),

          // Mood Filter
          _buildFilterChip(
            label: 'Mood',
            options: filters.moods,
            selected: _selectedMood,
            onSelect: (value) {
              setState(() {
                _selectedMood = _selectedMood == value ? null : value;
              });
            },
          ),

          // Clear Filters
          if (_selectedGenre != null || _selectedMood != null)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: ActionChip(
                label: const Text('Clear'),
                onPressed: () {
                  setState(() {
                    _selectedGenre = null;
                    _selectedMood = null;
                  });
                },
                backgroundColor: AppColors.accentColor.withOpacity(0.1),
                labelStyle: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.accentColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required List<String> options,
    required String? selected,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 8.w,
      children: [
        Text(
          '$label:',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        ...options.map((option) {
          final isSelected = selected == option;
          return FilterChip(
            label: Text(option),
            selected: isSelected,
            onSelected: (_) => onSelect(option),
            selectedColor: AppColors.accentColor,
            checkmarkColor: Colors.white,
          );
        }).toList(),
      ],
    );
  }

  Widget _buildArtistCard(Artist artist) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtistDetailScreen(artist: artist),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artist Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: artist.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.backgroundColor,
                    child: const Icon(Icons.person, size: 40),
                  ),
                ),
              ),
            ),

            // Artist Info
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artist.name,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    artist.genres.join(', '),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 4.w,
                    runSpacing: 4.h,
                    children: artist.bestFor
                        .take(3)
                        .map((bestFor) => Chip(
                      label: Text(
                        bestFor,
                        style: AppTextStyles.caption,
                      ),
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.accentColor
                          .withOpacity(0.1),
                      labelPadding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                    ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
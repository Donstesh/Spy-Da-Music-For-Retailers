import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/content_page.dart';
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

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredArtists = _allArtists.where((artist) {
        return artist.name.toLowerCase().contains(_searchQuery) ||
            artist.genres.any((genre) => genre.toLowerCase().contains(_searchQuery)) ||
            artist.bestFor.any((bestFor) => bestFor.toLowerCase().contains(_searchQuery));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArtistsData>(
      future: _artistsDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ContentPage(
            title: 'Artists',
            child: Container(),
            isLoading: true,
          );
        }

        if (snapshot.hasError) {
          return ContentPage(
            title: 'Artists',
            child: Container(),
            hasError: true,
            errorMessage: snapshot.error.toString(),
            onRetry: _loadArtistsData,
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data!;
          _allArtists = data.artists;
          if (_filteredArtists.isEmpty) {
            _filteredArtists = _allArtists;
          }
          return _buildContent(data);
        }

        return ContentPage(
          title: 'Artists',
          child: Container(),
          hasError: true,
          errorMessage: 'No data available',
          onRetry: _loadArtistsData,
        );
      },
    );
  }

  Widget _buildContent(ArtistsData data) {
    return ContentPage(
      title: 'Artists',
      showSearch: true,
      onSearchChanged: _onSearchChanged,
      child: Column(
        children: [
          // Artists Grid
          _filteredArtists.isEmpty
              ? Center(
            child: Padding(
              padding: EdgeInsets.all(32.h),
              child: Text(
                _searchQuery.isNotEmpty
                    ? 'No artists found for "$_searchQuery"'
                    : 'No artists available',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          )
              : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
        ],
      ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
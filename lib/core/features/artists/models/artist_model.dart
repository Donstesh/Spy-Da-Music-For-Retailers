class ArtistsData {
  final IntroSection intro;
  final FilterSection filters;
  final List<Artist> artists;

  ArtistsData({
    required this.intro,
    required this.filters,
    required this.artists,
  });

  factory ArtistsData.fromJson(Map<String, dynamic> json) {
    return ArtistsData(
      intro: IntroSection.fromJson(json['intro']),
      filters: FilterSection.fromJson(json['filters']),
      artists: (json['artists'] as List)
          .map((artist) => Artist.fromJson(artist))
          .toList(),
    );
  }
}

class IntroSection {
  final String title;
  final String subtitle;

  IntroSection({required this.title, required this.subtitle});

  factory IntroSection.fromJson(Map<String, dynamic> json) {
    return IntroSection(
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }
}

class FilterSection {
  final List<String> genres;
  final List<String> moods;

  FilterSection({required this.genres, required this.moods});

  factory FilterSection.fromJson(Map<String, dynamic> json) {
    return FilterSection(
      genres: List<String>.from(json['genres']),
      moods: List<String>.from(json['moods']),
    );
  }
}

class Artist {
  final String name;
  final String slug;
  final String imageUrl;
  final List<String> genres;
  final List<String> moods;
  final List<String> bestFor;
  final String bioShort;
  final bool cleanMusicPromise;
  final List<PreviewLink> previewLinks;

  Artist({
    required this.name,
    required this.slug,
    required this.imageUrl,
    required this.genres,
    required this.moods,
    required this.bestFor,
    required this.bioShort,
    required this.cleanMusicPromise,
    required this.previewLinks,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      name: json['name'],
      slug: json['slug'],
      imageUrl: json['image_url'],
      genres: List<String>.from(json['genres']),
      moods: List<String>.from(json['moods']),
      bestFor: List<String>.from(json['best_for']),
      bioShort: json['bio_short'],
      cleanMusicPromise: json['clean_music_promise'],
      previewLinks: (json['preview_links'] as List)
          .map((link) => PreviewLink.fromJson(link))
          .toList(),
    );
  }
}

class PreviewLink {
  final String label;
  final String url;

  PreviewLink({required this.label, required this.url});

  factory PreviewLink.fromJson(Map<String, dynamic> json) {
    return PreviewLink(
      label: json['label'],
      url: json['url'],
    );
  }
}
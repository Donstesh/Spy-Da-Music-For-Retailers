class LabelData {
  final HeroSection hero;
  final List<LabelSection> sections;
  final List<LinkCard> linkCards;
  final String footerNote;

  LabelData({
    required this.hero,
    required this.sections,
    required this.linkCards,
    required this.footerNote,
  });

  factory LabelData.fromJson(Map<String, dynamic> json) {
    return LabelData(
      hero: HeroSection.fromJson(json['hero']),
      sections: (json['sections'] as List)
          .map((section) => LabelSection.fromJson(section))
          .toList(),
      linkCards: (json['link_cards'] as List)
          .map((card) => LinkCard.fromJson(card))
          .toList(),
      footerNote: json['footer_note'],
    );
  }
}

class HeroSection {
  final String title;
  final String subtitle;
  final List<CtaButton> ctaButtons;

  HeroSection({
    required this.title,
    required this.subtitle,
    required this.ctaButtons,
  });

  factory HeroSection.fromJson(Map<String, dynamic> json) {
    return HeroSection(
      title: json['title'],
      subtitle: json['subtitle'],
      ctaButtons: (json['ctas'] as List)
          .map((cta) => CtaButton.fromJson(cta))
          .toList(),
    );
  }
}

class LabelSection {
  final String title;
  final List<String>? bullets;
  final List<PlanCard>? cards;

  LabelSection({
    required this.title,
    this.bullets,
    this.cards,
  });

  factory LabelSection.fromJson(Map<String, dynamic> json) {
    return LabelSection(
      title: json['title'],
      bullets: json['bullets'] != null
          ? List<String>.from(json['bullets'])
          : null,
      cards: json['cards'] != null
          ? (json['cards'] as List).map((card) => PlanCard.fromJson(card)).toList()
          : null,
    );
  }
}

class CtaButton {
  final String label;
  final String url;

  CtaButton({required this.label, required this.url});

  factory CtaButton.fromJson(Map<String, dynamic> json) {
    return CtaButton(
      label: json['label'],
      url: json['url'],
    );
  }
}

class PlanCard {
  final String name;
  final String priceText;
  final List<String> points;
  final CtaButton cta;

  PlanCard({
    required this.name,
    required this.priceText,
    required this.points,
    required this.cta,
  });

  factory PlanCard.fromJson(Map<String, dynamic> json) {
    return PlanCard(
      name: json['name'],
      priceText: json['price_text'],
      points: List<String>.from(json['points']),
      cta: CtaButton.fromJson(json['cta']),
    );
  }
}

class LinkCard {
  final String title;
  final String subtitle;
  final String url;

  LinkCard({
    required this.title,
    required this.subtitle,
    required this.url,
  });

  factory LinkCard.fromJson(Map<String, dynamic> json) {
    return LinkCard(
      title: json['title'],
      subtitle: json['subtitle'],
      url: json['url'],
    );
  }
}
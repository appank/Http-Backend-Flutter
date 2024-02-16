class Anime {
  final String title;
  final String description;
  final String image;

  const Anime({
    required this.title,
    required this.description,
    required this.image,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
        title: json['title'],
        description: json['description'],
        image: json['image']);
  }
}

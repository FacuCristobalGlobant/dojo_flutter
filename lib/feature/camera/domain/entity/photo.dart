class Photo {
  Photo({
    required this.imageData,
    required this.isFavorite,
    required this.name,
  });

  final String imageData;
  final bool isFavorite;
  final String name;

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      imageData: json["imageData"],
      isFavorite: json["isFavorite"].toLowerCase() == 'true',
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "imageData": imageData,
      "isFavorite": isFavorite,
      "name": name,
    };
  }
}

class GalleryPhoto {
  GalleryPhoto({required this.name, required this.caption, required this.url});

  final String name;
  final String caption;
  final String url;

  static List<GalleryPhoto> fromMap(Map<String, dynamic> map) {
    var imageAttributes = map['attributes']['image']['data'] as List<dynamic>;
    return imageAttributes.map((imageData) {
      var attributes = imageData['attributes'] as Map<String, dynamic>;
      return GalleryPhoto(
        name: attributes['name'] as String,
        caption: attributes['caption'] as String? ?? "empty",
        url: "http://localhost:1337" + (attributes['url'] as String),
      );
    }).toList();
  }
}

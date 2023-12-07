class Gallery {
  Gallery(
      {required this.id,
      required this.title,
      required this.description,
      required this.photoGalleriesIds});

  final int id;
  final String title;
  final String description;
  final List<int> photoGalleriesIds;

  factory Gallery.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('attributes') || map['attributes'] == null) {
      throw Exception('Missing attributes in data');
    }
    var attributes = map['attributes'] as Map<String, dynamic>;

    // Extracting photo gallery IDs
    List<int> extractedPhotoIds = [];
    if (attributes.containsKey('photos') && attributes['photos'] != null) {
      var photosData = attributes['photos']['data'] as List<dynamic>;
      extractedPhotoIds = photosData.map((photo) => photo['id'] as int).toList();
    }
    return Gallery(
      id: map['id'] as int,
      title: attributes['title'] as String,
      description: attributes['description'] as String,
        photoGalleriesIds: extractedPhotoIds,
    );
  }
}

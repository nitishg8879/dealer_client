class ProductModel {
  ProductModel({
    required this.name,
    required this.images,
  });

  final String? name;
  final List<String> images;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return ProductModel(
      name: json["name"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "images": images.map((x) => x).toList(),
      };
}

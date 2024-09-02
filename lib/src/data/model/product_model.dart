class ProductModel {
  ProductModel({
    this.name,
    this.year,
    this.kmDriven,
    this.price,
    this.images,
    this.ownerType,
    this.branch,
  });

  final String? name;
  final String? branch;
  final num? year;
  final num? kmDriven;
  final num? price;
  final String? ownerType;
  final List<String>? images;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "images": images?.map((x) => x).toList(),
      };
}

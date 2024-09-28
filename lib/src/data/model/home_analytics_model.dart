import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';

class HomeAnalyticsDataModel {
  List<Carsouel>? carsouel;
  List<HomeProducts>? products;
  List<CategoryModel>? category;
  List<CompanyModel>? company;
  List<CategoryCompanyMdoel>? categoryCompnaymodel;

  HomeAnalyticsDataModel({this.carsouel, this.products});

  HomeAnalyticsDataModel.fromJson(Map<String, dynamic> json) {
    if (json['carsouel'] != null) {
      carsouel = <Carsouel>[];
      json['carsouel'].forEach((v) {
        carsouel!.add(Carsouel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <HomeProducts>[];
      json['products'].forEach((v) {
        products!.add(HomeProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (carsouel != null) {
      data['carsouel'] = carsouel!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Carsouel {
  String? productId;
  String? image;

  Carsouel({this.productId, this.image});

  Carsouel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['image'] = image;
    return data;
  }
}

class HomeProducts {
  String? label;
  int? priority;
  List<String>? products;

  HomeProducts({this.label, this.priority, this.products});

  HomeProducts.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    priority = json['priority'];
    products = json['products']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['priority'] = priority;
    data['products'] = products;
    return data;
  }
}

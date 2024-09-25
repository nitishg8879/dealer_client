import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryCompanyMdoel {
  DocumentReference? category;
  DocumentReference? company;
  String? name;
  String? id;

  CategoryCompanyMdoel({this.category, this.company, this.name, this.id});

  CategoryCompanyMdoel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    company = json['company'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['company'] = company;
    data['name'] = name;
    print(data);
    // data['id'] = id;
    return data;
  }
}

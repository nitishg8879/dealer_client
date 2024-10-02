import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:flutter/material.dart' show RangeValues;

class ProductsFilterController {
  bool get hasFilter {
    return (selectedCategory.isNotEmpty || selectedCompany.isNotEmpty || selectedCatCompBrands.isNotEmpty) ||
        (priceMinMaxSelected.start != 0 || priceMinMaxSelected.end != 0) ||
        (minYear != null || maxYear != null) ||
        (kmMinMaxSelected.start != 0 || kmMinMaxSelected.end != 0) ||
        products.isNotEmpty;
  }

  List<CategoryModel> category = [];
  List<CompanyModel> company = [];
  List<CategoryCompanyMdoel> categoryCompanyBrands = [];

  List<String> products = [];

  List<CategoryModel> selectedCategory = [];
  List<CompanyModel> selectedCompany = [];
  List<CategoryCompanyMdoel> selectedCatCompBrands = [];

  void clear() {
    selectedCategory = [];
    selectedCompany = [];
    selectedCatCompBrands = [];
    priceMinMaxSelected = const RangeValues(0, 0);
    kmMinMaxSelected = const RangeValues(0, 0);
    minYear = null;
    maxYear = null;
    products.clear();
  }

  RangeValues priceMinMaxSelected;
  RangeValues kmMinMaxSelected;
  DateTime? minYear, maxYear;
  bool gridViewtype;
  ProductsFilterController({
    required this.category,
    required this.company,
    required this.categoryCompanyBrands,
    this.gridViewtype = true,
  })  : priceMinMaxSelected = const RangeValues(0, 0),
        kmMinMaxSelected = const RangeValues(0, 0);
}

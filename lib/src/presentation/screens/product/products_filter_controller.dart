import 'package:bike_client_dealer/src/data/model/category_model.dart';
import 'package:flutter/material.dart' show RangeValues, TextEditingController;

class ProductsFilterController {
  List<CategoryModel> category = [];
  List<CategoryModel> brands = [];
  RangeValues priceMinMax;
  RangeValues priceMinMaxSelected;
  RangeValues yearMinMax;
  RangeValues yearMinMaxSelected;
  RangeValues kmMinMax;
  RangeValues kmMinMaxSelected;
  ProductsFilterController({
    required this.priceMinMax,
    required this.priceMinMaxSelected,
    required this.yearMinMax,
    required this.yearMinMaxSelected,
    required this.kmMinMax,
    required this.kmMinMaxSelected,
  });
}

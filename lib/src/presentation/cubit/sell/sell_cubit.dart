import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/presentation/screens/sell/sell_form_view.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'sell_state.dart';

class SellCubit extends Cubit<SellState> {
  SellCubit() : super(SellInitial());

  void fetchSellProducts() {}

  void openSellForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: 16.smoothRadius)),
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) => SellFormView(),
    ).whenComplete(() {
      fetchSellProducts();
    });
  }
}

import 'dart:io';

import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/app_text_input_formatter.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/data/model/product_sell_model.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SellFormView extends StatefulWidget {
  final ProductSellModel? data;
  const SellFormView({super.key, this.data});

  @override
  State<SellFormView> createState() => _SellFormViewState();
}

class _SellFormViewState extends State<SellFormView> {
  ProductSellModel? productSellModel;
  List<PlatformFile> files = [];
  final buyDateTc = TextEditingController(), validTillTc = TextEditingController();
  @override
  void initState() {
    if (widget.data == null) {
      productSellModel = ProductSellModel();
    } else {
      productSellModel = widget.data;
      buyDateTc.text = productSellModel?.buyDate?.toDate().mmmYYY ?? '';
      validTillTc.text = productSellModel?.validTill?.toDate().mmmYYY ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: .1,
      maxChildSize: 1,
      expand: false,
      initialChildSize: .5,
      builder: (context, sc) {
        return Scaffold(
          body: ListView(
            controller: sc,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              16.spaceH,
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      HelperFun.pickFile().then((result) {
                        if (result != null) {
                          files.addAll(result.files);
                          setState(() {});
                        }
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.filter,
                        color: AppColors.kBlack900,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: sc,
                      child: Row(
                        children: files.map(
                          (file) {
                            if (kIsWeb) {
                              return Image.memory(
                                file.bytes!,
                                width: 100,
                                height: 100,
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: ClipRRect(
                                  borderRadius: 16.borderRadius,
                                  child: Image.file(
                                    File(file.path!),
                                    width: 80,
                                    height: 60,
                                  ),
                                ),
                              );
                            }
                          },
                        ).toList(),
                      ),
                    ),
                  )
                ],
              ),
              16.spaceH,
              AppTextField(
                label: "Name",
                initialValue: productSellModel?.name,
                onChanged: (name) => productSellModel?.name = name,
              ),
              16.spaceH,
              AppTextField(
                label: "KM Driven",
                initialValue: productSellModel?.kmdrvien?.toString() ?? '',
                onChanged: (km) => productSellModel?.kmdrvien = int.tryParse(km.replaceAll(",", "")),
                inputFormatters: [
                  NumberInputFormatter(),
                ],
              ),
              16.spaceH,
              AppTextField(
                label: "Your Price",
                initialValue: productSellModel?.price?.toString() ?? '',
                onChanged: (price) => productSellModel?.price = double.tryParse(price.replaceAll(",", "").replaceAll("₹", "")),
                inputFormatters: [
                  RupeeInputFormatter(),
                ],
              ),
              16.spaceH,
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: "Owners",
                      inputFormatters: [NumbersOnlyInputFormatter()],
                      initialValue: productSellModel?.owners?.toString() ?? '',
                      onChanged: (owners) => productSellModel?.owners = int.tryParse(owners),
                    ),
                  ),
                  16.spaceW,
                  Expanded(
                    child: AppTextField(
                      label: "Keys",
                      initialValue: productSellModel?.keys?.toString() ?? '',
                      onChanged: (keys) => productSellModel?.keys = int.tryParse(keys),
                    ),
                  ),
                ],
              ),
              16.spaceH,
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: "Buy Date",
                      readOnly: true,
                      onTap: () async {
                        final result = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
                          lastDate: DateTime.now(),
                          initialDate: productSellModel?.buyDate?.toDate(),
                        );
                        if (result != null) {
                          productSellModel?.buyDate = Timestamp.fromDate(result);
                          buyDateTc.text = result.mmmYYY;
                        } else {
                          buyDateTc.clear();
                          productSellModel?.buyDate = null;
                        }
                      },
                      suffix: Icon(Icons.date_range),
                      controller: buyDateTc,
                    ),
                  ),
                  16.spaceW,
                  Expanded(
                    child: AppTextField(
                      label: "Valid Till",
                      readOnly: true,
                      onTap: () async {
                        final result = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
                          lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
                          initialDate: productSellModel?.validTill?.toDate(),
                        );
                        if (result != null) {
                          productSellModel?.validTill = Timestamp.fromDate(result);
                          validTillTc.text = result.mmmYYY;
                        } else {
                          validTillTc.clear();
                          productSellModel?.validTill = null;
                        }
                      },
                      suffix: Icon(Icons.date_range),
                      controller: validTillTc,
                    ),
                  ),
                ],
              ),
              16.spaceH,
              ElevatedButton(
                onPressed: () {
                  print(productSellModel?.toJson());
                },
                child: Text("Review"),
              )
            ],
          ),
        );
      },
    );
  }
}

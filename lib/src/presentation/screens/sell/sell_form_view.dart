import 'dart:io';

import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/app_text_input_formatter.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/data/model/product_sell_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/sell/sell_cubit.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellFormView extends StatefulWidget {
  final ProductSellModel? data;
  final SellCubit sellCubit;
  const SellFormView({
    super.key,
    this.data,
    required this.sellCubit,
  });

  @override
  State<SellFormView> createState() => _SellFormViewState();
}

class _SellFormViewState extends State<SellFormView> {
  ProductSellModel? productSellModel;
  List<PlatformFile> files = [];
  List<String> deleteFiles = [];
  final buyDateTc = TextEditingController(), validTillTc = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
      initialChildSize: .89,
      builder: (context, sc) {
        return Scaffold(
          body: Form(
            key: formKey,
            child: ListView(
              controller: sc,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                16.spaceH,
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        if (files.length >= 5) {
                          HelperFun.showErrorSnack("You can only upload 5 images.");
                          return;
                        }
                        HelperFun.pickFile().then((result) async {
                          if (result != null) {
                            for (var element in result.files) {
                              int fileSizeInBytes;
                              if (kIsWeb) {
                                fileSizeInBytes = element.bytes!.length;
                              } else {
                                File file = File(element.path!);
                                fileSizeInBytes = await file.length();
                              }
                              double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
                              if (fileSizeInMB < 5) {
                                files.addAll(result.files);
                              } else {
                                HelperFun.showErrorSnack("Upload file which is less than 5MB.");
                              }
                            }
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
                          children: [
                            //? Render Network File
                            for (var networkFile in productSellModel?.images ?? []) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: ClipRRect(
                                  borderRadius: 16.borderRadius,
                                  child: CachedNetworkImage(
                                    imageUrl: networkFile,
                                    width: 80,
                                    height: 60,
                                  ),
                                ),
                              )
                            ],
                            //? Render Local Files
                            for (var localFile in files) ...[
                              if (kIsWeb)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: ClipRRect(
                                    borderRadius: 16.borderRadius,
                                    child: Image.memory(
                                      localFile.bytes!,
                                      width: 80,
                                      height: 60,
                                    ),
                                  ),
                                )
                              else
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: ClipRRect(
                                    borderRadius: 16.borderRadius,
                                    child: Image.file(
                                      File(localFile.path!),
                                      width: 80,
                                      height: 60,
                                    ),
                                  ),
                                ),
                            ],
                          ],
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
                  validator: (val) {
                    if (val?.trim().isEmpty ?? true) {
                      return "This field is can't be empty";
                    }
                    return null;
                  },
                ),
                16.spaceH,
                AppTextField(
                  label: "KM Driven",
                  initialValue: productSellModel?.kmdrvien?.toString() ?? '',
                  onChanged: (km) => productSellModel?.kmdrvien = int.tryParse(km.replaceAll(",", "")),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    NumberInputFormatter(),
                    // FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (val) {
                    if (val?.trim().isEmpty ?? true) {
                      return "This field is can't be empty";
                    }
                    return null;
                  },
                ),
                16.spaceH,
                AppTextField(
                  label: "Your Price",
                  keyboardType: TextInputType.number,
                  initialValue: productSellModel?.price?.toString() ?? '',
                  onChanged: (price) => productSellModel?.price = double.tryParse(price.replaceAll(",", "").replaceAll("₹", "")),
                  inputFormatters: [
                    RupeeInputFormatter(),
                  ],
                  validator: (val) {
                    if (val?.trim().isEmpty ?? true) {
                      return "This field is can't be empty";
                    }
                    return null;
                  },
                ),
                16.spaceH,
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: "Owners",
                        keyboardType: TextInputType.number,
                        inputFormatters: [NumbersOnlyInputFormatter()],
                        initialValue: productSellModel?.owners?.toString() ?? '',
                        onChanged: (owners) => productSellModel?.owners = int.tryParse(owners),
                        validator: (val) {
                          if (val?.trim().isEmpty ?? true) {
                            return "This field is can't be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    16.spaceW,
                    Expanded(
                      child: AppTextField(
                        label: "Keys",
                        keyboardType: TextInputType.number,
                        initialValue: productSellModel?.keys?.toString() ?? '',
                        onChanged: (keys) => productSellModel?.keys = int.tryParse(keys),
                        validator: (val) {
                          if (val?.trim().isEmpty ?? true) {
                            return "This field is can't be empty";
                          }
                          return null;
                        },
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
                        validator: (val) {
                          if (val?.trim().isEmpty ?? true) {
                            return "This field is can't be empty";
                          }
                          return null;
                        },
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
                        validator: (val) {
                          if (val?.trim().isEmpty ?? true) {
                            return "This field is can't be empty";
                          }
                          return null;
                        },
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
                    if (files.isEmpty && (productSellModel?.images?.isEmpty ?? true)) {
                      HelperFun.showErrorSnack("Please Upload images.");
                    } else if (formKey.currentState?.validate() ?? false) {
                      widget.sellCubit.addOrUpdateSellProduct(
                        sellProduct: productSellModel!,
                        localFile: files,
                        deleteFile: deleteFiles,
                      );
                    }
                  },
                  child: BlocBuilder<SellCubit, SellState>(
                    bloc: widget.sellCubit,
                    buildWhen: (previous, current) => current is SellUploading,
                    builder: (context, state) {
                      if (state is SellUploading) {
                        if (state.status != null) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(state.status ?? ''),
                              16.spaceW,
                              SizedBox(
                                width: 13,
                                height: 13,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  color: AppColors.kWhite,
                                ),
                              )
                            ],
                          );
                        }
                      }
                      return Text(productSellModel?.id == null ? "Review" : "Update");
                    },
                  ),
                ),
                20.spaceH,
              ],
            ),
          ),
        );
      },
    );
  }
}

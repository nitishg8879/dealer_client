import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/app_text_input_formatter.dart';
import 'package:bike_client_dealer/src/data/model/category_company_mdoel.dart';
import 'package:bike_client_dealer/src/data/model/category_model%20copy.dart';
import 'package:bike_client_dealer/src/data/model/company_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/home/home_cubit.dart';
import 'package:bike_client_dealer/src/presentation/cubit/product/product_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductFilterView extends StatefulWidget {
  final HomeCubit homeCubit;
  final ProductsFilterController controller;
  const ProductFilterView({
    super.key,
    required this.controller,
    required this.homeCubit,
  });

  @override
  State<ProductFilterView> createState() => _ProductFilterViewState();
}

class _ProductFilterViewState extends State<ProductFilterView> {
  final pageController = PageController();
  @override
  void initState() {
    widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: .1,
      maxChildSize: 1,
      expand: false,
      initialChildSize: .5,
      builder: (context, scrollController) {
        return Material(
          color: AppColors.kGrey50,
          surfaceTintColor: AppColors.kGrey50,
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildFilterView(scrollController, context),
              _buildCategoryList(scrollController, context),
              _buildCompanyList(scrollController, context),
              _buildCatCompnayModelList(scrollController, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCatCompnayModelList(ScrollController scrollController, BuildContext context) {
    return StatefulBuilder(builder: (context, re) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    pageController.jumpToPage(0);
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints.expand(width: 24, height: 24),
                ),
                8.spaceW,
                Expanded(
                  child: AppTextField(
                    hintText: "Search Model",
                    onChanged: (val) {
                      re(() {
                        if (val.trim().isNotEmpty) {
                          widget.controller.categoryCompanyBrands = (widget.homeCubit.homeData?.categoryCompnaymodel ?? <CategoryCompanyMdoel>[])
                              .where(
                                (e) => e.name?.toLowerCase().contains(val.toLowerCase()) ?? false,
                              )
                              .toList();
                        } else {
                          widget.controller.categoryCompanyBrands = List.from(widget.homeCubit.homeData?.categoryCompnaymodel ?? []);
                        }
                      });
                    },
                  ),
                ),
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: widget.controller.selectedCatCompBrands.length == (widget.homeCubit.homeData?.categoryCompnaymodel ?? []).length,
                  onChanged: (a) {
                    if (widget.controller.selectedCatCompBrands.length == (widget.homeCubit.homeData?.categoryCompnaymodel ?? []).length) {
                      widget.controller.selectedCatCompBrands = [];
                    } else {
                      widget.controller.selectedCatCompBrands = List.from(widget.homeCubit.homeData?.categoryCompnaymodel ?? []);
                    }
                    re(() {});
                  },
                  activeColor: AppColors.kFoundationPurple700,
                  shape: RoundedRectangleBorder(borderRadius: 4.borderRadius),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              itemCount: widget.controller.categoryCompanyBrands.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  value: widget.controller.selectedCatCompBrands.any((e) => widget.controller.categoryCompanyBrands[index].id == e.id),
                  activeColor: AppColors.kFoundationPurple700,
                  checkboxShape: RoundedRectangleBorder(borderRadius: 4.borderRadius),
                  dense: true,
                  title: Text(
                    widget.controller.categoryCompanyBrands[index].name ?? '-',
                    style: context.textTheme.titleMedium,
                  ),
                  onChanged: (value) {
                    re(() {
                      if (widget.controller.selectedCatCompBrands.any((e) => widget.controller.categoryCompanyBrands[index].id == e.id)) {
                        widget.controller.selectedCatCompBrands.removeWhere((e) => widget.controller.categoryCompanyBrands[index].id == e.id);
                      } else {
                        widget.controller.selectedCatCompBrands.add(widget.controller.categoryCompanyBrands[index]);
                      }
                    });
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.kTableBorderColor)),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCompanyList(ScrollController scrollController, BuildContext context) {
    return StatefulBuilder(builder: (context, re) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    pageController.jumpToPage(0);
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints.expand(width: 24, height: 24),
                ),
                8.spaceW,
                Expanded(
                  child: AppTextField(
                    hintText: "Search Company",
                    onChanged: (val) {
                      re(() {
                        if (val.trim().isNotEmpty) {
                          widget.controller.company = (widget.homeCubit.homeData?.company ?? <CompanyModel>[])
                              .where(
                                (e) => e.name?.toLowerCase().contains(val.toLowerCase()) ?? false,
                              )
                              .toList();
                        } else {
                          widget.controller.company = List.from(widget.homeCubit.homeData?.company ?? []);
                        }
                      });
                    },
                  ),
                ),
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: widget.controller.selectedCompany.length == (widget.homeCubit.homeData?.company ?? []).length,
                  onChanged: (a) {
                    if (widget.controller.selectedCompany.length == (widget.homeCubit.homeData?.company ?? []).length) {
                      widget.controller.selectedCompany = [];
                    } else {
                      widget.controller.selectedCompany = List.from(widget.homeCubit.homeData?.company ?? []);
                    }
                    re(() {});
                  },
                  activeColor: AppColors.kFoundationPurple700,
                  shape: RoundedRectangleBorder(borderRadius: 4.borderRadius),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              itemCount: widget.controller.company.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  value: widget.controller.selectedCompany.any((e) => widget.controller.company[index].id == e.id),
                  activeColor: AppColors.kFoundationPurple700,
                  checkboxShape: RoundedRectangleBorder(borderRadius: 4.borderRadius),
                  dense: true,
                  title: Text(
                    widget.controller.company[index].name ?? '-',
                    style: context.textTheme.titleMedium,
                  ),
                  onChanged: (value) {
                    re(() {
                      if (widget.controller.selectedCompany.any((e) => widget.controller.company[index].id == e.id)) {
                        widget.controller.selectedCompany.removeWhere((e) => widget.controller.company[index].id == e.id);
                      } else {
                        widget.controller.selectedCompany.add(widget.controller.company[index]);
                      }
                    });
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.kTableBorderColor)),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCategoryList(ScrollController scrollController, BuildContext context) {
    return StatefulBuilder(builder: (context, re) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    pageController.jumpToPage(0);
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  padding: const EdgeInsets.all(0),
                  constraints: const BoxConstraints.expand(width: 24, height: 24),
                ),
                8.spaceW,
                Expanded(
                  child: AppTextField(
                    hintText: "Search Category",
                    onChanged: (val) {
                      re(() {
                        if (val.trim().isNotEmpty) {
                          widget.controller.category = (widget.homeCubit.homeData?.category ?? <CategoryModel>[])
                              .where(
                                (e) => e.name?.toLowerCase().contains(val.toLowerCase()) ?? false,
                              )
                              .toList();
                        } else {
                          widget.controller.category = List.from(widget.homeCubit.homeData?.category ?? []);
                        }
                      });
                    },
                  ),
                ),
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: widget.controller.selectedCategory.length == (widget.homeCubit.homeData?.category ?? []).length,
                  onChanged: (a) {
                    if (widget.controller.selectedCategory.length == (widget.homeCubit.homeData?.category ?? []).length) {
                      widget.controller.selectedCategory = [];
                    } else {
                      widget.controller.selectedCategory = List.from(widget.homeCubit.homeData?.category ?? []);
                    }
                    re(() {});
                  },
                  activeColor: AppColors.kFoundationPurple700,
                  shape: RoundedRectangleBorder(borderRadius: 4.borderRadius),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              controller: scrollController,
              itemCount: widget.controller.category.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  value: widget.controller.selectedCategory.any((e) => widget.controller.category[index].id == e.id),
                  activeColor: AppColors.kFoundationPurple700,
                  checkboxShape: RoundedRectangleBorder(borderRadius: 4.borderRadius),
                  dense: true,
                  title: Text(
                    widget.controller.category[index].name ?? '-',
                    style: context.textTheme.titleMedium,
                  ),
                  onChanged: (value) {
                    re(() {
                      if (widget.controller.selectedCategory.any((e) => widget.controller.category[index].id == e.id)) {
                        widget.controller.selectedCategory.removeWhere((e) => widget.controller.category[index].id == e.id);
                      } else {
                        widget.controller.selectedCategory.add(widget.controller.category[index]);
                      }
                    });
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.kTableBorderColor)),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildFilterView(ScrollController scrollController, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Row(
                children: [
                  6.spaceW,
                  Expanded(
                    child: Text(
                      widget.controller.gridViewtype ? "ListView" : "GridView",
                      style: context.textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: AppColors.kFoundatiionPurple800,
                    value: widget.controller.gridViewtype,
                    onChanged: (value) {
                      setState(() {
                        widget.controller.gridViewtype = !widget.controller.gridViewtype;
                      });
                    },
                  ),
                ],
              ),
              12.spaceH,
              BlocBuilder<HomeCubit, HomeState>(
                bloc: widget.homeCubit,
                builder: (context, state) {
                  print("Building filter view list");
                  return ProductFilterTile(
                    items: [
                      ProductFilterTileModel("Category", () {
                        widget.controller.category = List.from(widget.homeCubit.homeData?.category ?? []);
                        pageController.jumpToPage(1);
                      }),
                      ProductFilterTileModel("Brands", () {
                        widget.controller.company = List.from(widget.homeCubit.homeData?.company ?? []);
                        pageController.jumpToPage(2);
                      }),
                      ProductFilterTileModel("Model", () {
                        widget.controller.categoryCompanyBrands = List.from(widget.homeCubit.homeData?.categoryCompnaymodel ?? []);
                        pageController.jumpToPage(3);
                      }),
                    ],
                    scrollController: scrollController,
                  );
                },
              ),
              12.spaceH,
              AppRangeSelector(
                label: "Price",
                minlabel: "Min",
                maxlabel: "Max",
                selectedRange: widget.controller.priceMinMaxSelected,
                onChangeRange: (val) => widget.controller.priceMinMaxSelected = val,
              ),
              12.spaceH,
              AppRangeSelector(
                label: "Km Driven",
                minlabel: "Min",
                maxlabel: "Max",
                selectedRange: widget.controller.kmMinMaxSelected,
                onChangeRange: (val) => widget.controller.kmMinMaxSelected = val,
              ),
              12.spaceH,
              AppRangeSelector(
                label: "Year",
                minlabel: "Min",
                maxlabel: "Max",
                isDatePicker: true,
                minDateChage: (date) {
                  widget.controller.minYear = date;
                },
                maxDateChage: (date) {
                  widget.controller.maxYear = date;
                },
              ),
              32.spaceH,
              context.isKeyboardOpen ? 300.spaceH : 32.spaceH,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: context.pop,
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: const WidgetStatePropertyAll(AppColors.doveGray),
                      ),
                  child: const Text("Cancel"),
                ),
              ),
              16.spaceW,
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      getIt.get<ProductCubit>().fetchProducts(widget.controller);
                      context.pop();
                    },
                    child: Text("Apply")),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class AppRangeSelector extends StatefulWidget {
  final String label;
  final String minlabel;
  final String maxlabel;
  final RangeValues? selectedRange;
  final bool isDatePicker;
  final void Function(RangeValues val)? onChangeRange;
  final void Function(DateTime? date)? minDateChage;
  final void Function(DateTime? date)? maxDateChage;
  const AppRangeSelector({
    super.key,
    required this.label,
    required this.minlabel,
    required this.maxlabel,
    this.selectedRange,
    this.isDatePicker = false,
    this.minDateChage,
    this.maxDateChage,
    this.onChangeRange,
  });

  @override
  State<AppRangeSelector> createState() => _AppRangeSelectorState();
}

class _AppRangeSelectorState extends State<AppRangeSelector> {
  late RangeValues selectedRange;
  final startTc = TextEditingController();
  final endTc = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  @override
  void initState() {
    selectedRange = widget.selectedRange ?? const RangeValues(0, 0);
    startTc.text = selectedRange.start.readableNumber;
    endTc.text = selectedRange.end.readableNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: 12.smoothBorderRadius,
        color: AppColors.kWhite,
        border: Border.all(
          color: AppColors.kFoundationPurple100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Text(
              widget.label,
              style: context.textTheme.headlineSmall?.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          16.spaceH,
          // RangeSlider(
          //   activeColor: AppColors.kFoundationPurple600,
          //   inactiveColor: AppColors.kFoundationPurple200,
          //   values: selectedRange,
          //   labels: RangeLabels("${selectedRange.start}", "${selectedRange.end}"),
          //   min: widget.rangeValues.start,
          //   max: widget.rangeValues.end,
          //   onChanged: (value) {
          //     selectedRange = value;
          //     if (widget.onChangeRange != null) {
          //       widget.onChangeRange!(value);
          //     }
          //     setState(() {});
          //     WidgetsBinding.instance.addPostFrameCallback((frame) {
          //       startTc.text = selectedRange.start.toStringAsFixed(0);
          //       endTc.text = selectedRange.end.toStringAsFixed(0);
          //     });
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: widget.minlabel,
                    readOnly: widget.isDatePicker,
                    suffix: widget.isDatePicker
                        ? const Icon(
                            Icons.calendar_month,
                            size: 18,
                          )
                        : null,
                    onTap: widget.isDatePicker
                        ? () {
                            showDatePicker(
                              context: context,
                              initialDatePickerMode: DatePickerMode.year,
                              firstDate: DateTime.now().subtract(const Duration(days: 365 * 50)),
                              lastDate: DateTime.now(),
                              initialDate: startDate,
                            ).then((val) {
                              startDate = val;
                              startTc.text = val == null ? "" : val.mmmYYY;
                              if (widget.minDateChage != null) {
                                widget.minDateChage!(val);
                              }
                            });
                          }
                        : null,
                    keyboardType: TextInputType.number,
                    controller: startTc,
                    inputFormatters: [NumberInputFormatter()],
                    onChanged: (val) {
                      final tempStart = (num.tryParse(val.replaceAll(",", "")) ?? 0).toDouble();
                      // final tempEnd = (num.tryParse(endTc.text.replaceAll(",", "")) ?? 0).toDouble();
                      selectedRange = RangeValues(tempStart, selectedRange.end);
                      if (widget.onChangeRange != null) {
                        widget.onChangeRange!(selectedRange);
                      }
                      // if (tempStart > widget.rangeValues.end) {
                      //   print("HEYYY A");
                      //   selectedRange = RangeValues(0, widget.rangeValues.end);
                      //   startTc.text = selectedRange.start.toStringAsFixed(0);
                      // } else if (tempStart < widget.rangeValues.start) {
                      //   print("HEYYY B");
                      //   selectedRange = RangeValues(0, widget.rangeValues.end);
                      //   startTc.text = selectedRange.start.toStringAsFixed(0);
                      // } else if (tempStart >= selectedRange.end) {
                      //   print("HEYYY C");
                      //   selectedRange = RangeValues(tempStart < widget.rangeValues.end ? tempStart : 0, widget.rangeValues.end);
                      //   startTc.text = selectedRange.start.toStringAsFixed(0);
                      //   endTc.text = widget.rangeValues.end.toStringAsFixed(0);
                      // } else {
                      //   print("HEYYY D");
                      //   selectedRange = RangeValues(tempStart, (num.tryParse(endTc.text) ?? 0).toDouble());
                      // }

                      // setState(() {});
                    },
                  ),
                ),
                16.spaceW,
                Expanded(
                  child: AppTextField(
                    label: widget.maxlabel,
                    suffix: widget.isDatePicker
                        ? const Icon(
                            Icons.calendar_month,
                            size: 18,
                          )
                        : null,
                    onTap: widget.isDatePicker
                        ? () {
                            showDatePicker(
                              context: context,
                              initialDatePickerMode: DatePickerMode.year,
                              firstDate: DateTime.now().subtract(const Duration(days: 365 * 50)),
                              lastDate: DateTime.now(),
                              initialDate: endDate,
                            ).then((val) {
                              endDate = val;
                              endTc.text = val == null ? '' : val.mmmYYY;
                              if (widget.maxDateChage != null) {
                                widget.maxDateChage!(val);
                              }
                            });
                          }
                        : null,
                    readOnly: widget.isDatePicker,
                    controller: endTc,
                    keyboardType: TextInputType.number,
                    inputFormatters: [NumberInputFormatter()],
                    onChanged: (val) {
                      final tempEnd = (num.tryParse(val.replaceAll(",", "")) ?? 0).toDouble();
                      selectedRange = RangeValues(selectedRange.start, tempEnd);
                      if (widget.onChangeRange != null) {
                        widget.onChangeRange!(selectedRange);
                      }
                      // if (tempEnd > widget.rangeValues.end) {
                      //   print("HEYYY A");
                      //   selectedRange = RangeValues(selectedRange.start, widget.rangeValues.end);
                      //   endTc.text = selectedRange.end.toStringAsFixed(0);
                      // } else if (tempEnd <= selectedRange.start) {
                      //   print("HEYYY C");
                      //   selectedRange = RangeValues(0, selectedRange.start);
                      //   endTc.text = selectedRange.end.toStringAsFixed(0);
                      // } else if (tempEnd < widget.rangeValues.start) {
                      //   print("HEYYY B");
                      //   selectedRange = RangeValues(selectedRange.start, widget.rangeValues.end);
                      //   endTc.text = selectedRange.end.toStringAsFixed(0);
                      // } else {
                      //   print("HEYYY D");
                      //   selectedRange = RangeValues(widget.selectedRange.start, tempEnd);
                      // }
                      // setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          16.spaceH,
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ProductFilterTile extends StatelessWidget {
  final ScrollController scrollController;
  final List<ProductFilterTileModel> items;
  const ProductFilterTile({
    super.key,
    required this.items,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: 12.smoothBorderRadius,
        color: AppColors.kWhite,
        border: Border.all(
          color: AppColors.kFoundationPurple100,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Material(
              child: InkWell(
                onTap: items[index].onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          items[index].label,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        "View All",
                        style: context.textTheme.titleMedium,
                      ),
                      8.spaceW,
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: AppColors.kFoundationPurple200,
            );
          },
          itemCount: items.length,
        ),
      ),
    );
  }
}

class ProductFilterTileModel {
  String label;
  void Function() onTap;
  ProductFilterTileModel(this.label, this.onTap);
}

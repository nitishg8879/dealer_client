import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/presentation/screens/product/products_filter_controller.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductFilterView extends StatefulWidget {
  final ProductsFilterController controller;
  const ProductFilterView({super.key, required this.controller});

  @override
  State<ProductFilterView> createState() => _ProductFilterViewState();
}

class _ProductFilterViewState extends State<ProductFilterView> {
  @override
  void initState() {
    widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        minChildSize: .2,
        maxChildSize: 1,
        expand: false,
        initialChildSize: .5,
        builder: (context, scrollController) {
          return Material(
            color: AppColors.kGrey50,
            surfaceTintColor: AppColors.kGrey50,
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ProductFilterTile(
                  items: [
                    ProductFilterTileModel("Brands", () {}),
                    ProductFilterTileModel("Category", () {}),
                  ],
                  scrollController: scrollController,
                ),
                12.spaceH,
                AppRangeSelector(
                  label: "Price",
                  minlabel: "Min",
                  maxlabel: "Max",
                  selectedRange: widget.controller.priceMinMaxSelected,
                  rangeValues: widget.controller.priceMinMax,
                  onChangeRange: (val) {
                    widget.controller.priceMinMaxSelected = val;
                  },
                ),
                12.spaceH,
                AppRangeSelector(
                  label: "Year",
                  minlabel: "Min",
                  maxlabel: "Max",
                  selectedRange: widget.controller.yearMinMaxSelected,
                  rangeValues: widget.controller.yearMinMax,
                  onChangeRange: (val) {
                    widget.controller.yearMinMaxSelected = val;
                  },
                ),
                12.spaceH,
                AppRangeSelector(
                  label: "Km Driven",
                  minlabel: "Min",
                  maxlabel: "Max",
                  selectedRange: widget.controller.kmMinMaxSelected,
                  rangeValues: widget.controller.kmMinMax,
                  onChangeRange: (val) {
                    widget.controller.kmMinMaxSelected = val;
                  },
                ),
                32.spaceH,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: context.pop,
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.doveGray),
                            ),
                        child: Text("Cancel"),
                      ),
                    ),
                    16.spaceW,
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Apply")),
                    ),
                  ],
                ),
                context.isKeyboardOpen ? 300.spaceH : 32.spaceH,
              ],
            ),
          );
        });
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
  final RangeValues selectedRange;
  final RangeValues rangeValues;
  final void Function(RangeValues val)? onChangeRange;
  const AppRangeSelector({
    super.key,
    required this.label,
    required this.minlabel,
    required this.maxlabel,
    required this.selectedRange,
    required this.rangeValues,
    this.onChangeRange,
  });

  @override
  State<AppRangeSelector> createState() => _AppRangeSelectorState();
}

class _AppRangeSelectorState extends State<AppRangeSelector> {
  late RangeValues selectedRange;
  final startTc = TextEditingController();
  final endTc = TextEditingController();
  @override
  void initState() {
    selectedRange = widget.selectedRange;
    startTc.text = selectedRange.start.toString();
    endTc.text = selectedRange.end.toString();
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
          RangeSlider(
            activeColor: AppColors.kFoundationPurple600,
            inactiveColor: AppColors.kFoundationPurple200,
            values: selectedRange,
            labels:
                RangeLabels("${selectedRange.start}", "${selectedRange.end}"),
            min: widget.rangeValues.start,
            max: widget.rangeValues.end,
            onChanged: (value) {
              selectedRange = value;
              if (widget.onChangeRange != null) {
                widget.onChangeRange!(value);
              }
              setState(() {});
              WidgetsBinding.instance.addPostFrameCallback((frame) {
                startTc.text = selectedRange.start.toStringAsFixed(0);
                endTc.text = selectedRange.end.toStringAsFixed(0);
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: widget.minlabel,
                    keyboardType: TextInputType.number,
                    controller: startTc,
                    onChanged: (val) {
                      final tempStart = (num.tryParse(val) ?? 0).toDouble();
                      if (tempStart > widget.rangeValues.end) {
                        print("HEYYY A");
                        selectedRange = RangeValues(0, widget.rangeValues.end);
                        startTc.text = selectedRange.start.toStringAsFixed(0);
                      } else if (tempStart < widget.rangeValues.start) {
                        print("HEYYY B");
                        selectedRange = RangeValues(0, widget.rangeValues.end);
                        startTc.text = selectedRange.start.toStringAsFixed(0);
                      } else if (tempStart >= selectedRange.end) {
                        print("HEYYY C");
                        selectedRange = RangeValues(
                            tempStart < widget.rangeValues.end ? tempStart : 0,
                            widget.rangeValues.end);
                        startTc.text = selectedRange.start.toStringAsFixed(0);
                        endTc.text = widget.rangeValues.end.toStringAsFixed(0);
                      } else {
                        print("HEYYY D");
                        selectedRange = RangeValues(tempStart,
                            (num.tryParse(endTc.text) ?? 0).toDouble());
                      }
                      if (widget.onChangeRange != null) {
                        widget.onChangeRange!(selectedRange);
                      }
                      setState(() {});
                    },
                  ),
                ),
                16.spaceW,
                Expanded(
                  child: AppTextField(
                    label: widget.maxlabel,
                    controller: endTc,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      final tempEnd = (num.tryParse(val) ?? 0).toDouble();

                      if (tempEnd > widget.rangeValues.end) {
                        print("HEYYY A");
                        selectedRange = RangeValues(
                            selectedRange.start, widget.rangeValues.end);
                        endTc.text = selectedRange.end.toStringAsFixed(0);
                      } else if (tempEnd <= selectedRange.start) {
                        print("HEYYY C");
                        selectedRange = RangeValues(0, selectedRange.start);
                        endTc.text = selectedRange.end.toStringAsFixed(0);
                      } else if (tempEnd < widget.rangeValues.start) {
                        print("HEYYY B");
                        selectedRange = RangeValues(
                            selectedRange.start, widget.rangeValues.end);
                        endTc.text = selectedRange.end.toStringAsFixed(0);
                      } else {
                        print("HEYYY D");
                        selectedRange =
                            RangeValues(widget.selectedRange.start, tempEnd);
                      }
                      if (widget.onChangeRange != null) {
                        widget.onChangeRange!(selectedRange);
                      }
                      setState(() {});
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
            return Padding(
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

import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductFilterView extends StatefulWidget {
  const ProductFilterView({super.key});

  @override
  State<ProductFilterView> createState() => _ProductFilterViewState();
}

class _ProductFilterViewState extends State<ProductFilterView> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        minChildSize: .5,
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
                const AppRangeSelector(
                  label: "Price",
                  minlabel: "Min",
                  maxlabel: "Max",
                  selectedRange: RangeValues(0, 20),
                ),
                12.spaceH,
                const AppRangeSelector(
                  label: "Year",
                  minlabel: "Min",
                  maxlabel: "Max",
                  selectedRange: RangeValues(0, 20),
                ),
                12.spaceH,
                const AppRangeSelector(
                  label: "Km Driven",
                  minlabel: "Min",
                  maxlabel: "Max",
                  selectedRange: RangeValues(0, 20),
                ),
                32.spaceH,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: context.pop,
                        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              backgroundColor: WidgetStatePropertyAll(AppColors.doveGray),
                            ),
                        child: Text("Cancel"),
                      ),
                    ),
                    16.spaceW,
                    Expanded(
                      child: ElevatedButton(onPressed: () {}, child: Text("Apply")),
                    ),
                  ],
                ),
                32.spaceH,
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
  const AppRangeSelector({
    super.key,
    required this.label,
    required this.minlabel,
    required this.maxlabel,
    required this.selectedRange,
  });

  @override
  State<AppRangeSelector> createState() => _AppRangeSelectorState();
}

class _AppRangeSelectorState extends State<AppRangeSelector> {
  var selectedPriceRange = const RangeValues(0, 20);
  @override
  void initState() {
    selectedPriceRange = widget.selectedRange;
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
            values: selectedPriceRange,
            divisions: 50,
            labels: RangeLabels("${selectedPriceRange.start}", "${selectedPriceRange.end}"),
            min: 0,
            max: 100,
            onChanged: (value) {
              selectedPriceRange = value;
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: widget.minlabel,
                  ),
                ),
                16.spaceW,
                Expanded(
                  child: AppTextField(
                    label: widget.maxlabel,
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

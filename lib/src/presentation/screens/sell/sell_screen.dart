import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/app_text_input_formatter.dart';
import 'package:bike_client_dealer/src/presentation/cubit/sell/sell_cubit.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final cubit = SellCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        onback: context.pop,
        pageName: "Sell",
        actions: [
          UnconstrainedBox(
            child: OutlinedButton(
              onPressed: () => cubit.openSellForm(context),
              child: const Icon(
                Icons.add_circle_outline,
                color: AppColors.kBlack900,
              ),
            ),
          ),
          16.spaceW,
        ],
      ),
      body: SizedBox(),
    );
  }
}

import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/presentation/cubit/sell/sell_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/sell/sell_product_card_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final cubit = SellCubit();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      cubit.fetchSellProducts();
    });
  }

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
      body: BlocBuilder<SellCubit, SellState>(
        bloc: cubit,
        buildWhen: (previous, current) => current is! SellUploading,
        builder: (context, state) {
          if (state is SellLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SellError) {
            return ErrorView(
              errorMsg: state.errorMsg,
              onreTry: cubit.fetchSellProducts,
            );
          }
          if (state is SellLoaded) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text("No Sell Found."),
              );
            }
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return SellProductCard(
                  model: state.data[index],
                  onTap: () => cubit.openSellForm(context, data: state.data[index]),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

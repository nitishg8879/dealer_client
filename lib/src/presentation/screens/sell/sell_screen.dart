import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/app_text_input_formatter.dart';
import 'package:bike_client_dealer/src/presentation/cubit/sell/sell_cubit.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_text_field.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:flutter/foundation.dart';
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
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => cubit.openSellForm(context, data: state.data[index]),
                  title: Text(state.data[index].name ?? '-'),
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

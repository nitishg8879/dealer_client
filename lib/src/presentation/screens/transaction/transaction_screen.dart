import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final bloc = TransactionCubit(getIt.get());
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((frame) => bloc.fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        onback: context.pop,
        pageName: "Transaction",
      ),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is TransactionError) {
            return Center(child: ErrorView(onreTry: fetchData, errorMsg: state.error));
          }
          if (state is TransactionLoading) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                        txn: TransactionsModel(
                      transactionsType: TransactionsType.success,
                      amount: 1323,
                      label: "2232dsfdf",
                      failedReason: "failedReason",
                      txnDateTime: Timestamp.now(),
                      userId: "userId",
                      productId: "productId",
                      paymentId: '',
                    ));
                  },
                ),
              ),
            );
          }
          if (state is TransactionLoaded) {
            if (state.list.isEmpty) {
              return const Center(
                child: Text("No Transaction found"),
              );
            }
            return RefreshIndicator(
              onRefresh: bloc.fetchData,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 16 : 0, bottom: 16),
                    child: TransactionCard(txn: state.list[index]),
                  );
                },
              ),
            );
          }
          return const Center(
            child: Text("W.S contact to admin."),
          );
        },
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final TransactionsModel txn;
  const TransactionCard({super.key, required this.txn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: ShapeDecoration(
        color: AppColors.kWhite,
        shape: SmoothRectangleBorder(
          borderRadius: 22.smoothBorderRadius,
          side: const BorderSide(
            color: Color(0xffE0E8F2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: ShapeDecoration(
              color: AppColors.blueColor.withOpacity(.3),
              shape: SmoothRectangleBorder(
                borderRadius: 12.smoothBorderRadius,
                side: const BorderSide(
                  color: Color(0xffE0E8F2),
                ),
              ),
            ),
            child: icon,
          ),
          10.spaceW,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.label ?? '-',
                  style: context.textTheme.headlineSmall,
                ),
                3.spaceH,
                Text(
                  txn.failedReason ?? '-',
                  style: context.textTheme.titleMedium,
                ),
                5.spaceH,
                Text(
                  'Transaction ID',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: const Color(0xff26273A).withOpacity(.4),
                  ),
                ),
                3.spaceH,
                Text(
                  txn.paymentId ?? '-',
                  style: context.textTheme.titleSmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                txn.amount.to2DecimalINR,
                style: context.textTheme.headlineSmall,
              ),
              5.spaceH,
              Skeleton.ignore(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: txn.transactionsType?.color.withOpacity(.3),
                    borderRadius: 4.borderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      txn.transactionsType?.name ?? '-',
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: txn.transactionsType?.color,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              5.spaceH,
              Text(
                txn.txnDateTime == null ? '-' : DateFormat('dd MMM yyyy\nhh:mm a').format(txn.txnDateTime!.toDate()),
                textAlign: TextAlign.end,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget get icon => switch (txn.transactionsType) {
        TransactionsType.success => const Icon(
            Icons.arrow_outward_rounded,
          ),
        TransactionsType.fail => const Icon(
            Icons.cancel,
          ),
        TransactionsType.refund => Transform.rotate(
            angle: -1,
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        null => throw UnimplementedError(),
      };
}

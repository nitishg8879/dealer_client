import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/src/data/model/transaction_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/transaction/transaction_card_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
                      userName: [],
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

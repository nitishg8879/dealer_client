import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/order/order_cubit.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final bloc = OrderCubit(getIt.get(), getIt.get());
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
    WidgetsBinding.instance.addPostFrameCallback((frame) => bloc.fetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        onback: context.pop,
        pageName: "Orders",
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is OrderError) {
            return Center(child: ErrorView(onreTry: fetchData, errorMsg: state.errorMsg));
          }
          if (state is OrderLoading) {
            return Skeletonizer(
              enabled: true,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return OrderCard(
                    order: OrderTransactionModel(
                      txnId: "txnId",
                      userId: "userId",
                      createdTime: Timestamp.now(),
                      validTill: Timestamp.now(),
                      productId: "productId",
                      status: [], paymentId: '',
                    ),
                    bloc: bloc,
                  );
                },
              ),
            );
          }
          if (state is OrderLoaded) {
            if (state.orders.isEmpty) {
              return const Center(
                child: Text("No Orders found."),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: index == 0 ? 16 : 0, bottom: 16),
                  child: OrderCard(order: state.orders[index], bloc: bloc),
                );
              },
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

class OrderCard extends StatelessWidget {
  final OrderTransactionModel order;
  final OrderCubit bloc;
  const OrderCard({super.key, required this.order, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(order.txnId),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.spaceH,
          Text("Status: ${order.status.map((e) => e.displayName).toList()}"),
          16.spaceH,
          Row(
            children: [
              if (order.status.contains(BookingStatus.RefundIntiated))
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Show Refund Status"),
                  ),
                )
              else
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      bloc.cancelAndRefund(order.id!);
                    },
                    child: Text("Cancel & Refund"),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

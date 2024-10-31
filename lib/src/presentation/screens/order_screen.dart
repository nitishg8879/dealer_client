import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/routes/app_routes.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/product_data_source.dart';
import 'package:bike_client_dealer/src/data/model/order_transaction_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/order/order_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/transaction/transaction_card_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/confirmation_dialog.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
            return const Center(
              child: CircularProgressIndicator(),
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
    return FutureBuilder<DataState<ProductModel?>>(
      future: getIt.get<ProductDataSource>().fetchProductbyId(order.productId ?? '-'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          final data = snapshot.data?.data;
          if (snapshot.data is DataSuccess) {
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //? Image
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.productDetails, extra: data.id);
                        },
                        child: ClipRRect(
                          borderRadius: 6.smoothBorderRadius,
                          child: CachedNetworkImage(
                            imageUrl: data!.images!.first,
                            width: context.width * .3,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      10.spaceW,
                      //? Refund button
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name ?? '-',
                              style: context.textTheme.headlineSmall,
                            ),
                            8.spaceH,
                            Wrap(
                              spacing: 8,
                              children: [
                                //? Model
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomSvgIcon(
                                      assetName: AppAssets.calender,
                                      color: AppColors.kFoundationPurple700.withOpacity(.8),
                                      size: 14,
                                    ),
                                    3.spaceW,
                                    Text(
                                      data.bikeBuyDate?.toDate().mmyy ?? '-',
                                      style: context.textTheme.titleSmall?.copyWith(
                                        color: AppColors.kBlack900.withOpacity(.8),
                                      ),
                                    ),
                                  ],
                                ),
                                //? Owners
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomSvgIcon(
                                      assetName: AppAssets.users,
                                      color: AppColors.kFoundationPurple700.withOpacity(.8),
                                      size: 14,
                                    ),
                                    3.spaceW,
                                    Text(
                                      "${data.owners ?? '-'}",
                                      style: context.textTheme.titleSmall?.copyWith(
                                        color: AppColors.kBlack900.withOpacity(.8),
                                      ),
                                    ),
                                  ],
                                ),

                                //? KM Driven
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomSvgIcon(
                                      assetName: AppAssets.distance,
                                      color: AppColors.kFoundationPurple700.withOpacity(.8),
                                      size: 14,
                                    ),
                                    3.spaceW,
                                    Text(
                                      data.kmDriven.readableNumber,
                                      style: context.textTheme.titleSmall?.copyWith(
                                        color: AppColors.kBlack900.withOpacity(.8),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            8.spaceH,
                            if (!(order.status.contains(BookingStatus.RefundIntiated))) ...[
                              12.spaceH,
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ConfirmationDialog(
                                        titleText: "Alert",
                                        contentText: "Are you sure you want to cancel this order your money also get refunded within 2-3 days.",
                                        onConfirm: () {
                                          context.pop();
                                          bloc.cancelAndRefund(order.id!);
                                        },
                                        confirmButtonText: "Confirm",
                                      );
                                    },
                                  );
                                },
                                borderRadius: 6.smoothBorderRadius,
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: 6.smoothBorderRadius,
                                  ),
                                  color: AppColors.kFoundatiionPurple800,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      (order.validTill!.toDate().isAfter(DateTime.now()) ? "Cancel And Refund" : "Refund"),
                                      style: context.textTheme.bodyLarge?.copyWith(
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              12.spaceH,
                              Text(
                                order.rejectReason ?? '',
                                style: context.textTheme.titleSmall,
                              ),
                            ],
                            Text(order.rejectReason ?? '')
                          ],
                        ),
                      ),
                      //? Transaction
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              bloc.fetchTransactionById(order.txnId!).then((val) {
                                showModalBottomSheet(
                                  context: AppRoutes.rootNavigatorKey.currentContext!,
                                  useSafeArea: true,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: 16.smoothRadius)),
                                  showDragHandle: true,
                                  enableDrag: true,
                                  isScrollControlled: false,
                                  builder: (context) => Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: SizedBox(
                                      height: 125,
                                      child: TransactionCard(txn: val),
                                    ),
                                  ),
                                );
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_outward_rounded),
                            ),
                          ),
                          if (order.refundtxnId != null)
                            InkWell(
                              onTap: () {
                                bloc.fetchTransactionById(order.refundtxnId ?? '-').then((val) {
                                  showModalBottomSheet(
                                    context: AppRoutes.rootNavigatorKey.currentContext!,
                                    useSafeArea: true,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: 16.smoothRadius)),
                                    showDragHandle: true,
                                    enableDrag: true,
                                    isScrollControlled: false,
                                    builder: (context) => IntrinsicHeight(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: SizedBox(
                                          // height: 125,
                                          child: TransactionCard(txn: val),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Transform.rotate(
                                  angle: -1,
                                  child: const Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  16.spaceH,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: order.status
                          .map((e) => DecoratedBox(
                                decoration: BoxDecoration(
                                  color: e.color.withOpacity(.3),
                                  borderRadius: 4.borderRadius,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    e.name,
                                    style: context.textTheme.headlineSmall?.copyWith(
                                      color: e.color,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  8.spaceH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildTitleAndSubTitle(
                        context,
                        "Creation Date",
                        order.createdTime?.toDate().orderTime ?? '',
                        cross: CrossAxisAlignment.start,
                      ),
                      if (!(order.status!.contains(BookingStatus.RefundIntiated) ||
                          order.status!.contains(BookingStatus.AutoRejected) ||
                          order.status!.contains(BookingStatus.RejectedByAdmin)))
                        buildTitleAndSubTitle(
                          context,
                          "Valid Till",
                          order.validTill!.toDate().orderTime,
                        ),
                    ],
                  ),
                ],
              ),
            );
          }
          if (snapshot.data is DataFailed) {
            return Center(child: Text(snapshot.data?.message ?? "Something wen't wrong."));
          }
          return const Text("Wrong state");
        }
      },
    );
  }

  Widget buildTitleAndSubTitle(
    BuildContext context,
    String title,
    String subtitle, {
    CrossAxisAlignment cross = CrossAxisAlignment.end,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: cross,
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium,
        ),
        Text(
          subtitle,
          style: context.textTheme.displayMedium,
        ),
      ],
    );
  }
}

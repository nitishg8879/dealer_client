import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_fav.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel? product;
  final String? id;
  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.id,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final scrollController = ScrollController();
  final productDetailsCubit = ProductDetailsCubit(getIt.get());
  late Razorpay razorpay;

  @override
  void initState() {
    razorpay = Razorpay();
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    productDetailsCubit.close();
    super.dispose();
  }

  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback(
        (frame) => productDetailsCubit.fetchProduct(widget.id, widget.product));
  }

  void showPaymentAcceptDialog() {
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.open({
      'key': 'rzp_test_cjoyPTL0PCSecr',
      'amount': 1,
      'name': 'F3 Motors',
      'description': 'Fine T-Shirt',
      'prefill': {
        "name": "Nitish Gupta",
        'contact': '8879753332',
        'email': 'test@razorpay.com',
      },
      'retry': {'enabled': true, 'max_count': 0},
      "theme": {"color": "#360083"},
    });
  }

  //Handle Payment Responses
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    razorpay.clear();
    showAlertDialog(
      context,
      "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}",
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    razorpay.clear();
    showAlertDialog(
      context,
      "Payment Successful",
      "Payment ID: ${response.paymentId} Data:${response.data} Order Id:${response.orderId}",
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    // Widget continueButton = ElevatedButton(
    //   child: const Text("Continue"),
    //   onPressed: () {},
    // );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product == null && widget.id == null) {
      return const Scaffold(
        body: Center(child: Text("No Product Details found.")),
      );
    }
    return Scaffold(
      appBar: _buildAppbar(context),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        bloc: productDetailsCubit,
        buildWhen: (previous, current) => (current is ProductDetailsLoading ||
            current is ProductDetailsLoaded ||
            current is ProductDetailsHasError),
        builder: (context, state) {
          return Skeletonizer(
            enabled: state is ProductDetailsLoading,
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: _floatActionBtn(context),
              body: _buildbody((state is ProductDetailsLoading)
                  ? dummyProduct
                  : (state as ProductDetailsLoaded).productModel),
            ),
          );
        },
      ),
    );
  }

  Material _floatActionBtn(BuildContext context) {
    return Material(
      color: AppColors.kWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.push(Routes.chats),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kBlack900,
                  shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.all(
                      SmoothRadius(
                        cornerRadius: 12,
                        cornerSmoothing: 1,
                      ),
                    ),
                    side: BorderSide(
                      color: AppColors.kFoundationPurple100,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomSvgIcon(
                      assetName: AppAssets.chat,
                      color: AppColors.kWhite,
                      size: 20,
                    ),
                    8.spaceW,
                    const Text("Negotaiate"),
                  ],
                ),
              ),
            ),
            16.spaceW,
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showPaymentAcceptDialog();
                },
                style: ElevatedButton.styleFrom(
                  shape: const SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius.all(
                      SmoothRadius(
                        cornerRadius: 12,
                        cornerSmoothing: 1,
                      ),
                    ),
                    side: BorderSide(
                      color: AppColors.kFoundationPurple100,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomSvgIcon(
                      assetName: AppAssets.wallet,
                      color: AppColors.kWhite,
                      size: 20,
                    ),
                    8.spaceW,
                    Text("Book at ${100.toINR}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppAppbar _buildAppbar(BuildContext context) {
    return AppAppbar(
      onback: context.pop,
      elevation: 2,
      actions: [
        UnconstrainedBox(
          child: OutlinedButton(
            onPressed: () {},
            child: const CustomSvgIcon(
              assetName: AppAssets.share,
              color: AppColors.kCardGrey400,
              size: 20,
            ),
          ),
        ),
        16.spaceW,
      ],
    );
  }

  Widget _buildbody(ProductModel product) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      children: [
        Skeleton.replace(
          replace: true,
          width: double.infinity,
          height: context.height * .45,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: context.height * .45,
              maxWidth: double.infinity,
            ),
            child: CarouselView(
              itemExtent: context.width,
              shape: const RoundedRectangleBorder(),
              padding: EdgeInsets.zero,
              itemSnapping: true,
              children: product.images
                      ?.map(
                        (e) => CachedNetworkImage(
                          width: context.width,
                          fit: BoxFit.cover,
                          imageUrl: e,
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ),
        ),
        // Container(
        //   color: AppColors.kWhite,
        //   height: 300,
        //   child: Stack(
        //     fit: StackFit.expand,
        //     children: [
        //       CarouselView(
        //         itemExtent: context.width,
        //         shape: const RoundedRectangleBorder(),
        //         padding: EdgeInsets.zero,
        //         itemSnapping: true,
        //         children: product.images
        //                 ?.map(
        //                   (e) => CachedNetworkImage(
        //                     width: context.width,
        //                     fit: BoxFit.cover,
        //                     imageUrl: e,
        //                   ),
        //                 )
        //                 .toList() ??
        //             [],
        //       ),
        //       // ListView(
        //       //   physics: const BouncingScrollPhysics(),
        //       //   scrollDirection: Axis.horizontal,
        //       //   controller: scrollController,
        //       //   children: product.images
        //       //           ?.map(
        //       //             (e) => Padding(
        //       //               padding: const EdgeInsets.only(right: 16),
        //       //               child: CachedNetworkImage(
        //       //                 width: context.width,
        //       //                 fit: BoxFit.cover,
        //       //                 imageUrl: e,
        //       //               ),
        //       //             ),
        //       //           )
        //       //           .toList() ??
        //       //       [],
        //       // ),
        //       Positioned(
        //         top: 8,
        //         right: 8,
        //         child: Skeleton.ignore(
        //           child: DecoratedBox(
        //             decoration: const ShapeDecoration(
        //               color: AppColors.kBlack900,
        //               shape: SmoothRectangleBorder(
        //                 borderRadius: SmoothBorderRadius.all(
        //                   SmoothRadius(cornerRadius: 8, cornerSmoothing: 1),
        //                 ),
        //                 side: BorderSide(
        //                   color: AppColors.kFoundationPurple100,
        //                 ),
        //               ),
        //             ),
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        //               child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        //                 bloc: productDetailsCubit,
        //                 // buildWhen: (previous, current) => current is ProductDetailsImagePosition,
        //                 builder: (context, state) {
        //                   print("building image pos");
        //                   if (state is ProductDetailsImagePosition) {
        //                     return Text(
        //                       "${state.current} / ${state.total}",
        //                       style: context.textTheme.bodyLarge?.copyWith(
        //                         color: AppColors.white,
        //                       ),
        //                     );
        //                   }
        //                   return const SizedBox();
        //                 },
        //               ),
        //             ),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.spaceH,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name ?? "-",
                      style: context.textTheme.headlineSmall,
                    ),
                  ),
                  ProductFav(id: widget.product?.id ?? '-')
                  // IconButton(
                  //   padding: EdgeInsets.zero,
                  //   constraints: const BoxConstraints.expand(width: 24, height: 24),
                  //   onPressed: () {},
                  //   icon: Skeleton.ignore(
                  //     child: CustomSvgIcon(
                  //       assetName: AppAssets.favFill,
                  //       color: AppColors.kRed,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              4.spaceH,
              Text(
                75000.toINR,
                style: context.textTheme.headlineSmall,
              ),
              4.spaceH,
              Text(
                product.description ?? '-',
                style: context.textTheme.titleMedium,
              ),
              32.spaceH,
              Material(
                shape: SmoothRectangleBorder(
                  borderRadius: 12.smoothBorderRadius,
                  borderAlign: BorderAlign.inside,
                ),
                color: AppColors.kWhite,
                shadowColor: AppColors.kFoundationPurple100,
                elevation: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Details",
                        style: context.textTheme.labelMedium,
                      ),
                      16.spaceH,
                      titleSubtitle(
                          "KM Driven", product.kmDriven.readableNumber,
                          assetName: AppAssets.distance),
                      titleSubtitle("Buy Date",
                          product.bikeBuyDate?.toDate().mmmYYY ?? "-",
                          assetName: AppAssets.calender),
                      titleSubtitle("Insaurance Validity",
                          product.insauranceValidity?.toDate().mmmYYY ?? "-",
                          assetName: AppAssets.calender),
                      titleSubtitle("Valid Till",
                          product.bikeValidTill?.toDate().mmmYYY ?? "-",
                          assetName: AppAssets.calenderTill),
                      titleSubtitle("Number Plate", product.numberPlate ?? "-",
                          assetName: AppAssets.distance),
                      titleSubtitle(
                          "Tyre Condition", product.tyreCondition ?? '-',
                          assetName: AppAssets.distance),
                      titleSubtitle("Fine", product.fine.readableNumber,
                          assetName: AppAssets.fine),
                      titleSubtitle("Owners", product.owners.readableNumber,
                          wantDivider: false, assetName: AppAssets.users),
                    ],
                  ),
                ),
              ),
              32.spaceH,
              Material(
                shape: SmoothRectangleBorder(
                  borderRadius: 12.smoothBorderRadius,
                  borderAlign: BorderAlign.inside,
                ),
                color: AppColors.kWhite,
                shadowColor: AppColors.kFoundationPurple100,
                elevation: 8,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Default Details",
                        style: context.textTheme.labelMedium,
                      ),
                      16.spaceH,
                      titleSubtitle("Wheel", "2", assetName: AppAssets.wheel),
                      titleSubtitle("Engine cc", "124",
                          assetName: AppAssets.wheel),
                      titleSubtitle("Launch date", "2 Sep 2024",
                          assetName: AppAssets.calender),
                      titleSubtitle("On Road Price", "1,75,000",
                          assetName: AppAssets.wheel),
                      titleSubtitle("Company", "Honda",
                          assetName: AppAssets.company),
                      titleSubtitle("Mileage", "30-40km",
                          wantDivider: false, assetName: AppAssets.mileage),
                    ],
                  ),
                ),
              ),
              100.spaceH,
            ],
          ),
        ),
      ],
    );
  }

  Widget titleSubtitle(
    String label,
    String value, {
    bool wantDivider = true,
    String? assetName,
  }) {
    return Column(
      children: [
        4.spaceH,
        Row(
          children: [
            if (assetName != null) ...[
              // 4.spaceW,
              Skeleton.replace(
                replacement: const Bone.square(size: 16),
                child: CustomSvgIcon(
                  assetName: assetName,
                  color: AppColors.kFoundationPurple700.withOpacity(.8),
                  size: 18,
                ),
              ),
              16.spaceW,
            ],
            Expanded(
              child: Text(
                label,
                style: context.textTheme.displaySmall,
              ),
            ),
            Text(
              value,
              style: context.textTheme.titleSmall?.copyWith(
                color: AppColors.kBlack900.withOpacity(.8),
              ),
            ),
          ],
        ),
        4.spaceH,
        if (wantDivider)
          const Divider(
            color: AppColors.kFoundationPurple100,
          )
      ],
    );
  }
}

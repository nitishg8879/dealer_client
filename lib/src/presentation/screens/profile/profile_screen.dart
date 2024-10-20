import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/services/app_local_service.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/profile/edit_profile_view.dart';
import 'package:bike_client_dealer/src/presentation/screens/profile/profile_tile_section.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final boxShadow = [
    BoxShadow(
      color: Colors.grey.shade100,
      blurRadius: 10.0,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        onback: context.pop,
        pageName: "Profile",
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          24.spaceH,

          //? Profile
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: 64.borderRadius,
              boxShadow: boxShadow,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: 100.borderRadius,
                    child: CachedNetworkImage(
                      height: 34,
                      width: 34,
                      fit: BoxFit.cover,
                      imageUrl: getIt.get<AppLocalService>().currentUser?.profileUrl ?? '-',
                    ),
                  ),
                  9.spaceW,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getIt.get<AppLocalService>().currentUser?.fullName ?? '-',
                          style: context.textTheme.displaySmall,
                        ),
                        Text(
                          getIt.get<AppLocalService>().currentUser?.email ?? '-',
                          style: context.textTheme.titleSmall?.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: AppColors.kPurple60,
                    // surfaceTintColor: AppColors.kPurple60.withOpacity(.1),
                    borderRadius: 100.borderRadius,
                    child: InkWell(
                      onTap: () {
                        // context.pushNamed(Routes.editProfile);
                        showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          isDismissible: true,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                          builder: (context) {
                            return EditProfileView(
                              fullName: getIt.get<AppLocalService>().currentUser?.fullName,
                              phoneNo: getIt.get<AppLocalService>().currentUser?.phoneNumber,
                              email: getIt.get<AppLocalService>().currentUser?.email,
                            );
                          },
                        ).then((result) {
                          if (result is bool && result) {
                            setState(() {});
                          }
                        });
                      },
                      borderRadius: 100.borderRadius2,
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.mode_edit_outline_outlined,
                          color: AppColors.kFoundationPurple400,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          24.spaceH,

          //? General
          ProfileTileSelection(
            title: "General",
            items: [
              ProfileTileTileModel(
                icon: Icons.message_outlined,
                titile: "Chats",
                routePath: Routes.chats,
              ),
              ProfileTileTileModel(
                icon: Icons.support_agent,
                titile: "Contact Us",
                routePath: Routes.home,
              ),
              ProfileTileTileModel(
                icon: Icons.location_on_outlined,
                titile: "Branches",
                routePath: Routes.home,
              ),
            ],
          ),

          //? Products
          24.spaceH,
          ProfileTileSelection(
            title: "Products",
            items: [
              ProfileTileTileModel(
                icon: Icons.account_balance_outlined,
                titile: "Transactions",
                routePath: Routes.transaction,
              ),
              ProfileTileTileModel(
                icon: Icons.playlist_add_check_circle_outlined,
                titile: "Orders",
                routePath: Routes.order,
              ),
              ProfileTileTileModel(
                icon: Icons.favorite_border,
                titile: "Favourites",
                routePath: Routes.favourite,
              ),
              ProfileTileTileModel(
                icon: Icons.sell_outlined,
                titile: "Sell",
                routePath: Routes.sell,
              ),
            ],
          ),
          24.spaceH,
          OutlinedButton(
            onPressed: () async {
              await getIt.get<AuthCubit>().logout();
              HelperFun.goBack();
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.kRed, width: 1),
              fixedSize: const Size(double.infinity, 42),
              foregroundColor: AppColors.kRed,
              textStyle: context.textTheme.labelSmall?.copyWith(fontSize: 14),
            ),
            child: const Text("Logout"),
          ),
          100.spaceH,
        ],
      ),
    );
  }
}

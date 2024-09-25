import 'package:bike_client_dealer/config/routes/app_routes.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/config/themes/app_theme.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/presentation/cubit/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPopupViewDialogShow {
  static show({void Function()? tap}) {
    showModalBottomSheet(
      context: AppRoutes.rootNavigatorKey.currentContext!,
      isDismissible: true,
      showDragHandle: true,
      backgroundColor: AppColors.kCommonGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: 12.smoothRadius,
        ),
      ),
      builder: (context) {
        return AuthPopupView(tap: tap);
      },
    );
  }
}

class AuthPopupView extends StatelessWidget {
  final void Function()? tap;
  const AuthPopupView({super.key, this.tap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: getIt.get<AuthCubit>(),
      builder: (context, state) {
        final isLoading = (state is AuthProcessing && state.isLoading);
        return SizedBox(
          height: 100,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => getIt.get<AuthCubit>().login(ontap: tap),
                  style: ElevatedButton.styleFrom(
                    textStyle: context.textTheme.bodyMedium,
                    backgroundColor: AppColors.kWhite,
                    elevation: 3,
                    shape:
                        RoundedRectangleBorder(borderRadius: 12.borderRadius),
                    foregroundColor: AppColors.black,
                  ),
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              color: AppColors.kFoundatiionPurple800,
                              strokeWidth: 1.5,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              AppAssets.googlePNG,
                              width: 24,
                              height: 24,
                            ),
                            16.spaceW,
                            Text(
                              "Continue with Google",
                              style: context.textTheme.displayLarge?.copyWith(
                                color: AppColors.kCardGrey400,
                              ),
                            ),
                          ],
                        ),
                ),
                16.spaceH,
              ],
            ),
          ),
        );
      },
    );
  }
}

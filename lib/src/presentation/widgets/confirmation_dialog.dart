import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.titleText,
    required this.contentText,
    super.key,
    this.icon,
    this.cancelButtonText,
    this.confirmButtonText,
    this.confirmButtonStyle,
    this.onConfirm,
    this.onlyPrimaryBtn = false,
  });
  final String titleText;
  final String? icon;
  final String contentText;
  final String? cancelButtonText;
  final String? confirmButtonText;
  final ButtonStyle? confirmButtonStyle;
  final VoidCallback? onConfirm;
  final bool onlyPrimaryBtn;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: 32.borderRadius,
      ),
      contentTextStyle: context.textTheme.bodyLarge,
      titleTextStyle: context.textTheme.headlineSmall,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(titleText),
      content: SizedBox(
        width: context.width - 32,
        child: Text(
          contentText,
          style: context.textTheme.bodyLarge,
        ),
      ),
      actions: [
        Row(
          children: [
            if (!onlyPrimaryBtn)
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.kCommonGrey,
                      foregroundColor: AppColors.kBlack900,
                      elevation: 0,
                      shape: const StadiumBorder(),
                      textStyle: context.textTheme.titleMedium,
                    ),
                    onPressed: context.pop,
                    child: Text(cancelButtonText ?? 'Close'),
                  ),
                ),
              ),
            if (confirmButtonText != null) ...[
              if (!onlyPrimaryBtn) 16.spaceW,
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      // padding: Get.width > 450 ? const EdgeInsets.symmetric(horizontal: 24, vertical: 16) : null,
                      enableFeedback: true,
                      backgroundColor: AppColors.kFoundationPurple700,
                      foregroundColor: AppColors.kWhite,
                      elevation: 0,
                      shape: const StadiumBorder(),
                      textStyle: context.textTheme.titleMedium?.copyWith(color: AppColors.kWhite),
                    ),
                    onPressed: onConfirm != null ? onConfirm!.call : context.pop,
                    child: Text(confirmButtonText!),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

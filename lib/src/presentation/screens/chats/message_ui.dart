import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_enums.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/data/model/chat_model.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class MessageUI extends StatelessWidget {
  final ChatModel chatModel;
  const MessageUI({super.key, required this.chatModel});

  @override
  Widget build(BuildContext context) {
    final borderRadius = 14.smoothRadius;
    return Align(
      alignment: chatModel.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: AppColors.kFoundationPurple700,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.only(
              topRight: borderRadius,
              topLeft: chatModel.isSender ? borderRadius : 0.smoothRadius,
              bottomLeft: borderRadius,
              bottomRight: chatModel.isSender ? 0.smoothRadius : borderRadius,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (chatModel.chatType == chatsRowType.imageWithText)
                Image.asset(
                  chatModel.image!,
                ),
              Text(
                chatModel.message,
                style: context.textTheme.displayMedium?.copyWith(
                  color: AppColors.kWhite,
                  fontSize: 14,
                ),
              ),
              Text(
                chatModel.dateTime.hhmma,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.kFoundationWhite600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

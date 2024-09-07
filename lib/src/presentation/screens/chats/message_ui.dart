import 'dart:async';

import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_enums.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/data/model/chat_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/chat_doc_view.dart';
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
          color: AppColors.kFoundationPurple100,
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
            // crossAxisAlignment: chatModel.isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatDocView(
                files: chatModel.doc ?? [],
                width: (chatModel.doc ?? []).length < 4 ? (80 * (chatModel.doc ?? []).length).toDouble() : (80 * 4),
                readOnly: true,
              ),
              ChatUIForNormalText(chatModel: chatModel),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatUIForNormalText extends StatelessWidget {
  final ChatModel chatModel;
  const ChatUIForNormalText({
    super.key,
    required this.chatModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          chatModel.message,
          style: context.textTheme.displayMedium,
        ),
        Text(
          chatModel.dateTime.hhmma,
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}

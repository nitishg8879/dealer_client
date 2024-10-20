import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/src/data/model/chat_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/chat_doc_view.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class MessageUI extends StatelessWidget {
  final Conversation chat;
  const MessageUI({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final borderRadius = 14.smoothRadius;
    return Align(
      alignment: (chat.isSender) ? Alignment.centerRight : Alignment.centerLeft,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: chat.isSender ? AppColors.kFoundationPurple200 : AppColors.kPurple60,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.only(
              topRight: borderRadius,
              topLeft: chat.isSender ? borderRadius : 0.smoothRadius,
              bottomLeft: borderRadius,
              bottomRight: chat.isSender ? 0.smoothRadius : borderRadius,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: chat.isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (chat.documensts != null && chat.documensts!.isNotEmpty)
                // ChatDocView(
                //   files: chat.documensts ?? [],
                //   width: (chat.documensts ?? []).length < 4 ? (80 * (chat.documensts ?? []).length).toDouble() : (80 * 4),
                //   readOnly: true,
                // ),
                if (chat.productID != null)
                  // ProductView(
                  // product: chat.product!,
                  //   fromChatReadyOnly: true,
                  // ),
                  ChatUIForNormalText(chat: chat),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatUIForNormalText extends StatelessWidget {
  final Conversation chat;
  const ChatUIForNormalText({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          chat.message ?? '',
          style: context.textTheme.displayMedium,
        ),
        Text(
          chat.time?.toDate().hhmma ?? '',
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}

import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/di/injector.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/data_state.dart';
import 'package:bike_client_dealer/src/data/data_sources/product_data_source.dart';
import 'package:bike_client_dealer/src/data/model/chat_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/chat_doc_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class MessageUI extends StatelessWidget {
  final Conversation chat;
  final Function(ProductModel pm) onLoadProduct;
  const MessageUI({
    super.key,
    required this.onLoadProduct,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = 14.smoothRadius;
    return Align(
      alignment: (chat.isUser) ? Alignment.centerRight : Alignment.centerLeft,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: chat.isUser ? AppColors.kFoundationPurple200 : AppColors.kPurple60,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.only(
              topRight: borderRadius,
              topLeft: chat.isUser ? borderRadius : 0.smoothRadius,
              bottomLeft: borderRadius,
              bottomRight: chat.isUser ? 0.smoothRadius : borderRadius,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: chat.isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (chat.documensts != null && chat.documensts!.isNotEmpty)
                ChatDocView(
                  networkFile: chat.documensts ?? [],
                  width: (chat.documensts ?? []).length < 4 ? (80 * (chat.documensts ?? []).length).toDouble() : (80 * 4),
                  readOnly: true,
                ),
              if (chat.productID != null)
                if (chat.loadedProduct == null)
                  FutureBuilder<DataState<ProductModel?>>(
                    future: getIt.get<ProductDataSource>().fetchProductbyId(chat.productID!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.hasData && snapshot.data?.data != null) {
                        onLoadProduct(snapshot.data!.data!);
                        return ProductView(
                          product: snapshot.data!.data!,
                        );
                      }
                      return const Text("Fail to load Product");
                    },
                  )
                else
                  ProductView(
                    product: chat.loadedProduct!,
                  ),
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

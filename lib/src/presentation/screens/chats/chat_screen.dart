import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_enums.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/src/data/model/chat_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/message_ui.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isSender = true;
  final border = OutlineInputBorder(
    borderRadius: 12.borderRadius2,
    borderSide: const BorderSide(
      width: 0,
    ),
  );
  final textEditingController = TextEditingController();
  final menuController = MenuController();
  @override
  void initState() {
    dummyMessage = dummyMessage.reversed.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        flexibleSpace: FlexibleSpaceBar(
          title: Image.asset(
            AppAssets.appLogo,
            colorBlendMode: BlendMode.srcIn,
            width: 42,
            height: 42,
            color: AppColors.black,
          ),
          titlePadding: const EdgeInsets.only(left: 75, bottom: 8),
        ),
        onback: context.pop,
        actions: [
          UnconstrainedBox(
            child: OutlinedButton(
              onPressed: () {},
              child: const CustomSvgIcon(
                assetName: AppAssets.call,
                color: AppColors.kCardGrey400,
                size: 20,
              ),
            ),
          ),
          16.spaceW,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              reverse: true,
              scrollDirection: Axis.vertical,
              itemCount: dummyMessage.length,
              itemBuilder: (context, index) {
                return MessageUI(chatModel: dummyMessage[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return 8.spaceH;
              },
            ),
          ),
          8.spaceH,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    child: TextFormField(
                      controller: textEditingController,
                      maxLines: 4,
                      minLines: 1,
                      cursorColor: AppColors.kFoundatiionPurple800,
                      style: context.textTheme.displayMedium,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        suffixIconColor: AppColors.kFoundatiionPurple800,
                        suffixIconConstraints: const BoxConstraints.expand(height: 42, width: 42),
                        filled: true,
                        fillColor: AppColors.kFoundationPurple50,
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (menuController.isOpen) {
                              menuController.close();
                            } else {
                              menuController.open();
                            }
                          },
                          icon: const Icon(
                            Icons.attach_file_outlined,
                            size: 18,
                          ),
                        ),
                        hintText: "Message",
                        hintStyle: context.textTheme.bodyLarge,
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border,
                      ),
                    ),
                  ),
                ),
                8.spaceW,
                Material(
                  color: AppColors.kFoundationPurple700,
                  shape: RoundedRectangleBorder(
                    borderRadius: 50.borderRadius,
                  ),
                  child: InkWell(
                    onTap: () {
                      dummyMessage = dummyMessage.reversed.toList();
                      final chat = ChatModel(
                        message: textEditingController.text.trim(),
                        isSender: isSender,
                        dateTime: DateTime.now(),
                        image: dummyMessage.length == 3 ? AppAssets.appLogo : null,
                        chatType: dummyMessage.length == 3 ? chatsRowType.imageWithText : chatsRowType.normalText,
                      );
                      dummyMessage.add(chat);
                      isSender = !isSender;
                      dummyMessage = dummyMessage.reversed.toList();
                      textEditingController.clear();
                      setState(() {});
                    },
                    borderRadius: 50.borderRadius2,
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Icon(
                        Icons.send,
                        size: 18,
                        color: AppColors.kWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}

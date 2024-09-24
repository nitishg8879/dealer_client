import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/model/chat_model.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/chat_doc_view.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/message_ui.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isSender = true;
  final border = OutlineInputBorder(borderRadius: 12.borderRadius2, borderSide: const BorderSide(width: 0));
  final textEditingController = TextEditingController();
  FilePickerResult? _filePickerResult;
  ProductModel? _pinProduct;
  @override
  void initState() {
    dummyMessage = dummyMessage.reversed.toList();
    super.initState();
  }

  final dummyProduct = ProductModel(
    images: [
      'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize',
      'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize',
      'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize',
      'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize',
      'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize',
      'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize',
      'https://bd.gaadicdn.com/processedimages/ktm/2021-390-duke/494X300/2021-390-duke64e477cc9c099.jpg?imwidth=400&impolicy=resize',
    ],
    kmDriven: 2000,
    name: "KTM 200 Duke 1",
    // ownerType: "1st Owner",
    // price: 75000,
    // year: 2023,
    // branch: "Andheri,Mumbai",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.amaranth,
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          //? Chats List
          Positioned(
            top: 0,
            bottom: context.height * .09,
            left: 0,
            right: 0,
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

          //? Upload File View and Product Selection UI
          Positioned(
            bottom: context.height * .09,
            left: 8,
            right: 8,
            child: pinView(),
          ),

          // ?? chat Textfield and send button
          Positioned(
            bottom: 6,
            left: 8,
            right: 8,
            child: Row(
              children: [
                //? chat Textfield
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    maxLines: 4,
                    minLines: 1,
                    cursorColor: AppColors.kFoundatiionPurple800,
                    style: context.textTheme.displayMedium,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      suffixIconColor: AppColors.kFoundatiionPurple800,
                      suffixIconConstraints: const BoxConstraints.expand(height: 42, width: 70),
                      filled: true,
                      fillColor: AppColors.kFoundationPurple50,
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Material(
                            color: AppColors.kFoundationPurple50,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              constraints: const BoxConstraints.expand(width: 34, height: 34),
                              splashRadius: 15,
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                _filePickerResult = null;
                                _pinProduct = dummyProduct;
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.car_repair_outlined,
                                size: 18,
                              ),
                            ),
                          ),
                          Material(
                            color: AppColors.kFoundationPurple50,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              constraints: const BoxConstraints.expand(width: 34, height: 34),
                              splashRadius: 15,
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                HelperFun.pickFile().then((files) {
                                  if (files != null) {
                                    _filePickerResult = files;
                                    setState(() {});
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.attach_file_outlined,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      hintText: "Message",
                      hintStyle: context.textTheme.bodyLarge,
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
                8.spaceW,
                //? chat Send Button
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
                        doc: _filePickerResult?.files,
                        product: _pinProduct,
                      );
                      _pinProduct = null;
                      dummyMessage.add(chat);
                      isSender = !isSender;
                      dummyMessage = dummyMessage.reversed.toList();
                      textEditingController.clear();
                      _filePickerResult = null;
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

  Widget pinView() {
    if (_filePickerResult != null) {
      return SizedBox(
        width: double.infinity,
        height: 100,
        child: Material(
          elevation: 5,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.vertical(
              top: 12.smoothRadius,
            ),
          ),
          color: AppColors.kPurple60,
          child: ChatDocView(
            files: _filePickerResult?.files ?? [],
            onFullEmpty: () {
              setState(() {
                _filePickerResult = null;
              });
            },
          ),
        ),
      );
    } else if (_pinProduct != null) {
      return SizedBox(
        width: double.infinity,
        height: 110,
        child: Material(
          elevation: 5,
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.vertical(
              top: 12.smoothRadius,
            ),
          ),
          color: AppColors.kPurple60,
          child: ProductView(
            product: _pinProduct!,
            fromChatPin: true,
            onChatPinCLose: () {
              _pinProduct = null;
              setState(() {});
            },
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}

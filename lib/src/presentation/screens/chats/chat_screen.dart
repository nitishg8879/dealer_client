import 'package:bike_client_dealer/config/routes/app_pages.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/constants/app_assets.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:bike_client_dealer/src/data/model/product_model.dart';
import 'package:bike_client_dealer/src/presentation/cubit/chat/chat_cubit.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/chat_doc_view.dart';
import 'package:bike_client_dealer/src/presentation/screens/chats/message_ui.dart';
import 'package:bike_client_dealer/src/presentation/widgets/app_appbar.dart';
import 'package:bike_client_dealer/src/presentation/widgets/custom_svg_icon.dart';
import 'package:bike_client_dealer/src/presentation/widgets/error_view.dart';
import 'package:bike_client_dealer/src/presentation/widgets/product_view.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  final ProductModel? productModel;
  const ChatScreen({
    super.key,
    this.productModel,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final border = OutlineInputBorder(borderRadius: 12.borderRadius2, borderSide: const BorderSide(width: 0));
  final textEditingController = TextEditingController();
  final chatBloc = ChatCubit();
  final scrollCtr = ScrollController();
  @override
  void initState() {
    if (widget.productModel != null) {
      chatBloc.pinProduct = widget.productModel;
    }
    super.initState();
    fetchChats();
  }

  void fetchChats() {
    WidgetsBinding.instance.addPostFrameCallback((frame) {
      chatBloc.fetchChats();
      chatBloc.refreshChatStreamly();
    });
  }

  @override
  void dispose() {
    scrollCtr.dispose();
    chatBloc.close();
    textEditingController.dispose();
    super.dispose();
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          //? Chats List
          BlocBuilder<ChatCubit, ChatState>(
            bloc: chatBloc,
            buildWhen: (previous, current) => current is! ChatSending,
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ChatError) {
                return ErrorView(
                  onreTry: chatBloc.fetchChats,
                  errorMsg: state.errorMsg,
                );
              }
              if (state is ChatLoaded) {
                return Positioned(
                  top: 0,
                  bottom: context.height * .09,
                  left: 0,
                  right: 0,
                  child: ListView.separated(
                    controller: scrollCtr,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    itemCount: state.chats.length,
                    itemBuilder: (context, index) => MessageUI(
                      chat: state.chats[index],
                      onLoadProduct: (pm) {
                        state.chats[index].loadedProduct = pm;
                        chatBloc.loadedProduct.add(pm);
                      },
                    ),
                    separatorBuilder: (BuildContext context, int index) => 8.spaceH,
                  ),
                );
              }
              return const Center(
                child: Text("Wrong State"),
              );
            },
          ),

          //? Upload File View and Product Selection UI
          Positioned(
            bottom: context.height * .09,
            left: 8,
            right: 8,
            child: ValueListenableBuilder(
                valueListenable: chatBloc.pinValue,
                builder: (BuildContext context, value, Widget? child) {
                  return pinView();
                }),
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
                                chatBloc.filePickerResult = null;
                                context
                                    .pushNamed(
                                  Routes.allProduct,
                                  extra: true,
                                )
                                    .then((val) {
                                  if (val != null && val is ProductModel) {
                                    chatBloc.pinProduct = val;
                                    chatBloc.pinValue.value += 1;
                                  }
                                });
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
                                    chatBloc.filePickerResult = files;
                                    chatBloc.pinValue.value += 1;
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
                    onTap: () => chatBloc.sendMessage(textEditingController),
                    borderRadius: 50.borderRadius2,
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: BlocBuilder<ChatCubit, ChatState>(
                        bloc: chatBloc,
                        buildWhen: (previous, current) => current is ChatSending,
                        builder: (context, state) {
                          if (state is ChatSending && state.sending) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(color: AppColors.kWhite, strokeWidth: 2),
                            );
                          }
                          return const Icon(Icons.send, size: 18, color: AppColors.kWhite);
                        },
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
    // return Text(chatBloc.pinValue.value.toString());
    if (chatBloc.filePickerResult != null) {
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
            localFiles: chatBloc.filePickerResult?.files ?? [],
            onFullEmpty: () {
              chatBloc.filePickerResult = null;
              chatBloc.pinValue.value += 1;
            },
          ),
        ),
      );
    } else if (chatBloc.pinProduct != null) {
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
            product: chatBloc.pinProduct!,
            fromChatPin: true,
            onChatPinCLose: () {
              chatBloc.pinProduct = null;
              chatBloc.pinValue.value += 1;
            },
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

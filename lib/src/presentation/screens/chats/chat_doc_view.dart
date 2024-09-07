import 'dart:io';

import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ChatDocView extends StatefulWidget {
  final List<PlatformFile> files;
  final void Function()? onFullEmpty;
  final double? width;
  final bool readOnly;
  const ChatDocView({
    super.key,
    required this.files,
    this.onFullEmpty,
    this.width,
    this.readOnly = false,
  });

  @override
  State<ChatDocView> createState() => _ChatDocViewState();
}

class _ChatDocViewState extends State<ChatDocView> {
  @override
  Widget build(BuildContext context) {
    if (widget.files.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(
      height: 80,
      width: widget.width ?? (context.width - 32),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.files.map(
                (e) {
                  return SizedBox(
                    width: 80,
                    height: 80,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        UnconstrainedBox(
                          child: InkWell(
                            borderRadius: 12.borderRadius2,
                            onTap: () {
                              HelperFun.openDocument(e.path!);
                            },
                            child: HelperFun.imageAllowed.contains(e.extension!.toUpperCase())
                                ? ClipRRect(
                                    borderRadius: 12.smoothBorderRadius,
                                    child: Image.file(
                                      File(e.path!),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : DecoratedBox(
                                    decoration: ShapeDecoration(
                                      shape: SmoothRectangleBorder(borderRadius: 12.smoothBorderRadius),
                                      color: AppColors.kWhite,
                                    ),
                                    child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Center(
                                        child: Text(
                                          e.extension?.toUpperCase() ?? '-',
                                          style: context.textTheme.displaySmall,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        if (!widget.readOnly)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                widget.files.remove(e);
                                if (widget.files.isEmpty && widget.onFullEmpty != null) {
                                  widget.onFullEmpty!();
                                } else {
                                  setState(() {});
                                }
                              },
                              child: const Icon(
                                Icons.cancel,
                                color: AppColors.kFoundatiionPurple800,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ).toList() ??
              [],
        ),
      ),
    );
  }
}

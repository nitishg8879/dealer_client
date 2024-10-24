import 'dart:io';

import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/core/util/app_extension.dart';
import 'package:bike_client_dealer/core/util/helper_fun.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatDocView extends StatefulWidget {
  final List<PlatformFile>? localFiles;
  final List<String>? networkFile;
  final void Function()? onFullEmpty;
  final double? width;
  final bool readOnly;
  const ChatDocView({
    super.key,
    this.localFiles,
    this.networkFile,
    this.onFullEmpty,
    this.width,
    this.readOnly = false,
  });

  @override
  State<ChatDocView> createState() => _ChatDocViewState();
}

class _ChatDocViewState extends State<ChatDocView> {
  var deleteNetworkFile = <String>[];
  @override
  Widget build(BuildContext context) {
    if (widget.localFiles == null && widget.networkFile == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        //? Add Button

        //? Local File
        for (PlatformFile e in (widget.localFiles ?? <PlatformFile>[])) ...[
          SizedBox(
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
                    child: HelperFun.imageAllowed.contains(e.extension?.toUpperCase())
                        ? ClipRRect(
                            borderRadius: 12.smoothBorderRadius,
                            child: Image.memory(
                              kIsWeb ? e.bytes! : File(e.path!).readAsBytesSync(),
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
                    top: -10,
                    right: -10,
                    child: IconButton(
                      onPressed: () {
                        widget.localFiles?.remove(e);
                        if ((widget.localFiles?.isEmpty ?? false) && widget.onFullEmpty != null) {
                          widget.onFullEmpty!();
                        }
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: AppColors.kFoundatiionPurple800,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
        //? Network File
        for (var e in (widget.networkFile ?? <String>[])) ...[
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                UnconstrainedBox(
                  child: InkWell(
                    borderRadius: 12.borderRadius2,
                    onTap: () {
                      print(e);
                      HelperFun.openDocumentFromUrl(e);
                    },
                    child: HelperFun.imageAllowed.contains(HelperFun.getFileExtensionFromUrl(e).toUpperCase())
                        ? ClipRRect(
                            borderRadius: 12.smoothBorderRadius,
                            child: CachedNetworkImage(
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              imageUrl: e,
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
                                  HelperFun.getFileExtensionFromUrl(e).toUpperCase(),
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
                        widget.networkFile?.remove(e);
                        // networkFile.remove(e);
                        deleteNetworkFile.add(e);
                        if ((widget.networkFile?.isEmpty ?? false) && widget.onFullEmpty != null) {
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
          ),
        ],
      ],
    );
  }
}

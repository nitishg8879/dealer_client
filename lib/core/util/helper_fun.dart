import 'dart:io';

import 'package:bike_client_dealer/config/routes/app_routes.dart';
import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:bike_client_dealer/src/presentation/widgets/confirmation_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:go_router/go_router.dart';
// import 'package:open_file/open_file.dart' as open;

class HelperFun {
  static List<String> imageAllowed = ["JPEG", "WEBP", "GIF", "GIF", "PNG", "BMP", "WBMP", "JPG"];
  static Future<FilePickerResult?> pickFile({
    List<String>? allowedExtensions,
  }) async {
    return await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: allowedExtensions != null ? FileType.custom : FileType.any,
      allowedExtensions: allowedExtensions,
    );
  }

  static Future<String?> uploadFile(Reference ref, PlatformFile file, void Function(double val) onProgress) async {
    String? fileURL;
    try {
      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = ref.putData(file.bytes!);
      } else {
        uploadTask = ref.putData(await File(file.path!).readAsBytes());
      }
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        double progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        onProgress(progress);
      });
      await uploadTask.whenComplete(() async {
        fileURL = await ref.getDownloadURL();
      });
    } catch (e) {
      rethrow;
    }
    return fileURL;
  }

  static String extractFileName(String url) {
    // Extract the last part of the URL after 'categoryBucket%2F'
    Uri uri = Uri.parse(url);
    String fullPath = uri.pathSegments.last;

    // Decode the '%2F' to '/'
    String decodedPath = Uri.decodeFull(fullPath);

    // Return just the file name by splitting on '/'
    return decodedPath.split('/').last;
  }

  static List<String> setSearchParameters(String name) {
    List<String> searchOptions = [];
    String temp = "";
    for (int i = 0; i < name.length; i++) {
      temp = temp + name[i];
      searchOptions.add(temp.toLowerCase());
    }
    return searchOptions;
  }

  static void openDocument(String filePath) async {
    final result = await OpenFile.open(filePath);

    // You can check the result if needed
    // open.ResultType
    // if (result.type == result..done) {
    //   print('File opened successfully');
    // } else {
    //   print('Error opening file: ${result.message}');
    // }
  }

  static void goBack({int round = 1}) {
    for (var i = 0; i < round; i++) {
      AppRoutes.rootNavigatorKey.currentContext?.pop();
    }
  }

  static void goNextPage(String routeName) {
    AppRoutes.rootNavigatorKey.currentContext?.goNamed(
      routeName,
    );
  }

  static void showAlertDialog(String title, String message) {
    showDialog(
      barrierDismissible: false,
      context: AppRoutes.rootNavigatorKey.currentContext!,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          titleText: title,
          contentText: message,
        );
      },
    );
  }

  static String toRupeeCurrencyFormatNoSymbol(double? amount) {
    if (amount == null) return '0';
    final format = NumberFormat.decimalPattern('en_IN');

    return format.format(amount);
  }

  static void showSuccessSnack(String message) {
    ScaffoldMessenger.of(AppRoutes.rootNavigatorKey.currentContext!).clearSnackBars();
    ScaffoldMessenger.of(AppRoutes.rootNavigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          maxLines: 2,
        ),
        closeIconColor: AppColors.kWhite,
        backgroundColor: AppColors.kGreen700,
        showCloseIcon: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      ),
    );
  }

  static void showErrorSnack(String message) {
    ScaffoldMessenger.of(AppRoutes.rootNavigatorKey.currentContext!).clearSnackBars();
    ScaffoldMessenger.of(AppRoutes.rootNavigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          maxLines: 2,
        ),
        closeIconColor: AppColors.kWhite,
        backgroundColor: AppColors.kRed,
        showCloseIcon: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      ),
    );
  }
}

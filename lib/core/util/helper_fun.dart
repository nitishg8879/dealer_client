import 'package:bike_client_dealer/config/themes/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
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

  static void showSuccessSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
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

  static void showErrorSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
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

import 'package:file_picker/file_picker.dart';
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
}

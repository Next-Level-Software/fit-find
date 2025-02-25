// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:logger/logger.dart';
// import 'package:path_provider/path_provider.dart';

// class FileHelper {
//   static Future<List<PlatformFile>> addFile({
//     bool multiple = false,
//   }) async {
//     FilePicker filePicker = FilePicker.platform;

//     try {
//       FilePickerResult? result = await filePicker.pickFiles(
//         allowMultiple: multiple,
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'doc', 'docx'],
//       );

//       if (result == null) return [];

//       return result.files;
//     } catch (e) {
//       Logger().e("File Picker Error: $e");
//       return [];
//     }
//   }

//   static Future<List<PlatformFile>> addFileForCertificate({
//     bool multiple = false,
//   }) async {
//     FilePicker filePicker = FilePicker.platform;

//     try {
//       FilePickerResult? result = await filePicker.pickFiles(
//         allowMultiple: multiple,
//         type: FileType.custom,
//         allowedExtensions: [
//           'pdf',
//           'doc',
//           'docx',
//           'jpg',
//           'jpeg',
//           'png',
//           'gif',
//           'bmp',
//           'tiff',
//           'svg',
//           'webp'
//         ],
//       );

//       if (result == null) return [];

//       return result.files;
//     } catch (e) {
//       Logger().e("File Picker Error: $e");
//       return [];
//     }
//   }

//   static Future<List<PlatformFile>> addAllowedImages({
//     bool multiple = false,
//   }) async {
//     FilePicker filePicker = FilePicker.platform;

//     try {
//       FilePickerResult? result = await filePicker.pickFiles(
//         allowMultiple: multiple,
//         type: FileType.custom,
//         allowedExtensions: [
//           'jpg',
//           'jpeg',
//           'png',
//           'gif',
//           'bmp',
//           'tiff',
//           'svg',
//           'webp'
//         ],
//       );

//       if (result == null) return [];

//       return result.files;
//     } catch (e) {
//       Logger().e("File Picker Error: $e");
//       return [];
//     }
//   }

//   static Future<List<PlatformFile>> addPdfFile({
//     bool multiple = false,
//   }) async {
//     FilePicker filePicker = FilePicker.platform;

//     try {
//       FilePickerResult? result = await filePicker.pickFiles(
//         allowMultiple: multiple,
//         type: FileType.custom,
//         allowedExtensions: [
//           'pdf',
//         ],
//       );

//       if (result == null) return [];

//       return result.files;
//     } catch (e) {
//       Logger().e("File Picker Error: $e");
//       return [];
//     }
//   }

//   static Future<String> getDownloadPath() async {
//     Directory? directory;
//     try {
//       if (Platform.isIOS) {
//         directory = await getApplicationDocumentsDirectory();
//       } else {
//         directory = Directory('/storage/emulated/0/Download');

//         if (!await directory.exists()) {
//           directory = await getExternalStorageDirectory();
//         }
//       }
//     } catch (err) {
//       // print("Cannot get download folder path");
//     }
//     return directory?.path ?? "";
//   }

//   static Future<void> prepareSaveDir() async {
//     String localPath = (await findLocalPath())!;

//     print(localPath);
//     final savedDir = Directory(localPath);
//     bool hasExisted = await savedDir.exists();
//     if (!hasExisted) {
//       savedDir.create();
//     }
//   }

//   static Future<String?> findLocalPath() async {
//     if (Platform.isAndroid) {
//       return "/sdcard/download";
//     } else {
//       var directory = await getApplicationDocumentsDirectory();
//       return '${directory.path}${Platform.pathSeparator}Download';
//     }
//   }

//   static bool checkFileSize(String filePath, {double? size}) {
//     final file = File(filePath);

//     // Check if the file exists
//     if (file.existsSync()) {
//       // Get the file size in bytes
//       int fileSizeInBytes = file.lengthSync();

//       // Convert to MB
//       double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

//       // Check if file size exceeds 25 MB
//       if (fileSizeInMB > (size ?? 25)) {
//         print('File size exceeds ${(size ?? 25)} MB');
//         return false;
//       } else {
//         print('File size is within the limit');
//         return true;
//       }
//     } else {
//       print('File does not exist');
//       return false; // Return false if file doesn't exist
//     }
//   }
// }

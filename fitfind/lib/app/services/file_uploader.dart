// import 'dart:io';

// import 'package:dio/dio.dart';
// import '/app/models/attachment_model.dart';
// import 'package:logger/logger.dart';
// import '/app/components/custom_snackbar.dart';
// import '/config/translations/strings_enum.dart';
// import '/app/components/custom_loading_overlay.dart';
// import '/app/services/API/file_service.dart';
// import '/app/services/base_client.dart';

// class FileUploaderService {
//   static var dio = Dio();

//   static uploadMultipleFiles({
//     required List<AttachmentModel?> files,
//     Function(List<String>)? nextFunction,
//   }) async {
//     if (files.isEmpty) return nextFunction?.call([]);

//     String multiFileUploadUrl = FileService.uploadMultipleFile;

//     FormData formData = FormData();

//     for (int i = 0; i < files.length; i++) {
//       var file = files[i];
//       if (file?.path?.isEmpty ?? true) return nextFunction?.call([]);

//       formData.files.add(
//         MapEntry(
//           'files',
//           await MultipartFile.fromFile(
//             file?.path ?? "",
//             filename: file?.name ?? "",
//           ),
//         ),
//       );
//     }

//     List<String> fileNames = [];

//     showLoadingOverLay(
//       msg: "Uploading...",
//       asyncFunction: () async {
//         await BaseClient.safeApiCall(
//           multiFileUploadUrl,
//           RequestType.put,
//           data: formData,
//           onError: (e) {
//             Logger().e(e);
//             nextFunction?.call(fileNames);
//             CustomSnackBar.showCustomSnackBar(
//                 title: Strings.ERROR,
//                 message: e.response?.statusMessage ?? '',
//                 snackbarType: SnackbarType.danger);
//           },
//           onSuccess: (resp) {
//             MultipleFileModel response = multipleFileModelFromJson(resp.data);
//             fileNames = response.fileNames ?? [];
//             nextFunction?.call(fileNames);
//           },
//         );
//       },
//     );
//   }

//   static uploadImage(
//     String path,
//     File filePath,
//     Function nextFunction, {
//     String? loadingMsg,
//   }) async {
//     final formData = FormData.fromMap(
//       {
//         "file": MultipartFile.fromFileSync(
//           filePath.path,
//         ),
//         // "file": filePath,
//       },
//     );
//     showLoadingOverLay(
//         msg: loadingMsg ?? 'Uploading...',
//         asyncFunction: () async {
//           return await BaseClient.safeApiCall(
//             path,
//             RequestType.post,
//             data: formData,
//             onLoading: () {},
//             onError: (e) {
//               // var data = emptyMsgModelFromJson(e.response?.data);
//               // Logger().e(data);
//               // // messageOnlyMediaApiCallStatus = ApiCallStatus.error;
//               CustomSnackBar.showCustomSnackBar(
//                   title: Strings.ERROR,
//                   message: e.response?.statusMessage ?? '',
//                   snackbarType: SnackbarType.danger);
//             },
//             onSuccess: (response) {
//               nextFunction(response);
//             },
//           );
//         });
//   }
// }

// /// ==================================================================
// /// Model
// /// ==================================================================

// MultipleFileModel multipleFileModelFromJson(Map<String, dynamic> str) =>
//     MultipleFileModel.fromJson((str));

// Map<String, dynamic> multipleFileModelToJson(MultipleFileModel data) =>
//     (data.toJson());

// class MultipleFileModel {
//   int? statusCode;
//   bool? isSuccess;
//   String? message;
//   List<String>? fileNames;

//   MultipleFileModel({
//     this.statusCode,
//     this.isSuccess,
//     this.message,
//     this.fileNames,
//   });

//   factory MultipleFileModel.fromJson(Map<String, dynamic> json) =>
//       MultipleFileModel(
//         statusCode: json["statusCode"],
//         isSuccess: json["isSuccess"],
//         message: json["message"],
//         fileNames: json["fileNames"] == null
//             ? []
//             : List<String>.from(json["fileNames"]!.map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "isSuccess": isSuccess,
//         "message": message,
//         "fileNames": fileNames == null
//             ? []
//             : List<dynamic>.from(fileNames!.map((x) => x)),
//       };
// }

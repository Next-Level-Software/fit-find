// import 'dart:io';

// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';

// class ImageHelper {
//   ImageHelper({
//     ImagePicker? imagePicker,
//     ImageCropper? imageCropper,
//   })  : _imagePicker = ImagePicker(),
//         _imageCropper = ImageCropper();

//   final ImagePicker _imagePicker;
//   final ImageCropper _imageCropper;

//   Future<List<XFile>> pickImage({
//     ImageSource imageSource = ImageSource.gallery,
//     int imageQuality = 100,
//     bool multiple = false,
//     CameraDevice cameraDevice = CameraDevice.rear,
//   }) async {
//     if (multiple) {
//       return await _imagePicker.pickMultiImage(
//         imageQuality: imageQuality,
//       );
//     }

//     final file = await _imagePicker.pickImage(
//       source: imageSource,
//       imageQuality: imageQuality,
//       preferredCameraDevice: cameraDevice,
//     );
//     if (file != null) return [file];
//     return [];
//   }

//   Future<File?> crop({
//     required XFile file,
//     CropStyle cropStyle = CropStyle.circle,
//     CropAspectRatio? aspectRatio,
//   }) async {
//     // Get the CroppedFile
//     CroppedFile? croppedFile = await _imageCropper.cropImage(
//       sourcePath: file.path,
//       // cropStyle: cropStyle,
//       aspectRatio: aspectRatio,
//       maxHeight: 150,
//       maxWidth: 150,
//       compressFormat: ImageCompressFormat.png,
//     );

//     // If cropping was successful, convert CroppedFile to File and return
//     if (croppedFile != null) {
//       return File(croppedFile.path);
//     }

//     // If cropping failed, return null
//     return null;
//   }
// }

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/services.dart';

import 'package:logger/logger.dart';

class FileUploader {
  static const cloudName = "sickjtx";

  late FilePickerResult? result;
  late PlatformFile? file;
  late CloudinaryResponse response;
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<String> selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        file = result.files.first;
        return file!.name;
      }
    } on PlatformException catch (e, s) {
    } on Exception catch (e, s) {}
    return "";
  }

  Future<String> uploadFileOnCloudinary() async {
    try {
      final cloudinary = CloudinaryPublic(cloudName, 'certificados');
      ;
      response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(file!.path!),
      );
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      logger.e(e.message);
    }
    return "error";
  }
}

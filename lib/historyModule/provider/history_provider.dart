import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta_canvas/common_functions.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class HistoryProvider extends ChangeNotifier {
  List<File> savedImages = [];

  Future<List<File>> getSavedImages() async {
    try {
      // Directory directory = Directory(
      //     '/storage/emulated/0/Android/data/com.example.insta_canvas/files/data/user/0/com.example.insta_canvas/files/');

      Directory? externalDir = await getExternalStorageDirectory();
      externalDir = Directory('${externalDir!.path}/savedImages/');

      if (!await externalDir.exists()) {
        Directory(externalDir.path).create();
      }

      List<FileSystemEntity> files = externalDir.listSync();
      savedImages = files.whereType<File>().toList().reversed.toList();
      return savedImages;
    } catch (e) {
      debugPrint('$e');
      return [];
    }
  }

  void copyFileToGallery(String sourcePath, String fileName) {
    try {
      File sourceFile = File(sourcePath);

      if (!sourceFile.existsSync()) {
        throw FileSystemException("Source file not found", sourcePath);
      }

      String destinationDir = "/storage/emulated/0/Download";
      Directory(destinationDir).createSync(recursive: true);
      String destinationPath = path.join(destinationDir, fileName);

      sourceFile.copySync(destinationPath);

      showSnackbar('File Downloaded successfully to Download Folder',
          color: Colors.green);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> deleteImage(File imageFile) async {
    try {
      await imageFile.delete();
      savedImages.remove(imageFile);
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting image: $e");
    }
  }
}

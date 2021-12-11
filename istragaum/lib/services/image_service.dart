import 'dart:io';
import 'dart:typed_data';

// import 'package:camera/camera.dart';
// import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  Future<Iterable<String>> retrieveImages() async {
    final directory = await getApplicationDocumentsDirectory();
    Iterable<String> images = directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.png'))
        .toList()
        .reversed;

    return images;
  }

  saveImage(Uint8List? image) async {
    if (image != null) {
      final DateTime filename = DateTime.now();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          await File('${directory.path}/img-$filename.png').create();
      await imagePath.writeAsBytes(image);
    }
  }
}

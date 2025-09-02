import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) return null;

  Uint8List imageBytes = await pickedFile.readAsBytes();

  img.Image? originalImage = img.decodeImage(imageBytes);
  if (originalImage == null) return null;

  img.Image resizedImage = img.copyResize(originalImage, width: 800);

  final tempDir = await getTemporaryDirectory();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final resizedPath = join(tempDir.path, 'resized_image_$timestamp.jpg');
  final resizedFile = File(resizedPath)
    ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 75));

  return resizedFile;
}
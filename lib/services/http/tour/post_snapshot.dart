import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../dio/authorized_dio.dart';

Future<void> postSnapshot(Uint8List pngBytes, int tourId) async {
  final tempDir = await getTemporaryDirectory();
  final filePath = join(tempDir.path, 'upload_${DateTime.now().millisecondsSinceEpoch}.jpg');

  final file = File(filePath);
  await file.writeAsBytes(pngBytes);

  final dio = await getAuthorizedDio();
  final formData = FormData.fromMap({
    'image': await MultipartFile.fromFile(file.path, filename: basename(file.path)),
    'tour_id': tourId,
  });

  try {
    await dio.post(
      'http://3.34.44.187:80/tour/snapshot/',
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
  } catch (e) {
    throw Exception('uploadPngToServer Error: $e');
  }
}
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../../services/http/tour/post_snapshot.dart';


Future<Uint8List> capturePngFromRepaintBoundary(
    GlobalKey repaintKey, {
      double pixelRatio = 3.0,
    }) async {
  await Future.delayed(const Duration(milliseconds: 16));

  final ctx = repaintKey.currentContext;
  if (ctx == null) throw StateError('repaintKey.currentContext is null.');
  final renderObject = ctx.findRenderObject();
  if (renderObject is! RenderRepaintBoundary) {
    throw StateError('RenderObject is not a RenderRepaintBoundary.');
  }

  final ui.Image image = await renderObject.toImage(pixelRatio: pixelRatio);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  if (byteData == null) throw StateError('Failed to encode image to PNG.');
  return byteData.buffer.asUint8List();
}

Future<bool> savePngBytesToGallery(Uint8List pngBytes, {String? name}) async {
  final result = await ImageGallerySaver.saveImage(
    pngBytes,
    name: name ?? 'fourcut_${DateTime.now().millisecondsSinceEpoch}',
  );
  if (result is Map) {
    return result['isSuccess'] == true || result['success'] == true;
  }
  return false;
}

Future<bool> captureSave(
    GlobalKey repaintKey, {
      required int tourId,
      double pixelRatio = 3.0,
      String? name,
    }) async {
  final pngBytes = await capturePngFromRepaintBoundary(
    repaintKey,
    pixelRatio: pixelRatio,
  );

  final saved = await savePngBytesToGallery(pngBytes, name: name);
  return saved;
}

Future<bool> captureUpload(GlobalKey repaintKey, {
  required int tourId,
  double pixelRatio = 3.0,
  String? name,
}) async {
  final pngBytes = await capturePngFromRepaintBoundary(
    repaintKey,
    pixelRatio: pixelRatio,
  );
  final response = await postSnapshot(pngBytes, tourId);
  return response;
}
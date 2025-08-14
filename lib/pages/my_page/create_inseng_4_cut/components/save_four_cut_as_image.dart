import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

/// RepaintBoundary(GlobalKey)에서 PNG 바이트 캡처
Future<Uint8List> capturePngFromRepaintBoundary(
    GlobalKey repaintKey, {
      double pixelRatio = 3.0,
    }) async {
  // 프레임 렌더가 끝났는지 잠시 보장
  await Future.delayed(const Duration(milliseconds: 16));

  final ctx = repaintKey.currentContext;
  if (ctx == null) {
    throw StateError('repaintKey.currentContext is null. 위젯이 아직 빌드되지 않았어요.');
  }

  final renderObject = ctx.findRenderObject();
  if (renderObject is! RenderRepaintBoundary) {
    throw StateError('RenderObject가 RenderRepaintBoundary가 아니에요.');
  }

  final ui.Image image = await renderObject.toImage(pixelRatio: pixelRatio);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  if (byteData == null) {
    throw StateError('이미지를 PNG로 변환하지 못했어요.');
  }
  return byteData.buffer.asUint8List();
}

/// PNG 바이트를 갤러리에 저장 (iOS/Android)
Future<bool> savePngBytesToGallery(
    Uint8List pngBytes, {
      String? name,
    }) async {
  final result = await ImageGallerySaver.saveImage(
    pngBytes,
    name: name ?? 'fourcut_${DateTime.now().millisecondsSinceEpoch}',
  );

  // plugin 결과가 플랫폼별로 다를 수 있어 넓게 체크
  if (result is Map) {
    final success =
        (result['isSuccess'] == true) || (result['success'] == true);
    return success;
  }
  return false;
}

/// 한 번에 캡처 + 저장
Future<bool> captureAndSave(
    GlobalKey repaintKey, {
      double pixelRatio = 3.0,
      String? name,
    }) async {
  final bytes = await capturePngFromRepaintBoundary(
    repaintKey,
    pixelRatio: pixelRatio,
  );
  return savePngBytesToGallery(bytes, name: name);
}
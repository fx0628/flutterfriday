import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'compose_result.dart';

/// Mock AI：短延遲後回傳 stylized placeholder（ColorFilter／圖騰）
/// 絕不呼叫付費 API。
class MockAiAdapter {
  const MockAiAdapter();

  Future<ComposeResult> composeFromImage(Uint8List bytes) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    return ComposeResult(
      source: ComposeSource.image,
      seedColor: const Color(0xFF6C5CE7),
      label: '圖片風格化（Mock）',
      imageBytes: bytes,
      filter: const ColorFilter.matrix(<double>[
        0.9, 0.1, 0.1, 0, 20,
        0.05, 0.85, 0.2, 0, 10,
        0.1, 0.15, 1.0, 0, 30,
        0, 0, 0, 1, 0,
      ]),
    );
  }

  Future<ComposeResult> composeFromText(String text) async {
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    final hash = text.hashCode;
    final hue = (hash % 360).abs().toDouble();
    final color = HSLColor.fromAHSL(1, hue, 0.55, 0.55).toColor();
    return ComposeResult(
      source: ComposeSource.text,
      seedColor: color,
      label: '文字生成圖案（Mock）',
      promptText: text,
      filter: ColorFilter.mode(
        color.withValues(alpha: 0.35),
        BlendMode.overlay,
      ),
    );
  }
}

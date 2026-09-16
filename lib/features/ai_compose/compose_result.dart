import 'dart:typed_data';

import 'package:flutter/material.dart';

enum ComposeSource { image, text }

/// Mock AI 合成結果（永不呼叫付費 API）
class ComposeResult {
  const ComposeResult({
    required this.source,
    required this.seedColor,
    required this.label,
    this.imageBytes,
    this.promptText,
    this.filter = const ColorFilter.mode(
      Color(0x446C5CE7),
      BlendMode.overlay,
    ),
  });

  final ComposeSource source;
  final Color seedColor;
  final String label;
  final Uint8List? imageBytes;
  final String? promptText;
  final ColorFilter filter;
}

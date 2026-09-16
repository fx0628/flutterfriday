import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../app/app.dart';
import 'compose_result.dart';
import 'mock_ai_adapter.dart';

/// 合成進度頁：Mock AI 延遲後導向裝置預覽
class ComposingPage extends StatefulWidget {
  const ComposingPage({
    super.key,
    required this.source,
    this.imageBytes,
    this.promptText,
  });

  final ComposeSource source;
  final Uint8List? imageBytes;
  final String? promptText;

  @override
  State<ComposingPage> createState() => _ComposingPageState();
}

class _ComposingPageState extends State<ComposingPage> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    try {
      const adapter = MockAiAdapter();
      final ComposeResult result;
      if (widget.source == ComposeSource.image) {
        final bytes = widget.imageBytes;
        if (bytes == null) {
          throw StateError('缺少圖片資料');
        }
        result = await adapter.composeFromImage(bytes);
      } else {
        final text = widget.promptText?.trim() ?? '';
        if (text.isEmpty) {
          throw StateError('缺少文字內容');
        }
        result = await adapter.composeFromText(text);
      }
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.preview,
        arguments: result,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = '合成失敗：$e\n請返回重試。');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUIB = UIVariantProvider.isUIB(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isUIB ? 'flutterFriday' : 'AI 合成中'),
        centerTitle: !isUIB,
        actions: isUIB ? null : const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Center(child: FreeBadge()),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _error != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(_error!, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: isUIB ? 56 : null,
                      child: FilledButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('返回'),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 24),
                    Text(
                      widget.source == ComposeSource.image
                          ? '正在風格化圖片…（Mock，未呼叫付費 API）'
                          : '正在依文字產生圖案…（Mock，未呼叫付費 API）',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

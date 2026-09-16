import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../app/app.dart';
import '../ai_compose/compose_result.dart';
import 'content_filter.dart';

/// 建立輸入：選 JPG/PNG 或輸入文字
class CreateInputPage extends StatefulWidget {
  const CreateInputPage({super.key});

  @override
  State<CreateInputPage> createState() => _CreateInputPageState();
}

class _CreateInputPageState extends State<CreateInputPage> {
  final _textController = TextEditingController();
  Uint8List? _imageBytes;
  String? _imageName;
  String? _error;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    setState(() => _error = null);
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['jpg', 'jpeg', 'png'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    final filter = ContentFilter.checkImageFileName(file.name);
    if (filter.blocked) {
      setState(() {
        _error = filter.reason;
        _imageBytes = null;
        _imageName = null;
      });
      return;
    }
    if (file.bytes == null) {
      setState(() => _error = '無法讀取圖片，請再試一次。');
      return;
    }
    setState(() {
      _imageBytes = file.bytes;
      _imageName = file.name;
      _textController.clear();
    });
  }

  void _clearImage() {
    setState(() {
      _imageBytes = null;
      _imageName = null;
    });
  }

  void _submit() {
    setState(() => _error = null);
    if (_imageBytes != null) {
      Navigator.of(context).pushNamed(
        AppRoutes.composing,
        arguments: {
          'source': ComposeSource.image,
          'imageBytes': _imageBytes,
        },
      );
      return;
    }
    final text = _textController.text.trim();
    if (text.isEmpty) {
      setState(() => _error = '請上傳 JPG/PNG，或輸入想要的設計文字。');
      return;
    }
    final filter = ContentFilter.checkText(text);
    if (filter.blocked) {
      setState(() => _error = filter.reason);
      return;
    }
    Navigator.of(context).pushNamed(
      AppRoutes.composing,
      arguments: {
        'source': ComposeSource.text,
        'promptText': text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isUIB = UIVariantProvider.isUIB(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isUIB ? 'flutterFriday' : '建立設計'),
        centerTitle: !isUIB,
        actions: isUIB ? null : const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Center(child: FreeBadge()),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxWidth: 640,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.all(isUIB ? 32 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                // Large product image for UI-B
                if (isUIB) ...[
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/phone-product-dark.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
                Text(
                  isUIB 
                    ? '上傳圖片或輸入文字'
                    : '上傳圖片或輸入文字，AI 會合成到手機殼上預覽。',
                  style: isUIB 
                    ? Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.nearBlack,
                        fontWeight: FontWeight.w600,
                      )
                    : Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: isUIB ? 16 : 8),
                Text(
                  '不支援證件／身分證、成人、暴力、侵權內容。',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                SizedBox(height: isUIB ? 32 : 24),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isUIB ? 24 : 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '上傳圖片（JPG / PNG）',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        if (_imageBytes != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              _imageBytes!,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(_imageName ?? '', maxLines: 1),
                          TextButton.icon(
                            onPressed: _clearImage,
                            icon: const Icon(Icons.close),
                            label: const Text('清除圖片'),
                          ),
                        ] else
                          OutlinedButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.image_outlined),
                            label: const Text('選擇圖片'),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: isUIB ? 24 : 16),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '或',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: isUIB ? 24 : 16),
                TextField(
                  controller: _textController,
                  maxLines: 4,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    labelText: '輸入設計文字',
                    hintText: '例如：週末咖啡、貓咪插畫、簡約幾何…',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (_) {
                    if (_imageBytes != null) _clearImage();
                  },
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Material(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        _error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(height: isUIB ? 32 : 24),
                SizedBox(
                  height: isUIB ? 56 : null,
                  child: FilledButton(
                    onPressed: _submit,
                    child: Text(
                      '開始合成',
                      style: TextStyle(fontSize: isUIB ? 18 : null),
                    ),
                  ),
                ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

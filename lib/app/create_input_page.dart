import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_routes.dart';

class CreateInputPage extends StatefulWidget {
  const CreateInputPage({super.key});

  @override
  State<CreateInputPage> createState() => _CreateInputPageState();
}

class _CreateInputPageState extends State<CreateInputPage> {
  final TextEditingController _textController = TextEditingController();
  String? _selectedInputType = 'text';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('創作輸入'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '開始你的創作',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '選擇輸入方式',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedInputType = 'text';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _selectedInputType == 'text'
                                  ? Colors.purple.shade50
                                  : Colors.white,
                              border: Border.all(
                                color: _selectedInputType == 'text'
                                    ? Colors.purple
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _selectedInputType == 'text'
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color: _selectedInputType == 'text'
                                      ? Colors.purple
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '文字描述',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedInputType = 'image';
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _selectedInputType == 'image'
                                  ? Colors.purple.shade50
                                  : Colors.white,
                              border: Border.all(
                                color: _selectedInputType == 'image'
                                    ? Colors.purple
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _selectedInputType == 'image'
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color: _selectedInputType == 'image'
                                      ? Colors.purple
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '上傳圖片',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (_selectedInputType == 'text') ...[
                    Text(
                      '描述你想要的設計',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: '例如：一隻可愛的貓咪在櫻花樹下...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                      maxLines: 5,
                    ),
                  ] else ...[
                    Text(
                      '上傳你的圖片',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload,
                                size: 64, color: Colors.grey.shade600),
                            const SizedBox(height: 16),
                            Text(
                              '點擊或拖曳上傳圖片',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '(此為示意，實際上傳功能需後端支援)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lightbulb_outline,
                            color: Colors.blue.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '提示：描述越詳細，AI 生成的效果越符合預期',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _selectedInputType == 'text' &&
                            _textController.text.isEmpty
                        ? null
                        : _handleNext,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('下一步：AI 生成設計'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleNext() {
    context.go(
      AppRoutes.aiCompose,
      extra: {
        'inputData': {
          'type': _selectedInputType,
          'text': _selectedInputType == 'text' ? _textController.text : null,
        },
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_routes.dart';

class AiComposePage extends StatefulWidget {
  final Map<String, dynamic>? inputData;

  const AiComposePage({super.key, this.inputData});

  @override
  State<AiComposePage> createState() => _AiComposePageState();
}

class _AiComposePageState extends State<AiComposePage> {
  bool _isGenerating = false;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _startGeneration();
  }

  Future<void> _startGeneration() async {
    setState(() {
      _isGenerating = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isGenerating = false;
      _isComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 生成中'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.create),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isGenerating) ...[
                  const CircularProgressIndicator(
                    strokeWidth: 6,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'AI 正在為你創作獨特的設計...',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '這可能需要幾秒鐘時間',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ] else if (_isComplete) ...[
                  Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green.shade600,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '設計生成完成！',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade400, width: 2),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone_android_outlined,
                              size: 120, color: Colors.grey.shade600),
                          const SizedBox(height: 16),
                          Text(
                            '待換：ai-generated-design.png',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Text(
                            '(此處顯示 AI 生成的手機殼設計)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.go(AppRoutes.create),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('重新創作'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _handleNext,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('下一步：選擇機型預覽'),
                        ),
                      ),
                    ],
                  ),
                ],
                if (widget.inputData != null) ...[
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '你的輸入：',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.inputData!['text'] ?? '圖片上傳',
                          style: TextStyle(color: Colors.blue.shade800),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNext() {
    context.go(
      AppRoutes.devicePreview,
      extra: {
        'designData': {
          'inputData': widget.inputData,
          'generatedAt': DateTime.now().toIso8601String(),
        },
      },
    );
  }
}

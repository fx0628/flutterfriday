import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_routes.dart';

class DevicePreviewPage extends StatefulWidget {
  final Map<String, dynamic>? designData;

  const DevicePreviewPage({super.key, this.designData});

  @override
  State<DevicePreviewPage> createState() => _DevicePreviewPageState();
}

class _DevicePreviewPageState extends State<DevicePreviewPage> {
  String? _selectedDevice;

  final List<Map<String, String>> _recentDevices = [
    {'name': 'iPhone 15 Pro Max', 'year': '2023'},
    {'name': 'iPhone 15 Pro', 'year': '2023'},
    {'name': 'iPhone 15', 'year': '2023'},
    {'name': 'iPhone 14 Pro Max', 'year': '2022'},
    {'name': 'iPhone 14 Pro', 'year': '2022'},
    {'name': 'Samsung Galaxy S24 Ultra', 'year': '2024'},
    {'name': 'Samsung Galaxy S24', 'year': '2024'},
    {'name': 'Samsung Galaxy S23 Ultra', 'year': '2023'},
    {'name': 'Google Pixel 8 Pro', 'year': '2023'},
    {'name': 'Google Pixel 8', 'year': '2023'},
    {'name': 'Google Pixel 7 Pro', 'year': '2022'},
    {'name': 'Xiaomi 14 Pro', 'year': '2024'},
    {'name': 'Xiaomi 13 Pro', 'year': '2023'},
    {'name': 'OPPO Find X7', 'year': '2024'},
    {'name': 'Vivo X100 Pro', 'year': '2024'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('機型預覽'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.aiCompose),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '選擇你的手機型號',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '支援近 3 年主流機型',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning_amber,
                            color: Colors.orange.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '提醒：預覽效果不保證等同實物',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.orange.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: _recentDevices.map((device) {
                      final isSelected = _selectedDevice == device['name'];
                      return FilterChip(
                        label: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(device['name']!),
                            Text(
                              device['year']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedDevice = selected ? device['name'] : null;
                          });
                        },
                        selectedColor: Colors.purple,
                        checkmarkColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      );
                    }).toList(),
                  ),
                  if (_selectedDevice != null) ...[
                    const SizedBox(height: 48),
                    Text(
                      '預覽效果',
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Container(
                        width: 300,
                        height: 600,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(24),
                          border:
                              Border.all(color: Colors.grey.shade400, width: 2),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone_android,
                                  size: 100, color: Colors.grey.shade600),
                              const SizedBox(height: 16),
                              Text(
                                '待換：device-preview-$_selectedDevice.png',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  '(顯示設計套用在 $_selectedDevice 的效果)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.go(AppRoutes.aiCompose),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('返回上一步'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed:
                              _selectedDevice == null ? null : _handleNext,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey.shade300,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('下一步：尋找廠商'),
                        ),
                      ),
                    ],
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
      AppRoutes.findVendor,
      extra: {
        'previewData': {
          'designData': widget.designData,
          'selectedDevice': _selectedDevice,
        },
      },
    );
  }
}

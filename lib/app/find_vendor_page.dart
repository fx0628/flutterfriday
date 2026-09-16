import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../routes/app_routes.dart';

class FindVendorPage extends StatelessWidget {
  final Map<String, dynamic>? previewData;

  const FindVendorPage({super.key, this.previewData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('尋找廠商'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.devicePreview),
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
                  Icon(
                    Icons.celebration,
                    size: 80,
                    color: Colors.purple.shade400,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '設計完成！',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '接下來，讓我們幫你找到合適的客製廠商',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '你的設計預覽',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: 250,
                          height: 500,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.grey.shade400, width: 2),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone_android,
                                    size: 100, color: Colors.grey.shade600),
                                const SizedBox(height: 16),
                                Text(
                                  '待換：final-preview.png',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                if (previewData?['selectedDevice'] != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    '機型：${previewData!['selectedDevice']}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200, width: 2),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.store,
                                size: 32, color: Colors.blue.shade700),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                '尋找客製廠商',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '我們會協助您開啟蝦皮平台搜尋「客製手機殼」\n'
                          '您可以：\n\n'
                          '1. 瀏覽不同廠商的作品與評價\n'
                          '2. 選擇符合預算的廠商\n'
                          '3. 聯繫廠商並提供你的設計\n'
                          '4. 直接在蝦皮與廠商進行交易',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade800,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.orange.shade700),
                            const SizedBox(width: 8),
                            Text(
                              '重要提醒',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.orange.shade900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '• 本平台不指定特定廠商\n'
                          '• 不提供 App 內付款功能\n'
                          '• 請直接與客製廠商確認價格與細節\n'
                          '• 建議下單前與廠商確認預覽效果\n'
                          '• 實際成品可能與預覽有差異',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange.shade900,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton.icon(
                    onPressed: _openShopeeSearch,
                    icon: const Icon(Icons.open_in_new, size: 24),
                    label: const Text('前往蝦皮搜尋客製廠商'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => context.go(AppRoutes.home),
                    icon: const Icon(Icons.home),
                    label: const Text('返回首頁'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.download,
                            color: Colors.green.shade700, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '提示：建議截圖或下載設計圖，方便與廠商溝通',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openShopeeSearch() async {
    final uri = Uri.https('shopee.tw', '/search', {'keyword': '客製手機殼'});
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

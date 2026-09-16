import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme.dart';
import '../../app/app.dart';
import '../device_preview/device_catalog.dart';

/// 找客製廠商：開啟 Shopee 搜尋（外部），≤3 示範店家連結（可空）
class FindVendorPage extends StatelessWidget {
  const FindVendorPage({super.key, this.device});

  final PhoneDevice? device;

  static const List<({String title, String? url})> demoShops = [
    (title: '示範店家 A（佔位）', url: null),
    (title: '示範店家 B（佔位）', url: null),
    (title: '示範店家 C（佔位）', url: null),
  ];

  String get _keyword {
    final base = '客製手機殼';
    final model = device?.name;
    if (model == null || model.isEmpty) return base;
    return '$base $model';
  }

  Uri get _shopeeSearchUri {
    final q = Uri.encodeComponent(_keyword);
    return Uri.parse('https://shopee.tw/search?keyword=$q');
  }

  Future<void> _openExternal(BuildContext context, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('無法開啟連結：$uri')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUIB = UIVariantProvider.isUIB(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isUIB ? 'flutterFriday' : '找客製廠商'),
        centerTitle: !isUIB,
        actions: isUIB ? null : const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Center(child: FreeBadge()),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: EdgeInsets.all(isUIB ? 32 : 20),
              children: [
                Text(
                  '本服務免費，不提供 App 內結帳。請到 Shopee 找客製廠商下單。',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: isUIB ? 12 : 8),
                Text(
                  '預覽僅供參考，不保證與實物完全一致。',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                SizedBox(height: isUIB ? 32 : 24),
                if (device != null)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.phone_iphone),
                    title: Text(device!.displayName),
                    subtitle: const Text('目前預覽機型'),
                  ),
                SizedBox(height: isUIB ? 12 : 8),
                SizedBox(
                  height: isUIB ? 56 : null,
                  child: FilledButton.icon(
                    onPressed: () => _openExternal(context, _shopeeSearchUri),
                    icon: const Icon(Icons.open_in_new),
                    label: Text(
                      '在 Shopee 搜尋「客製手機殼」',
                      style: TextStyle(fontSize: isUIB ? 16 : null),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SelectableText(
                  _shopeeSearchUri.toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: isUIB ? 40 : 32),
                Text(
                  '示範店家（可替換，最多 3 個）',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                for (final shop in demoShops)
                  Card(
                    child: ListTile(
                      title: Text(shop.title),
                      subtitle: Text(
                        shop.url == null || shop.url!.isEmpty
                            ? '尚未設定外部連結'
                            : shop.url!,
                      ),
                      trailing: shop.url == null || shop.url!.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.open_in_new),
                              onPressed: () => _openExternal(
                                context,
                                Uri.parse(shop.url!),
                              ),
                            ),
                    ),
                  ),
                SizedBox(height: isUIB ? 32 : 24),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((r) => r.isFirst);
                  },
                  child: const Text('回到首頁'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

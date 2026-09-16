import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FreeBadge(),
                  const SizedBox(height: 16),
                  Text(
                    'flutterFriday',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '上傳圖片或輸入文字 → AI 合成手機殼 → 預覽 → 找客製廠商（Shopee）',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.create);
                    },
                    child: const Text('開始建立'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.vendor);
                    },
                    child: const Text('找客製廠商'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

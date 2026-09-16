import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';

class HomePageC extends StatefulWidget {
  const HomePageC({super.key});

  @override
  State<HomePageC> createState() => _HomePageCState();
}

class _HomePageCState extends State<HomePageC> {
  static const String _videoViewType = 'hero-video-player';
  bool _videoRegistered = false;
  bool _videoError = false;
  bool _prefersReducedMotion = false;

  @override
  void initState() {
    super.initState();
    _checkReducedMotion();
    if (!_prefersReducedMotion) {
      _registerVideoElement();
    }
  }

  void _checkReducedMotion() {
    try {
      final mediaQuery = html.window.matchMedia('(prefers-reduced-motion: reduce)');
      _prefersReducedMotion = mediaQuery.matches ?? false;
    } catch (e) {
      _prefersReducedMotion = false;
    }
  }

  String _assetUrl(String assetKey) {
    final base = html.document.querySelector('base')?.getAttribute('href') ?? '/';
    final normalizedBase = base.endsWith('/') ? base : '$base/';
    return '${normalizedBase}assets/$assetKey';
  }

  void _registerVideoElement() {
    if (_videoRegistered) return;

    try {
      // ignore: undefined_prefixed_name
      ui_web.platformViewRegistry.registerViewFactory(_videoViewType, (int viewId) {
        final videoElement = html.VideoElement()
          ..src = _assetUrl('assets/videos/hero-c.mp4')
          ..poster = _assetUrl('assets/videos/hero-c-poster.webp')
          ..autoplay = true
          ..muted = true
          ..loop = true
          ..setAttribute('playsinline', '')
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.objectFit = 'cover'
          ..style.pointerEvents = 'none';

        videoElement.onError.listen((_) {
          if (mounted) {
            setState(() {
              _videoError = true;
            });
          }
        });

        videoElement.onLoadedData.listen((_) {
          videoElement.play()?.catchError((_) {
            if (mounted) {
              setState(() {
                _videoError = true;
              });
            }
          });
        });

        return videoElement;
      });
      _videoRegistered = true;
    } catch (e) {
      _videoError = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildFeaturesSection(context),
            _buildPreviewDisclaimerSection(context),
            _buildVendorFlowSection(context),
            _buildExpectationsManagementSection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Stack(
        children: [
          // Video background or poster fallback
          Positioned.fill(
            child: _prefersReducedMotion || _videoError
                ? Image.asset(
                    'assets/videos/hero-c-poster.webp',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppTheme.darkBackground,
                              AppTheme.darkSurfaceVariant,
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : const HtmlElementView(viewType: _videoViewType),
          ),
          // Translucent overlay for contrast
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.45),
                    Colors.black.withOpacity(0.55),
                  ],
                ),
              ),
            ),
          ),
          // Foreground content
          Positioned.fill(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'flutterFriday',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 72,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 24,
                                  color: AppTheme.accentPurple.withOpacity(0.6),
                                ),
                              ],
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        '上傳圖片或用文字描述，AI 幫你合成專屬手機殼',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white.withOpacity(0.95),
                              fontSize: 28,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 56),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.create);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 64,
                            vertical: 28,
                          ),
                          backgroundColor: AppTheme.accentPurple,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          elevation: 8,
                          shadowColor: AppTheme.accentPurple.withOpacity(0.5),
                        ),
                        child: const Text('開始創作'),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.freeBadge.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppTheme.freeBadge,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          '🎉 先免費體驗',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.freeBadge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
      color: AppTheme.darkBackground,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                '三大核心功能',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              Wrap(
                spacing: 32,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: [
                  _buildFeatureCard(
                    context,
                    icon: Icons.upload_file,
                    title: '圖文輸入',
                    description: '上傳你的照片或用文字描述你的創意想法',
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.auto_awesome,
                    title: 'AI 套殼',
                    description: 'AI 自動幫你生成獨特的手機殼設計',
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.phone_android,
                    title: '機型預覽',
                    description: '支援近 3 年主流機型的預覽效果',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 320,
      child: Card(
        elevation: 8,
        shadowColor: AppTheme.accentPurple.withOpacity(0.3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.darkSurface,
                AppTheme.darkSurfaceVariant,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.accentPurple,
                        AppTheme.accentCyan,
                      ],
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.7),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewDisclaimerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceVariant,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.orange.withOpacity(0.3),
            width: 2,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  size: 60,
                  color: Colors.orange.shade400,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '⚠️ 重要提醒',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.orange.shade400,
                    ),
              ),
              const SizedBox(height: 24),
              Text(
                '預覽效果不保證等同於實際成品',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '實際印製成品可能因印刷技術、材質、光線等因素與預覽有所差異\n'
                '建議下單前與客製廠商確認細節',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVendorFlowSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      color: AppTheme.darkBackground,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                '完成設計後，輕鬆找廠商',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Text(
                '我們會協助您開啟蝦皮搜尋「客製手機殼」\n'
                '您可以自由選擇合適的客製廠商進行製作',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.8),
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.create);
                    },
                    icon: const Icon(Icons.create),
                    label: const Text('開始創作'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 24,
                      ),
                      backgroundColor: AppTheme.accentPurple,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.vendor);
                    },
                    icon: const Icon(Icons.store),
                    label: const Text('直接找廠商'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 24,
                      ),
                      side: BorderSide(
                        color: AppTheme.accentCyan,
                        width: 2,
                      ),
                      foregroundColor: AppTheme.accentCyan,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.accentCyan.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.accentCyan,
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        '注意：本平台不提供付款功能，請直接與客製廠商洽談',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildExpectationsManagementSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      color: AppTheme.darkSurface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'AI 能力邊界說明',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: [
                  _buildCapabilityColumn(
                    context,
                    title: '✅ 可以做',
                    color: AppTheme.freeBadge,
                    items: [
                      '圖片風格化與合成套殼',
                      '文字描述生成殼面設計',
                      '近 3 年主流機型預覽',
                      '平面與簡單 3D 預覽效果',
                    ],
                  ),
                  _buildCapabilityColumn(
                    context,
                    title: '❌ 不可做',
                    color: Colors.red.shade400,
                    items: [
                      '保證預覽效果等同實物',
                      '證件、授權用途設計',
                      '侵權、成人、暴力內容',
                      'App 內付款給蝦皮廠商',
                    ],
                  ),
                  _buildCapabilityColumn(
                    context,
                    title: '⏸️ 暫緩開放',
                    color: Colors.orange.shade400,
                    items: [
                      '多圖拼貼功能',
                      '品牌聯名合作',
                      'AR 擴增實境預覽',
                      '客製化材質選擇',
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCapabilityColumn(
    BuildContext context, {
    required String title,
    required Color color,
    required List<String> items,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.darkSurfaceVariant,
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 24),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(top: 8, right: 12),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: AppTheme.darkBackground,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'flutterFriday',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [
                        AppTheme.accentPurple,
                        AppTheme.accentCyan,
                      ],
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'AI 手機殼創作平台',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                '© 2026 flutterFriday. 僅供個人創作使用。',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';
import 'app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUIB = UIVariantProvider.isUIB(context);
    
    return Scaffold(
      body: isUIB ? _buildUIB(context) : _buildUIA(context),
    );
  }

  // UI-B: Light, minimal, generous whitespace, no parallax
  Widget _buildUIB(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildUIBAppBar(context),
          _buildUIBHeroSection(context),
          _buildUIBFeaturesSection(context),
          _buildUIBDisclaimerSection(context),
          _buildUIBVendorSection(context),
          _buildUIBFooter(context),
        ],
      ),
    );
  }

  Widget _buildUIBAppBar(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            'flutterFriday',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.nearBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUIBHeroSection(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final imageHeight = screenHeight * 0.5;
    
    return Column(
      children: [
        // Large product image ≥45% height
        SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: Image.asset(
            'assets/images/phone-product-dark.jpg',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 48),
        // Dual entry: upload or text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              children: [
                Text(
                  '上傳圖片或用文字描述',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.nearBlack,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'AI 幫你合成專屬手機殼',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.nearBlack.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.create);
                    },
                    child: const Text(
                      '開始創作',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUIBFeaturesSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Text(
                '三大核心功能',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.nearBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 56),
              Wrap(
                spacing: 32,
                runSpacing: 32,
                alignment: WrapAlignment.center,
                children: [
                  _buildUIBFeatureCard(
                    context,
                    icon: Icons.upload_file,
                    title: '圖文輸入',
                    description: '上傳你的照片或用文字描述你的創意想法',
                  ),
                  _buildUIBFeatureCard(
                    context,
                    icon: Icons.auto_awesome,
                    title: 'AI 套殼',
                    description: 'AI 自動幫你生成獨特的手機殼設計',
                  ),
                  _buildUIBFeatureCard(
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

  Widget _buildUIBFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 280,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCTA.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: AppTheme.primaryCTA,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.nearBlack,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: AppTheme.nearBlack.withOpacity(0.7),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUIBDisclaimerSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      color: AppTheme.lightBackground,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 48,
                color: Colors.orange.shade700,
              ),
              const SizedBox(height: 24),
              Text(
                '預覽效果不保證等同於實際成品',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.nearBlack,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '實際印製成品可能因印刷技術、材質、光線等因素與預覽有所差異\n建議下單前與客製廠商確認細節',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.nearBlack.withOpacity(0.7),
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

  Widget _buildUIBVendorSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Text(
                '找客製廠商',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.nearBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '我們會協助您開啟蝦皮搜尋「客製手機殼」\n您可以自由選擇合適的客製廠商進行製作',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.nearBlack.withOpacity(0.7),
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.create);
                  },
                  child: const Text(
                    '開始創作',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUIBFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: AppTheme.lightBackground,
      child: Center(
        child: Column(
          children: [
            Text(
              'flutterFriday',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.nearBlack,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'AI 手機殼創作平台',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.nearBlack.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '© 2026 flutterFriday. 僅供個人創作使用。',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.nearBlack.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // UI-A: Original dark theme with parallax
  Widget _buildUIA(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
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
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final heroParallax = _scrollOffset * 0.5;

    return SizedBox(
      height: 900,
      child: Stack(
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, heroParallax),
              child: Image.asset(
                'assets/images/hero-dark-phone.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.darkBackground.withOpacity(0.3),
                    AppTheme.darkBackground.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
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
                              shadows: [
                                Shadow(
                                  blurRadius: 20,
                                  color: AppTheme.accentPurple.withOpacity(0.5),
                                ),
                              ],
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '上傳圖片或用文字描述，AI 幫你合成專屬手機殼',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              height: 1.5,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.create);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 56,
                            vertical: 24,
                          ),
                          backgroundColor: AppTheme.accentPurple,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        child: const Text('開始創作'),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
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
                            fontSize: 16,
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
    final featuresParallax = (_scrollOffset - 500) * 0.3;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
      child: Stack(
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, featuresParallax),
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/phone-product-dark.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
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
        ],
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
    final vendorParallax = (_scrollOffset - 1500) * 0.4;

    return SizedBox(
      height: 700,
      child: Stack(
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, vendorParallax),
              child: Image.asset(
                'assets/images/desk-workspace.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.darkBackground.withOpacity(0.85),
                    AppTheme.darkBackground.withOpacity(0.95),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ],
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

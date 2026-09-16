import 'package:flutter/material.dart';

import 'routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 120 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            children: [
              Text(
                'flutterFriday',
                style: TextStyle(
                  fontSize: isDesktop ? 72 : 48,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -2,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isDesktop ? 24 : 16),
              Text(
                '上傳圖片或用文字描述\nAI 幫你合成專屬手機殼',
                style: TextStyle(
                  fontSize: isDesktop ? 32 : 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade700,
                  height: 1.4,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isDesktop ? 40 : 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.create);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 40 : 32,
                    vertical: 18,
                  ),
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(980),
                  ),
                ),
                child: const Text(
                  '開始創作',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '先免費體驗',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: isDesktop ? 80 : 56),
              Container(
                height: isDesktop ? 480 : 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_iphone,
                          size: isDesktop ? 80 : 60, 
                          color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text(
                        '待換：hero-preview.png',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Text(
                        '建議尺寸：800x400 px',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    
    return Container(
      color: Colors.grey.shade50,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 120 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            children: [
              Text(
                '簡單三步驟',
                style: TextStyle(
                  fontSize: isDesktop ? 56 : 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -1.5,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isDesktop ? 80 : 56),
              Wrap(
                spacing: isDesktop ? 48 : 32,
                runSpacing: isDesktop ? 80 : 56,
                alignment: WrapAlignment.center,
                children: [
                  _buildFeatureCard(
                    context,
                    icon: Icons.upload_file,
                    title: '圖文輸入',
                    description: '上傳你的照片或用文字描述你的創意想法',
                    placeholderName: 'feature-upload.png',
                    isDesktop: isDesktop,
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.auto_awesome,
                    title: 'AI 套殼',
                    description: 'AI 自動幫你生成獨特的手機殼設計',
                    placeholderName: 'feature-ai.png',
                    isDesktop: isDesktop,
                  ),
                  _buildFeatureCard(
                    context,
                    icon: Icons.phone_android,
                    title: '機型預覽',
                    description: '支援近 3 年主流機型的預覽效果',
                    placeholderName: 'feature-preview.png',
                    isDesktop: isDesktop,
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
    required String placeholderName,
    required bool isDesktop,
  }) {
    return SizedBox(
      width: isDesktop ? 280 : 300,
      child: Column(
        children: [
          Container(
            height: isDesktop ? 220 : 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: isDesktop ? 64 : 56, 
                      color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  Text(
                    '待換：$placeholderName',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: isDesktop ? 24 : 20),
          Text(
            title,
            style: TextStyle(
              fontSize: isDesktop ? 28 : 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: isDesktop ? 19 : 17,
              color: Colors.grey.shade600,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewDisclaimerSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 100 : 72,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            children: [
              Container(
                width: isDesktop ? 56 : 48,
                height: isDesktop ? 56 : 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline,
                  size: isDesktop ? 28 : 24,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: isDesktop ? 32 : 24),
              Text(
                '重要提醒',
                style: TextStyle(
                  fontSize: isDesktop ? 40 : 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -1,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isDesktop ? 24 : 20),
              Text(
                '預覽效果不保證等同於實際成品',
                style: TextStyle(
                  fontSize: isDesktop ? 24 : 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                  letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isDesktop ? 16 : 12),
              Text(
                '實際印製成品可能因印刷技術、材質、光線等因素與預覽有所差異\n'
                '建議下單前與客製廠商確認細節',
                style: TextStyle(
                  fontSize: isDesktop ? 19 : 17,
                  color: Colors.grey.shade600,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    
    return Container(
      color: Colors.grey.shade50,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 100 : 72,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            children: [
              Text(
                '完成設計後\n輕鬆找客製廠商',
                style: TextStyle(
                  fontSize: isDesktop ? 48 : 36,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -1.2,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isDesktop ? 24 : 20),
              Text(
                '我們會協助您開啟蝦皮搜尋「客製手機殼」\n'
                '您可以自由選擇合適的客製廠商進行製作',
                style: TextStyle(
                  fontSize: isDesktop ? 21 : 19,
                  color: Colors.grey.shade600,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isDesktop ? 40 : 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.create);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 32 : 28,
                        vertical: 16,
                      ),
                      backgroundColor: const Color(0xFF6C5CE7),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(980),
                      ),
                    ),
                    child: const Text(
                      '開始創作',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.vendor);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 32 : 28,
                        vertical: 16,
                      ),
                      foregroundColor: const Color(0xFF6C5CE7),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(980),
                      ),
                    ),
                    child: const Text(
                      '找客製廠商',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isDesktop ? 32 : 24),
              Text(
                '本平台不提供付款功能，請直接與客製廠商洽談',
                style: TextStyle(
                  fontSize: isDesktop ? 15 : 14,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpectationsManagementSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 100 : 72,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: Column(
            children: [
              Text(
                'AI 能力邊界說明',
                style: TextStyle(
                  fontSize: isDesktop ? 48 : 36,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isDesktop ? 72 : 56),
              Wrap(
                spacing: isDesktop ? 48 : 32,
                runSpacing: isDesktop ? 56 : 48,
                alignment: WrapAlignment.center,
                children: [
                  _buildCapabilityColumn(
                    context,
                    title: '可以做',
                    color: Colors.black,
                    items: [
                      '圖片風格化與合成套殼',
                      '文字描述生成殼面設計',
                      '近 3 年主流機型預覽',
                      '平面與簡單 3D 預覽效果',
                    ],
                    isDesktop: isDesktop,
                  ),
                  _buildCapabilityColumn(
                    context,
                    title: '不可做',
                    color: Colors.black,
                    items: [
                      '保證預覽效果等同實物',
                      '證件、授權用途設計',
                      '侵權、成人、暴力內容',
                      'App 內付款給蝦皮廠商',
                    ],
                    isDesktop: isDesktop,
                  ),
                  _buildCapabilityColumn(
                    context,
                    title: '暫緩開放',
                    color: Colors.black,
                    items: [
                      '多圖拼貼功能',
                      '品牌聯名合作',
                      'AR 擴增實境預覽',
                      '客製化材質選擇',
                    ],
                    isDesktop: isDesktop,
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
    required bool isDesktop,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: isDesktop ? 300 : 320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isDesktop ? 24 : 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: isDesktop ? 20 : 16),
          ...items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: isDesktop ? 14 : 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(top: 9, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: isDesktop ? 17 : 16,
                          height: 1.5,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 768;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 56 : 40,
      ),
      color: Colors.grey.shade50,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            children: [
              Text(
                'flutterFriday',
                style: TextStyle(
                  fontSize: isDesktop ? 17 : 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade900,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'AI 手機殼創作平台',
                style: TextStyle(
                  fontSize: isDesktop ? 14 : 13,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: isDesktop ? 24 : 20),
              Divider(color: Colors.grey.shade300, height: 1),
              SizedBox(height: isDesktop ? 24 : 20),
              Text(
                '© 2026 flutterFriday. 僅供個人創作使用。',
                style: TextStyle(
                  fontSize: isDesktop ? 13 : 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

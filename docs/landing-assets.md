# Landing Page 待換素材清單

本文件列出 Landing Page（首頁）中使用的占位圖片，待正式素材準備好後需替換。

## 素材清單

### Hero 區塊

1. **hero-preview.png**
   - 位置：首頁最上方 Hero 區塊
   - 用途：展示手機殼設計預覽效果的範例圖
   - 建議尺寸：800x400 px
   - 格式：PNG
   - 說明：應展示應用程式的核心價值，例如展示多個精美的手機殼設計成品

### 功能區塊

2. **feature-upload.png**
   - 位置：三大核心功能 → 圖文輸入卡片
   - 用途：說明圖片上傳或文字輸入功能
   - 建議尺寸：320x200 px
   - 格式：PNG
   - 說明：應展示上傳介面或文字描述的示意圖

3. **feature-ai.png**
   - 位置：三大核心功能 → AI 套殼卡片
   - 用途：說明 AI 生成手機殼設計的功能
   - 建議尺寸：320x200 px
   - 格式：PNG
   - 說明：應展示 AI 處理過程或生成結果的示意圖

4. **feature-preview.png**
   - 位置：三大核心功能 → 機型預覽卡片
   - 用途：說明手機機型預覽功能
   - 建議尺寸：320x200 px
   - 格式：PNG
   - 說明：應展示不同手機機型的預覽效果

## 素材替換方式

1. 將準備好的圖片放置在專案的 `assets/images/` 目錄下
2. 在 `pubspec.yaml` 中的 `flutter` 區塊加入 assets 設定：
   ```yaml
   flutter:
     uses-material-design: true
     assets:
       - assets/images/
   ```
3. 修改 `lib/app/home_page.dart`，將占位的 Container 替換為 Image.asset：
   ```dart
   // 替換前（占位）
   Container(
     height: 400,
     decoration: BoxDecoration(...),
     child: Center(child: Text('待換：hero-preview.png')),
   )
   
   // 替換後（實際圖片）
   ClipRRect(
     borderRadius: BorderRadius.circular(16),
     child: Image.asset(
       'assets/images/hero-preview.png',
       height: 400,
       fit: BoxFit.cover,
     ),
   )
   ```

## 注意事項

- 所有圖片應經過優化，避免檔案過大影響網頁載入速度
- 建議使用 PNG 格式以保持透明背景（如需要）
- 圖片內容應符合 flutterFriday 的品牌風格與使用情境
- 避免使用有版權爭議的圖片

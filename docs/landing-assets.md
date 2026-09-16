# flutterFriday Landing Page 待換素材清單

本文件列出 Landing 頁面與 App 流程中所有需要替換的占位資源。

## 首頁 (HomePage) 素材

### Hero 區塊
- **hero-preview.png**
  - 位置：首頁頂部 Hero 區塊
  - 建議尺寸：800x400 px
  - 說明：展示 App 主要功能的預覽圖，可以是手機殼設計範例或操作介面截圖

### 功能說明區塊
- **feature-upload.png**
  - 位置：三大核心功能 - 圖文輸入卡片
  - 建議尺寸：320x200 px
  - 說明：展示上傳圖片或輸入文字的介面

- **feature-ai.png**
  - 位置：三大核心功能 - AI 套殼卡片
  - 建議尺寸：320x200 px
  - 說明：展示 AI 生成手機殼設計的過程或結果

- **feature-preview.png**
  - 位置：三大核心功能 - 機型預覽卡片
  - 建議尺寸：320x200 px
  - 說明：展示不同手機機型的預覽效果

## App 流程頁面素材

### AI 生成頁面 (AiComposePage)
- **ai-generated-design.png**
  - 位置：AI 生成完成後的設計展示
  - 建議尺寸：400x400 px 或符合手機殼設計比例
  - 說明：AI 生成的手機殼設計範例

### 機型預覽頁面 (DevicePreviewPage)
- **device-preview-[機型名稱].png**
  - 位置：選擇機型後的預覽區域
  - 建議尺寸：300x600 px（手機外觀比例）
  - 說明：針對每個支援的機型，需要一張該機型套用設計的預覽圖
  - 範例檔名：
    - `device-preview-iPhone 15 Pro Max.png`
    - `device-preview-Samsung Galaxy S24 Ultra.png`
    - `device-preview-Google Pixel 8 Pro.png`
  - 注意：可以只準備常見機型的預覽圖，其他機型暫時共用通用預覽圖

### 廠商頁面 (FindVendorPage)
- **final-preview.png**
  - 位置：尋找廠商頁面的最終設計預覽
  - 建議尺寸：250x500 px（手機外觀比例）
  - 說明：完整的手機殼設計成品預覽，可作為與廠商溝通的參考圖

## 素材優先順序

### 高優先級（建議優先替換）
1. hero-preview.png - 影響首頁第一印象
2. ai-generated-design.png - 展示核心功能成果
3. feature-ai.png - 說明核心 AI 功能

### 中優先級
4. feature-upload.png - 功能說明
5. feature-preview.png - 功能說明
6. final-preview.png - 最終成果展示

### 低優先級（可延後處理）
7. device-preview-[機型名稱].png - 數量較多，可分階段補充

## 素材格式建議

- **格式**：PNG（支援透明背景）或 JPG
- **解析度**：建議使用 2x 或更高解析度以確保在高 DPI 螢幕上清晰
- **檔案大小**：建議單檔小於 500KB，以確保網頁載入速度
- **色彩**：建議配合 App 主題色（紫色系）

## 放置位置

所有素材應放置在：
```
/workspace/assets/images/
```

## 更新步驟

1. 將素材檔案放入 `assets/images/` 資料夾
2. 確保檔名與上述清單相符（或在程式碼中更新參照路徑）
3. 運行 `flutter pub get` 確保資源被正確載入
4. 測試各頁面確認素材正確顯示

## 注意事項

- 所有素材必須確保有合法使用授權
- 避免使用有版權爭議的圖片
- 建議使用原創設計或購買正版素材
- 人物肖像需確保已取得肖像權授權

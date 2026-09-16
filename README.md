# flutterFriday - AI 手機殼創作平台

一個基於 Flutter Web 的 AI 手機殼設計平台，讓使用者透過上傳圖片或文字描述，由 AI 協助生成專屬的手機殼設計。

## 專案概述

flutterFriday 是一個 MVP（Minimum Viable Product）階段的 Flutter Web 應用程式，主要功能包括：

1. **Landing 首頁**：展示平台特色與主要功能
2. **創作流程**：四步驟完整的手機殼設計流程
3. **廠商導流**：協助使用者找到客製手機殼廠商

## 技術架構

- **框架**：Flutter 3.47.4 (stable)
- **平台**：Web Only
- **路由**：go_router 14.8.1
- **外部連結**：url_launcher 6.3.2

## 專案結構

```
flutterfriday/
├── lib/
│   ├── main.dart                    # 應用程式入口
│   ├── app/                         # 頁面元件
│   │   ├── home_page.dart          # Landing 首頁（"/" 路由）
│   │   ├── create_input_page.dart  # 創作輸入頁
│   │   ├── ai_compose_page.dart    # AI 生成頁
│   │   ├── device_preview_page.dart # 機型預覽頁
│   │   └── find_vendor_page.dart   # 尋找廠商頁
│   └── routes/                      # 路由配置
│       ├── app_routes.dart         # 路由常數定義
│       └── router_config.dart      # go_router 設定
├── assets/
│   └── images/                      # 圖片素材資料夾（待補充）
├── docs/
│   └── landing-assets.md           # 待換素材清單
├── web/                             # Web 平台設定
├── pubspec.yaml                     # 依賴管理
└── README.md                        # 本文件
```

## 路由結構

### 路由定義

| 路由路徑 | 頁面元件 | 說明 |
|---------|---------|------|
| `/` | `HomePage` | Landing 首頁，主 CTA 導向 `/create` |
| `/create` | `CreateInputPage` | 步驟 1：上傳圖片或輸入文字 |
| `/ai-compose` | `AiComposePage` | 步驟 2：AI 生成設計 |
| `/device-preview` | `DevicePreviewPage` | 步驟 3：選擇機型預覽 |
| `/find-vendor` | `FindVendorPage` | 步驟 4：尋找客製廠商 |

### 路由流程

```
首頁 (/)
  └─> [開始創作] 按鈕
       └─> 創作輸入 (/create)
            └─> AI 生成 (/ai-compose)
                 └─> 機型預覽 (/device-preview)
                      └─> 尋找廠商 (/find-vendor)
                           └─> [前往蝦皮] 或 [返回首頁]
```

### 資料傳遞

頁面間透過 `go_router` 的 `extra` 參數傳遞資料：

- `create_input` → `ai_compose`：傳遞使用者輸入（圖片或文字）
- `ai_compose` → `device_preview`：傳遞生成的設計資料
- `device_preview` → `find_vendor`：傳遞選擇的機型與預覽資料

## Landing 首頁功能

### 必含區塊

1. **Hero 區塊**
   - 產品名稱：flutterFriday
   - 主標語：上傳圖片或用文字描述，AI 幫你合成專屬手機殼
   - 主 CTA：「開始創作」按鈕 → 導航至 `/create`
   - 免費標示：先免費體驗

2. **功能說明**
   - 圖文輸入
   - AI 套殼
   - 機型預覽（支援近 3 年主流機型）

3. **預覽免責聲明**
   - 明確標示：「預覽效果不保證等同於實際成品」
   - 橘色警告區塊，確保使用者注意

4. **廠商導流說明**
   - 主 CTA：進入創作流程
   - 次要 CTA：直接開啟蝦皮搜尋「客製手機殼」
   - 說明：不指定廠商、無 App 內付款

5. **AI 能力邊界**（頁尾）
   - ✅ 可以做：圖風格化、文生圖、機型預覽
   - ❌ 不可做：保證預覽=實物、證件用途、侵權內容、App 內付款
   - ⏸️ 暫緩：多圖拼貼、聯名、AR

## 創作流程說明

### 步驟 1：創作輸入 (`/create`)
- 選擇輸入方式：文字描述或上傳圖片
- 文字輸入：自由描述想要的設計
- 圖片上傳：選擇要套用的圖片（UI 已實作，後端功能待開發）

### 步驟 2：AI 生成 (`/ai-compose`)
- 模擬 AI 生成過程（3 秒載入動畫）
- 展示生成的設計（目前為占位圖）
- 提供「重新創作」與「下一步」選項

### 步驟 3：機型預覽 (`/device-preview`)
- 列出近 3 年主流機型（iPhone、Samsung、Google Pixel、小米等）
- 選擇機型後顯示預覽效果
- 再次提醒：預覽不保證等同實物

### 步驟 4：尋找廠商 (`/find-vendor`)
- 展示最終設計預覽
- 說明如何找客製廠商
- 主 CTA：開啟蝦皮搜尋「客製手機殼」
- 重要提醒：平台不指定廠商、不提供付款功能

## 開發指令

### 安裝依賴
```bash
flutter pub get
```

### 本地開發（熱重載）
```bash
flutter run -d chrome
```

### 程式碼檢查
```bash
flutter analyze
```

### 建置生產版本
```bash
flutter build web
```

建置完成後，產出檔案位於 `build/web/` 資料夾。

### 部署到 GitHub Pages

1. 建置專案：
```bash
flutter build web --base-href "/flutterfriday/"
```

2. 將 `build/web/` 內容推送至 `gh-pages` 分支

## 待補充素材

請參考 [`docs/landing-assets.md`](docs/landing-assets.md) 了解所有需要替換的占位圖片清單。

### 高優先級素材
1. `hero-preview.png` - 首頁 Hero 區塊預覽圖
2. `ai-generated-design.png` - AI 生成設計範例
3. `feature-ai.png` - AI 功能說明圖

所有素材應放置於 `assets/images/` 資料夾。

## 約束與限制

### 功能限制
- ✅ 已實作：完整 UI/UX 流程、路由導航、外部連結
- ⏸️ 未實作：實際的圖片上傳、AI 生成、機型 3D 預覽
- ❌ 不實作：App 內付款、指定廠商、保證實物效果

### 審核重點
- 預覽免責聲明必須明確可見
- AI 能力邊界說明必須完整
- 不得暗示保證預覽效果
- 不得提供 App 內蝦皮付款

### UI 要求
- 響應式設計，支援各種螢幕尺寸
- 內容可捲動，避免 overflow 裁切
- 按鈕與互動元件有明確的視覺回饋

## 與現有 App 串接

### 進入點
- Landing 頁面 (`/`) 為所有使用者的第一個進入點
- 主 CTA「開始創作」導航至 `/create` 開始創作流程

### 流程串接
```
Landing (/) 
    → Create (/create) 
    → AI Compose (/ai-compose) 
    → Device Preview (/device-preview) 
    → Find Vendor (/find-vendor)
    → 外部連結（蝦皮）或返回首頁
```

### 路由保護
- 目前無路由保護機制（未來可依需求加入）
- 使用者可直接存取任何路由
- 建議流程：依序完成各步驟

## 未來擴充方向

### 短期
- 補充完整素材圖片
- 實作圖片上傳功能（需後端 API）
- 整合實際的 AI 生成服務

### 中期
- 使用者帳號系統
- 設計歷史記錄
- 社群分享功能
- 更多機型支援

### 長期
- AR 預覽功能
- 多圖拼貼
- 品牌聯名
- 直接對接印刷廠商 API

## 授權與使用

- 本專案為 MVP 示範專案
- 僅供個人創作使用
- 請勿用於證件、商業授權等用途
- 產生的內容不得侵犯他人版權

## 聯絡資訊

專案維護者：flutterFriday Team

---

**最後更新**：2026-09-16
**版本**：v2.0 (Landing 定稿版)

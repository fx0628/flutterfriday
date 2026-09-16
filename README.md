# flutterFriday（本地 Web MVP 備援）

免費 AI 手機殼設計預覽：上傳圖片或輸入文字 → Mock AI 合成 → 裝置預覽 →「找客製廠商」（Shopee 外部搜尋）。**不含付費牆、不含 App 內結帳。**

> 正式 Origin／GitHub repo 由 Cloud Agent 處理；本目錄為本地備援 scaffold。

## 需求

- Flutter SDK（穩定版，建議放在 `/home/box/flutter`）
- Chrome（`flutter run -d chrome`）

```bash
export PATH="/home/box/flutter/bin:$PATH"
flutter --version
```

## 如何執行

```bash
cd /workspace/flutterfriday-app
flutter pub get
flutter run -d chrome
```

或建置靜態 Web：

```bash
cd /workspace/flutterfriday-app
flutter pub get
flutter build web
```

產物目錄：`build/web/`（可交給靜態託管或「發布審核」流程）。

## 主要模組（`lib/`）

| 路徑 | 說明 |
|------|------|
| `app/` | MaterialApp、路由、主題、首頁、免費徽章、錯誤避免白屏 |
| `features/create_input/` | 選 JPG/PNG 或輸入文字；內容過濾 stub（證件／身分證／成人／暴力／侵權） |
| `features/ai_compose/` | `MockAiAdapter`：短延遲後回傳 ColorFilter／圖騰 placeholder，**不呼叫付費 API** |
| `features/device_preview/` | 機型清單、軟殼／透明殼、≥3 機型切換、免責「預覽僅供參考…」 |
| `features/find_vendor/` | Shopee `https://shopee.tw/search?keyword=` + `客製手機殼`（可加機型）；`url_launcher` 外部開啟；3 個示範店家佔位 |

### 路由

- `/` 首頁
- `/create` 建立輸入（Landing CTA）
- `/composing` 合成進度
- `/preview` 裝置預覽
- `/vendor` 找客製廠商

流程：`CreateInput → composing → DevicePreview → FindVendor`

## 交給「發布審核」

1. 本機執行 `flutter build web`（成功後確認 `build/web/index.html` 存在）。
2. 將整個 `build/web/` 目錄打包或掛載給審核／靜態託管。
3. 勿承諾預覽＝實物；勿接 App 內 Shopee 付款。

## AI／產品邊界（摘要）

- **可做**：圖片風格化／合成、文字→殼圖、平面／簡易預覽
- **不可**：預覽保證等同實物、證件類、侵權／成人／暴力（阻擋＋重試）、App 內結帳
- **延後**：拼貼、共創模板、AR

## 授權注意

本專案為本地 MVP scaffold，請勿公開部署含侵權素材之內容。

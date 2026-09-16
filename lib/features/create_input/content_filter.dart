/// 內容過濾 stub：阻擋證件／身分證／成人／暴力／侵權等關鍵字（佔位）
class ContentFilterResult {
  const ContentFilterResult({required this.blocked, this.reason});

  final bool blocked;
  final String? reason;
}

class ContentFilter {
  static const List<String> _blockedKeywords = [
    '證件',
    '身分證',
    '身份證',
    '護照',
    '成人',
    '色情',
    '暴力',
    '血腥',
    '侵權',
    '盜版',
    'copyright',
    'nsfw',
  ];

  /// 檢查文字；若命中則 blocked=true，並請使用者重試
  static ContentFilterResult checkText(String text) {
    final lower = text.toLowerCase();
    for (final kw in _blockedKeywords) {
      if (lower.contains(kw.toLowerCase())) {
        return ContentFilterResult(
          blocked: true,
          reason: '內容可能涉及「$kw」相關素材，請修改後再試。'
              '（不支援證件／身分證、成人、暴力、侵權內容）',
        );
      }
    }
    return const ContentFilterResult(blocked: false);
  }

  /// 圖檔僅做副檔名／檔名 stub 檢查（正式版可接 CV 審核）
  static ContentFilterResult checkImageFileName(String? name) {
    if (name == null || name.isEmpty) {
      return const ContentFilterResult(blocked: false);
    }
    return checkText(name);
  }
}

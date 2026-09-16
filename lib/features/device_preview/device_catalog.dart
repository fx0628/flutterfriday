/// 支援機型目錄（暫定）
class PhoneDevice {
  const PhoneDevice({
    required this.id,
    required this.brand,
    required this.name,
    this.comingSoon = false,
  });

  final String id;
  final String brand;
  final String name;
  final bool comingSoon;

  String get displayName => '$brand $name';
}

enum CaseFinish { soft, transparent }

extension CaseFinishLabel on CaseFinish {
  String get labelTw => switch (this) {
        CaseFinish.soft => '軟殼',
        CaseFinish.transparent => '透明殼',
      };
}

class DeviceCatalog {
  static const List<PhoneDevice> all = [
    // iPhone 15
    PhoneDevice(id: 'iphone15', brand: 'Apple', name: 'iPhone 15'),
    PhoneDevice(id: 'iphone15_plus', brand: 'Apple', name: 'iPhone 15 Plus'),
    PhoneDevice(id: 'iphone15_pro', brand: 'Apple', name: 'iPhone 15 Pro'),
    PhoneDevice(
      id: 'iphone15_pro_max',
      brand: 'Apple',
      name: 'iPhone 15 Pro Max',
    ),
    // iPhone 16
    PhoneDevice(id: 'iphone16', brand: 'Apple', name: 'iPhone 16'),
    PhoneDevice(id: 'iphone16_plus', brand: 'Apple', name: 'iPhone 16 Plus'),
    PhoneDevice(id: 'iphone16_pro', brand: 'Apple', name: 'iPhone 16 Pro'),
    PhoneDevice(
      id: 'iphone16_pro_max',
      brand: 'Apple',
      name: 'iPhone 16 Pro Max',
    ),
    // iPhone 17（無資產時灰階「即將支援」）
    PhoneDevice(
      id: 'iphone17',
      brand: 'Apple',
      name: 'iPhone 17',
      comingSoon: true,
    ),
    PhoneDevice(
      id: 'iphone17_plus',
      brand: 'Apple',
      name: 'iPhone 17 Plus',
      comingSoon: true,
    ),
    PhoneDevice(
      id: 'iphone17_pro',
      brand: 'Apple',
      name: 'iPhone 17 Pro',
      comingSoon: true,
    ),
    PhoneDevice(
      id: 'iphone17_pro_max',
      brand: 'Apple',
      name: 'iPhone 17 Pro Max',
      comingSoon: true,
    ),
    // Galaxy
    PhoneDevice(id: 's23', brand: 'Samsung', name: 'Galaxy S23'),
    PhoneDevice(id: 's24', brand: 'Samsung', name: 'Galaxy S24'),
    PhoneDevice(id: 's25', brand: 'Samsung', name: 'Galaxy S25'),
    // Pixel
    PhoneDevice(id: 'pixel8', brand: 'Google', name: 'Pixel 8'),
    PhoneDevice(id: 'pixel8_pro', brand: 'Google', name: 'Pixel 8 Pro'),
    PhoneDevice(id: 'pixel9', brand: 'Google', name: 'Pixel 9'),
    PhoneDevice(id: 'pixel9_pro', brand: 'Google', name: 'Pixel 9 Pro'),
    PhoneDevice(id: 'pixel10', brand: 'Google', name: 'Pixel 10'),
    PhoneDevice(id: 'pixel10_pro', brand: 'Google', name: 'Pixel 10 Pro'),
    // Galaxy A
    PhoneDevice(id: 'a54', brand: 'Samsung', name: 'Galaxy A54'),
    PhoneDevice(id: 'a55', brand: 'Samsung', name: 'Galaxy A55'),
    PhoneDevice(id: 'a56', brand: 'Samsung', name: 'Galaxy A56'),
    // Xiaomi / Redmi
    PhoneDevice(id: 'xiaomi13t', brand: 'Xiaomi', name: '13T'),
    PhoneDevice(id: 'xiaomi14t', brand: 'Xiaomi', name: '14T'),
    PhoneDevice(id: 'redmi_note13', brand: 'Redmi', name: 'Note 13'),
    PhoneDevice(id: 'redmi_note14', brand: 'Redmi', name: 'Note 14'),
  ];

  static List<PhoneDevice> get selectable =>
      all.where((d) => !d.comingSoon).toList();
}

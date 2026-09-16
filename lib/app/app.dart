import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../features/ai_compose/compose_result.dart';
import '../features/ai_compose/composing_page.dart';
import '../features/create_input/create_input_page.dart';
import '../features/device_preview/device_catalog.dart';
import '../features/device_preview/device_preview_page.dart';
import '../features/find_vendor/find_vendor_page.dart';
import 'home_page.dart';
import 'routes.dart';
import 'theme.dart';

class FlutterFridayApp extends StatefulWidget {
  const FlutterFridayApp({super.key});

  @override
  State<FlutterFridayApp> createState() => _FlutterFridayAppState();
}

class _FlutterFridayAppState extends State<FlutterFridayApp> {
  bool _useUIB = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutterFriday',
      debugShowCheckedModeBanner: false,
      theme: _useUIB ? AppTheme.light() : AppTheme.dark(),
      builder: (context, child) {
        return UIVariantProvider(
          useUIB: _useUIB,
          child: child ?? const SizedBox.shrink(),
        );
      },
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) {
        // Check for /b route to enable UI-B
        if (settings.name == AppRoutes.uiB) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => _useUIB = true);
          });
          return MaterialPageRoute(
            settings: const RouteSettings(name: AppRoutes.home),
            builder: (_) => const HomePage(),
          );
        }
        
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const HomePage(),
            );
          case AppRoutes.create:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const CreateInputPage(),
            );
          case AppRoutes.composing:
            final args = settings.arguments;
            if (args is! Map) {
              return _errorRoute(settings, '缺少合成參數');
            }
            final source = args['source'];
            if (source is! ComposeSource) {
              return _errorRoute(settings, '合成來源無效');
            }
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => ComposingPage(
                source: source,
                imageBytes: args['imageBytes'] as Uint8List?,
                promptText: args['promptText'] as String?,
              ),
            );
          case AppRoutes.preview:
            final result = settings.arguments;
            if (result is! ComposeResult) {
              return _errorRoute(settings, '缺少預覽資料，請從建立流程開始');
            }
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => DevicePreviewPage(result: result),
            );
          case AppRoutes.vendor:
            final device = settings.arguments;
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => FindVendorPage(
                device: device is PhoneDevice ? device : null,
              ),
            );
          default:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => const HomePage(),
            );
        }
      },
    );
  }

  static MaterialPageRoute<void> _errorRoute(
    RouteSettings settings,
    String message,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('無法開啟')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.create,
                      (r) => false,
                    );
                  },
                  child: const Text('前往建立'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Provides UI variant context (A or B) to descendant widgets
class UIVariantProvider extends InheritedWidget {
  const UIVariantProvider({
    super.key,
    required this.useUIB,
    required super.child,
  });

  final bool useUIB;

  static UIVariantProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UIVariantProvider>();
  }

  static bool isUIB(BuildContext context) {
    final provider = maybeOf(context);
    return provider?.useUIB ?? false;
  }

  @override
  bool updateShouldNotify(UIVariantProvider oldWidget) {
    return useUIB != oldWidget.useUIB;
  }
}

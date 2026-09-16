import 'package:go_router/go_router.dart';
import '../app/home_page.dart';
import '../app/create_input_page.dart';
import '../app/ai_compose_page.dart';
import '../app/device_preview_page.dart';
import '../app/find_vendor_page.dart';
import 'app_routes.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.create,
      builder: (context, state) => const CreateInputPage(),
    ),
    GoRoute(
      path: AppRoutes.aiCompose,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return AiComposePage(
          inputData: extra?['inputData'],
        );
      },
    ),
    GoRoute(
      path: AppRoutes.devicePreview,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return DevicePreviewPage(
          designData: extra?['designData'],
        );
      },
    ),
    GoRoute(
      path: AppRoutes.findVendor,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return FindVendorPage(
          previewData: extra?['previewData'],
        );
      },
    ),
  ],
);

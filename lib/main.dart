import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/constants/app_strings.dart';
import 'app/core/theme/app_theme.dart';
import 'app/data/services/step_tracking_service.dart';
import 'app/data/services/user_preferences_service.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Get.putAsync(() => UserPreferencesService().init());
    Get.put<StepTrackingService>(StepTrackingServiceImpl(), permanent: true);
  } catch (e) {
    debugPrint("Service initialization error: $e");
  }

  runApp(const VeloraApp());
}

class VeloraApp extends StatelessWidget {
  const VeloraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.cupertino,
    );
  }
}

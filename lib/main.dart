import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mvvm/routes/app_pages.dart';
import 'package:flutter_mvvm/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_mvvm/core/theme/app_theme.dart';
import 'package:flutter_mvvm/view_models/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(ThemeController());
      }),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: Routes.home,
      getPages: AppPages.pages,
    );
  }
}

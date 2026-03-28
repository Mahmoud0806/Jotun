import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_config/default_settings.dart';
import 'core/navigation/app_routers.dart';
import 'lang/localization_service.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          title: "AEC Mobile",
          debugShowCheckedModeBanner: false,
          textDirection: DefaultSetting.appDirection,
          locale: DefaultSetting.locale,
          fallbackLocale: LocalizationService.fallbackLocale,
          translations: LocalizationService(),
          initialRoute: AppRouters.initRoute,
          getPages: AppRouters.PAGES,
          defaultTransition: Transition.leftToRightWithFade,

        );
      },
    );


  }
}

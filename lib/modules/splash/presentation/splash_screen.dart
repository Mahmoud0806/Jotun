import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jotun/core/app_colors.dart';
import 'package:jotun/modules/start/presentation/start_screen.dart';
import '../../../widget/logo1.dart';
import '../controllers/splash_controller.dart';
import 'splash_state.dart';

class SplashScreen extends StatelessWidget {
  SplashController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx((){
        if(controller.pageState.value==SplashState.loading){
          return Center(
            child: Logo1(
              width: MediaQuery.of(context).size.width*.75,
              height: MediaQuery.of(context).size.height*.25,
            ),
          );
        }else{
         return Container();
        }
      })
    );
  }
}

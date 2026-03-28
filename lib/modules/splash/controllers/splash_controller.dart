import 'dart:convert';

import 'package:get/get.dart';
import 'package:jotun/core/net/response/base_response.dart';
import 'package:jotun/modules/home_page/presentation/home_page_state.dart';
import '../../../app_config/default_settings.dart';
import '../../sign_in/model/response/user_model.dart';
import '../model/response/auth.dart';
import '../services/splash_service.dart';
import '../presentation/splash_state.dart';

class SplashController extends GetxController {
  final _service = SplashService();
  Rx<SplashState> pageState = SplashState.initial.obs;
  var isSignedIn=false.obs;
  static late Auth auth;
  static late var noAuth=false.obs;
  late BaseResponse baseResponse;

  @override
  void onReady() async{
    pageState.value=SplashState.loading;
    DefaultSetting.user=await User().readData();
    await checkAuth();
    pageState.value=SplashState.initial;
    super.onReady();
  }

   checkAuth()async{
    if(DefaultSetting.user!=null&&DefaultSetting.user.accessToken!=null){
      baseResponse=await _service.checkAuth(DefaultSetting.user.accessToken!);
      if(baseResponse!=null){
        if(baseResponse.status==200){
          auth=Auth.fromJson(baseResponse.data);
          DefaultSetting.user.userableType=auth.userableType;
          DefaultSetting.user.saveData();
          if(auth.isActive==1){
            if(auth.userableType!="observer"){
              isSignedIn(true);
              Get.offAllNamed('/main_app');
              noAuth(false);
            }else{
              Get.toNamed('/start');
              noAuth(true);
            }

          }else{
            Get.toNamed('/start');
            noAuth(true);
          }
        }else{
          Get.toNamed('/start');
          noAuth(true);
        }
      }else{
        Get.toNamed('/start');
        noAuth(true);
      }
    }else{
      Get.toNamed('/start');
      noAuth(true);

    }

  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jotun/modules/sign_up/model/response/sign_up.dart';
import '../../account/model/response/citities_model.dart';
import '../../sign_in/presentation/sign_in_state.dart';
import '../model/request/sign_up_data.dart';
import '../services/sign_up_service.dart';
import '../presentation/sign_up_state.dart';
import '../../../core/net/response/base_response.dart';

class SignUpController extends GetxController {
  final _service = SignUpService();
  Rx<SignUpState> pageState = SignUpState.initial.obs;
  late BaseResponse baseResponse;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = new GlobalKey<ScaffoldMessengerState>();
  String phoneNumber="",password="",passwordConfirmation="",fstName="",lstName="";
  int cityId=-1;
  late Cities cities;
  City selectedCity=City(id: -1, name: 'name');

  void showInSnackBar(String value) {
    scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<void> signUp(SignUpData signUpData) async{
    pageState.value=SignUpState.buttonLoading;
    baseResponse=await _service.signUp(signUpData);
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.status);
        if(baseResponse.success==true){
          SignUp signUp=SignUp.fromJson(baseResponse.data);
          if(signUp!=null){
            showInSnackBar("Signed Up successfully");
            Get.offNamed('/verify_account',arguments: [signUpData.phoneNumber,false]);
          }else{
            showInSnackBar(baseResponse.error);
            pageState.value=SignUpState.initial;
          }
        }
      }else{
        showInSnackBar(baseResponse.error);
        pageState.value=SignUpState.initial;
      }
    }else{
      showInSnackBar("No Internet Connection");
      pageState.value=SignUpState.initial;
    }
    pageState.value=SignUpState.initial;

  }


  @override
  void onInit() {
    pageState.value=SignUpState.loading;
    getCities();
    super.onInit();
  }

  @override
  void onReady() async {

    super.onReady();
  }

  bool checkCompletion(){
    return phoneNumber.isNotEmpty&&password.isNotEmpty&&passwordConfirmation.isNotEmpty&&fstName.isNotEmpty&&lstName.isNotEmpty;
  }
  bool checkPassword(){
    return password==passwordConfirmation;
  }
  getNameByLang(City? city) {
    if (city == null) return '';
    return city.name;
  }
  applyFilter(City city, String? text) {
    return city.isContain(text);
  }
  getCities()async{
    baseResponse=await _service.getCities();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.data);
        cities=Cities.fromJson(baseResponse.data);
        pageState.value=SignUpState.initial;
      }
    }
  }

  changeSelectedCity(City city){
    selectedCity=city;
  }

}

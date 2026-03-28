import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jotun/core/net/response/base_response.dart';
import 'package:jotun/modules/home_page/controllers/home_page_controller.dart';
import 'package:jotun/modules/home_page/model/response/campaign.dart';
import 'package:jotun/modules/my_points/model/request/claim.dart';
import 'package:jotun/modules/my_points/model/response/my_points.dart';
import '../../../core/app_colors.dart';
import '../services/my_points_service.dart';
import '../presentation/my_points_state.dart';

class MyPointsController extends GetxController {
  final _service = MyPointsService();
  var steps = 0.0.obs;
  var height = 0.0.obs;
  var heightCurrent = 0.0.obs;
  var current = 0.0.obs;
  late Points points;
  late BaseResponse baseResponse;
  double constHeight = 1;
  var noCampaign=false.obs;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = new GlobalKey<ScaffoldMessengerState>();


  @override
  void onReady() async {
    await getPoints();
    pageState.value = MyPointsState.initial;
    super.onReady();
  }

  Rx<MyPointsState> pageState = MyPointsState.loading.obs;

  getPoints() async {
    baseResponse = await _service.getPoints();
    if (baseResponse != null) {
      if (baseResponse.status == 200) {
        points = Points.fromJson(baseResponse.data);
        if (points == null || points.allGifts.isEmpty) {
            print("No Campaign now !!");

        } else {
          print(" Campaign now !!");
          Gift gift=Gift(id: -1, points: '0', image: '');
          points.allGifts.insert(0,gift);
          steps.value = points.allGifts.length.toDouble();
          points.allGifts
              .sort((a, b) => getGiftPoints(a).compareTo(getGiftPoints(b)));

        }

      }else{
        noCampaign(true);
      }
    }
  }

  getGiftPoints(Gift a) {
    return double.parse(a.points!);
  }

  getPadding(int index) {
    if (index == 0) {
      return ((double.parse(points.allGifts[index + 1].points!)) * constHeight);
    } else if (index == points.allGifts.length - 1) {
      return 0.0;
    } else {
      print(double.parse(points.allGifts[index].points!));
      print(double.parse(points.allGifts[index + 1].points!));
      var y = double.parse(points.allGifts[index + 1].points!) -
          double.parse(points.allGifts[index].points!);
      y = y * constHeight;
      return y;
    }
  }

  getTotalLength() {
    return (double.parse(points.maxPoints!) * constHeight) +
        points.allGifts.length * 30;
  }

  getCurrentLength() {
    if(points.allPoints==0){
      return ((points.allPoints!.toDouble() * constHeight) +
          (getMyStepNumber() * 30));
    }
    return ((points.allPoints!.toDouble() * constHeight) +
        (getMyStepNumber() * 30)) + 20;
  }

  getMyStepNumber() {
    int steps = 0;
    if (points.allPoints!.toDouble() == double.parse(points.maxPoints!)) {
      points.allGifts.forEach((element) {
        if (double.parse(element.points!) <= points.allPoints!) steps++;
      });
    } else {
      points.allGifts.forEach((element) {
        if (double.parse(element.points!) < points.allPoints!) steps++;
      });
    }

    return steps;
  }

  sendRequest()async{
    pageState.value=MyPointsState.sendingRequest;
    ClaimData claimData=ClaimData(
      campaignId: HomePageController.campaign.id!
    );
    BaseResponse response=await _service.sendRequest(claimData);
    if(response!=null){
      if(response.status==200){
        scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(
            "تم الحفظ بنجاح",
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "BahijPlain",
              color: AppColors.white,
            ),
          ),
          duration: const Duration(milliseconds: 1500),
        ));
        getPoints();
      }else{
        scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(
            response.error,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "BahijPlain",
              color: AppColors.white,
            ),
          ),
          duration: const Duration(milliseconds: 1500),
        ));
      }
    }

    pageState.value=MyPointsState.initial;

  }
}

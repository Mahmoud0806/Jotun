import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jotun/app_config/default_settings.dart';
import 'package:jotun/core/app_colors.dart';
import 'package:jotun/modules/categories/presentation/categories_screen.dart';
import 'package:jotun/modules/home_page/presentation/home_page_screen.dart';
import 'package:jotun/modules/receipt/presentation/receipt_screen.dart';
import '../../../core/size_config.dart';
import '../../account/presentation/account_screen.dart';
import '../controllers/main_app_controller.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'nav_bar_design/custom_nav_bar.dart';

class MainAppScreen extends StatefulWidget {
  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  MainAppController controller = Get.find();
  var navBarTitles = ["home".tr, "my_receipt".tr, "account".tr];

  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    if(DefaultSetting.user.userableType=="member"){
      return [
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            "assets/icons/home.svg",
            width: getProportionateScreenWidth(30),
            height: getProportionateScreenWidth(30),
            color: _controller.index==0?AppColors.selectedNavBarItem:AppColors.unSelectedNavBarItem,
          ),
          title: ("home".tr),
        ),
        PersistentBottomNavBarItem(
          onPressed: (value) {},
          icon: SvgPicture.asset(
            "assets/icons/categories.svg",
            width: getProportionateScreenWidth(30),
            height: getProportionateScreenWidth(30),
            color: _controller.index==1?AppColors.selectedNavBarItem:AppColors.unSelectedNavBarItem,
          ),
          title: ("categories".tr),
        ),

        PersistentBottomNavBarItem(
          onPressed: (value) {},
          icon: SvgPicture.asset(
            "assets/icons/scan_icon.svg",
            width: getProportionateScreenWidth(30),
            height: getProportionateScreenWidth(30),
            color: _controller.index==2?AppColors.selectedNavBarItem:AppColors.unSelectedNavBarItem,
          ),
          title: ("my_receipt".tr),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            "assets/icons/account.svg",
            width: getProportionateScreenWidth(30),
            height: getProportionateScreenWidth(30),
            color: _controller.index==3?AppColors.selectedNavBarItem:AppColors.unSelectedNavBarItem,
          ),
          title: ("profile".tr),
          onPressed: (value) {},
        ),
      ];
    }else{
      return [
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            "assets/icons/home.svg",
            width: getProportionateScreenWidth(30),
            height: getProportionateScreenWidth(30),
            color: _controller.index==0?AppColors.selectedNavBarItem:AppColors.unSelectedNavBarItem,
          ),
          title: ("home".tr),
        ),
        PersistentBottomNavBarItem(
          onPressed: (value) {},
          icon: SvgPicture.asset(
            "assets/icons/categories.svg",
            width: getProportionateScreenWidth(30),
            height: getProportionateScreenWidth(30),
            color: _controller.index==1?AppColors.selectedNavBarItem:AppColors.unSelectedNavBarItem,
          ),
          title: ("categories".tr),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            "assets/icons/account.svg",
            width: getProportionateScreenWidth(30),
            height: getProportionateScreenWidth(30),
            color: _controller.index==3?AppColors.selectedNavBarItem:AppColors.unSelectedNavBarItem,
          ),
          title: ("profile".tr),
          onPressed: (value) {},
        ),
      ];

    }
  }

  List<Widget> _buildScreens() {
    if(DefaultSetting.user.userableType=="member"){
      return [
        HomePageScreen(),
        CategoriesScreen(),
        ReceiptScreen(),
        AccountScreen(),
      ];
    }else {
      return [
        HomePageScreen(),
        CategoriesScreen(),
        AccountScreen(),
      ];
    }

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PersistentTabView.custom(
      context,
      controller: _controller,
      itemCount: DefaultSetting.user.userableType=="member"?4:3,
      // This is required in case of custom style! Pass the number of items for the nav bar.
      screens: _buildScreens(),
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      navBarHeight: 75,
      customWidget: (navBarEssentials) => CustomNavBarWidget(
        // Your custom widget goes here
        items: _navBarsItems(),
        selectedIndex: _controller.index,
        onItemSelected: (index) {
          setState(() {
            _controller.index =
                index; // NOTE: THIS IS CRITICAL!! Don't miss it!
          });
        },
      ),
    );
  }
}

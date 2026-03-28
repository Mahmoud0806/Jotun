
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jotun/app.dart';
import 'package:jotun/firebase/firebase_notifications.dart';

import 'core/net/http_overrides.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// In case of network handshake error
  HttpOverrides.global = new BadCertHttpOverrides();
  await Firebase.initializeApp();
  FireBaseNotifications notifications=await Get.put(FireBaseNotifications());
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final fcmToken = await _fcm.getToken();
  print('fcmToken  : $fcmToken');
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());

}










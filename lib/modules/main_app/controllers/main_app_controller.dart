import 'package:get/get.dart';
import '../services/main_App_service.dart';
import '../presentation/main_App_state.dart';

class MainAppController extends GetxController {
  final _service = MainAppService();
  Rx<MainAppState> pageState = MainAppState.initial.obs;
}

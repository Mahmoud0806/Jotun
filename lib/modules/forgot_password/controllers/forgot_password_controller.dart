import 'package:get/get.dart';
import '../services/forgot_password_service.dart';
import '../presentation/forgot_password_state.dart';

class ForgotPasswordController extends GetxController {
  final _service = ForgotPasswordService();
  Rx<ForgotPasswordState> pageState = ForgotPasswordState.initial.obs;
}

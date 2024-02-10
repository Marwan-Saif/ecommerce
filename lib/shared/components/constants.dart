import 'package:e_commerce_app/modules/Login/login_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/network/local/cach_helper.dart';

void signOut(context) {
  CachHelper.removeData(key: 'token').then((value) {
    if (value!) {
      navigateWithReplacment(context, LoginScreen());
    }
  });
}

String token = "";

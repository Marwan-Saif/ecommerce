import 'package:e_commerce_app/modules/Login/login_states.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {
  ShopSuccessHomeState() {
    print("success");
  }
}

class ShopLoadingHomeState extends ShopStates {
  LoginLoadingState() {
    print("loading");
  }
}

class ShopErrorHomeState extends ShopStates {
  final String error;

  ShopErrorHomeState({required this.error}) {
    print("error");
    print(error);
  }
}

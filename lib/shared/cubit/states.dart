// ignore_for_file: avoid_print


abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {
  ShopSuccessHomeState() {
    print("success");
  }
}

class ShopLoadingHomeState extends ShopStates {
  // ignore: non_constant_identifier_names
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

class ShopSuccessCategoriesState extends ShopStates {
  ShopSuccessCategoriesState() {
    print("Categories success");
  }
}

class ShopLoadingCategoriesState extends ShopStates {
  ShopLoadingCategoriesState() {
    print("Categories loading");
  }
}

class ShopErrorCategoriesState extends ShopStates {
  final String error;

  ShopErrorCategoriesState({required this.error}) {
    print("Categories  error");
    print(error);
  }
}

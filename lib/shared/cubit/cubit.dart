import 'package:e_commerce_app/models/home_model.dart';
import 'package:e_commerce_app/modules/cateogries/categories_screen.dart';
import 'package:e_commerce_app/modules/favorites/favorites_screen.dart';
import 'package:e_commerce_app/modules/products/products_screen.dart';
import 'package:e_commerce_app/modules/settings/settings_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/cubit/states.dart';
import 'package:e_commerce_app/shared/network/end_points.dart';
import 'package:e_commerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printAll(homeModel!.data!.banners[0].image);
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      emit(ShopErrorHomeState(error: error.toString()));
    });
  }
}

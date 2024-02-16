import 'package:e_commerce_app/models/categories_model.dart';
import 'package:e_commerce_app/models/favorites_model.dart';
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
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      printAll(homeModel!.data!.banners[0].image);
      print(favorites);
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      emit(ShopErrorHomeState(error: error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: getCategories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // printAll(homeModel!.data!.banners[0].image);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error: error.toString()));
    });
  }

  void changeFavorites({required int productId}) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeLiveFavoritesState());
    DioHelper.postData(
            url: favoritesEndPoint,
            data: {'product_id': productId},
            token: token)
        .then((value) {
      if (value.data['status'] == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavData();
      }
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((e) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavData() {
    emit(ShopGetFavDataLoadingState());
    DioHelper.getData(url: favoritesEndPoint, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      // printAll(value.data.toString());
      // print(favoritesModel!.message);
      // print("object");
      emit(ShopGetFavDataSuccessState());
    }).catchError((error) {
      emit(ShopGetFavDataErrorState());
    });
  }
}

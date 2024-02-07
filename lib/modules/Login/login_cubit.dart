import 'package:e_commerce_app/models/login_model.dart';
import 'package:e_commerce_app/modules/Login/login_states.dart';
import 'package:e_commerce_app/shared/network/end_points.dart';
import 'package:e_commerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  IconData suffix = Icons.visibility_outlined;
  bool ispasswordShown = true;
  void changePasswordVisability() {
    ispasswordShown = !ispasswordShown;
    suffix = ispasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }

  void UserLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await DioHelper.postData(url: login, data: {
      "email": email,
      "password": password,
    }).then((value) {
      print("dddddddd");
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.message);
      emit(LoginSuccesState(loginMode:loginModel! ));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }
}

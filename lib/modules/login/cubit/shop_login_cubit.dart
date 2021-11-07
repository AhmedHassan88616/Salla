import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:udemy_flutter/models/shop_user_model.dart';
import 'package:udemy_flutter/shared/endpoints/endpoints.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

part 'shop_login_state.dart';


class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: Endpoints.LOGIN, data: {'email': email, 'password': password})
        .then((value) =>
        emit(ShopLoginSuccessState(ShopUserModel.fromJson(value.data))))
        .catchError(
          (error) => emit(
        ShopLoginErrorState(
          error: error.toString(),
        ),
      ),
    );
  }

  bool isPassword = true;
  IconData visibleIcon = Icons.visibility_outlined;

  changePasswordVisibility() {
    isPassword = !isPassword;
    visibleIcon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibilityState());
  }
}

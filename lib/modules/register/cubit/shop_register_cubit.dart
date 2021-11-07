import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:udemy_flutter/models/shop_user_model.dart';
import 'package:udemy_flutter/shared/endpoints/endpoints.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

part 'shop_register_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitial());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: Endpoints.REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    )
        .then((value) =>
            emit(ShopRegisterSuccessState(ShopUserModel.fromJson(value.data))))
        .catchError(
          (error) => emit(
            ShopRegisterErrorState(
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
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}

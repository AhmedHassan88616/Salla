part of 'shop_login_cubit.dart';

@immutable
abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopUserModel shopLoginModel;

  ShopLoginSuccessState(this.shopLoginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState({
    @required this.error,
  });
}
class ShopLoginChangePasswordVisibilityState extends ShopLoginStates {}


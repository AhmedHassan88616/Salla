part of 'shop_register_cubit.dart';

@immutable
abstract class ShopRegisterStates {}

class ShopRegisterInitial extends ShopRegisterStates {}



class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopUserModel shopRegisterModel;

  ShopRegisterSuccessState(this.shopRegisterModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState({
    @required this.error,
  });
}
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}


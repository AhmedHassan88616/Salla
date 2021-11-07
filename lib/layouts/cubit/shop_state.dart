part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeBottomNavBar extends ShopState {}

class ShopLoadingHomeData extends ShopState {}

class ShopSuccessHomeData extends ShopState {}

class ShopFailedHomeData extends ShopState {}

class ShopSuccessCategoriesData extends ShopState {}

class ShopFailedCategoriesData extends ShopState {}

class ShopToggleFavoritesData extends ShopState {}

class ShopSuccessToggleFavoritesData extends ShopState {
  final String message;
  final bool status;

  ShopSuccessToggleFavoritesData({@required this.message,@required this.status});

}

class ShopFailedToggleFavoritesData extends ShopState {}

class ShopLoadingGetFavoritesData extends ShopState {}

class ShopSuccessGetFavoritesData extends ShopState {}

class ShopFailedGetFavoritesData extends ShopState {}

class ShopLoadingGetUserData extends ShopState {}

class ShopSuccessGetUserData extends ShopState {
  final ShopUserModel userModel;

  ShopSuccessGetUserData({@required this.userModel});
}

class ShopFailedGetUserData extends ShopState {}


class ShopLoadingUpdateUserData extends ShopState {}

class ShopSuccessUpdateUserData extends ShopState {
  final ShopUserModel userModel;

  ShopSuccessUpdateUserData({@required this.userModel});
}

class ShopFailedUpdateUserData extends ShopState {
  final error;

  ShopFailedUpdateUserData(this.error);

}




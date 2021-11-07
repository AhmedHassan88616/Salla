part of 'shop_search_cubit.dart';

@immutable
abstract class ShopSearchStates {}

class ShopSearchInitial extends ShopSearchStates {}



class ShopSearchLoadingState extends ShopSearchStates {}

class ShopSearchSuccessState extends ShopSearchStates {
  final ShopSearchModel shopSearchModel;

  ShopSearchSuccessState(this.shopSearchModel);
}

class ShopSearchErrorState extends ShopSearchStates {
  final String error;

  ShopSearchErrorState({
    @required this.error,
  });
}
class ShopSearchChangePasswordVisibilityState extends ShopSearchStates {}


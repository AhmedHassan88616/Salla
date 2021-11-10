import 'package:Salla/models/shop_categories_model.dart';
import 'package:Salla/models/shop_favorites_model.dart';
import 'package:Salla/models/shop_home_model.dart';
import 'package:Salla/models/shop_user_model.dart';
import 'package:Salla/models/toggle_favorites_model.dart';
import 'package:Salla/modules/categories_screen/categories_screen.dart';
import 'package:Salla/modules/favorites_screen/favorites_screen.dart';
import 'package:Salla/modules/products_screen/products_screen.dart';
import 'package:Salla/modules/settings_screen/settings_screen.dart';
import 'package:Salla/shared/constants/constants.dart';
import 'package:Salla/shared/endpoints/endpoints.dart';
import 'package:Salla/shared/network/local/cache_helper.dart';
import 'package:Salla/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  final token = CacheHelper.getData(key: 'token');
  ShopHomeModel shopHomeModel;
  CategoriesModel categoriesModel;
  final Map<int, bool> favorites = {};

  // final Map<int, bool> favorites = {};
  List shopBottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(value) {
    currentIndex = value;
    emit(ShopChangeBottomNavBar());
  }

  void getHomeData() {
    emit(ShopLoadingHomeData());
    DioHelper.getData(
      url: Endpoints.HOME,
      token: token,
    ).then((value) {
      print('token $token');
      emit(ShopSuccessHomeData());
      shopHomeModel = ShopHomeModel.fromJson(value.data);
      shopHomeModel.data.products.forEach((product) {
        favorites.addAll({product.id: product.inFavorites});
      });
    }).catchError((error) {
      printFullText(error);
      emit(ShopFailedHomeData());
    });
  }

  void getCategoriesData() {
    DioHelper.getData(
      url: Endpoints.GET_CATEGORIES,
    ).then((value) {
      emit(ShopSuccessCategoriesData());
      categoriesModel = CategoriesModel.fromJson(value.data);
    }).catchError((error) {
      printFullText(error);
      emit(ShopFailedCategoriesData());
    });
  }

  ToggleFavoritesModel toggleFavoritesModel;

  void toggleFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopToggleFavoritesData());
    DioHelper.postData(
      url: Endpoints.FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      toggleFavoritesModel = ToggleFavoritesModel.fromJson(value.data);
      print(toggleFavoritesModel.message);
      if (!toggleFavoritesModel.status)
        favorites[productId] = !favorites[productId];
      else
        getFavoritesData();

      emit(ShopSuccessToggleFavoritesData(
          message: toggleFavoritesModel.message,
          status: toggleFavoritesModel.status));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      print(toggleFavoritesModel.message);
      emit(ShopFailedToggleFavoritesData());
    });
  }

  ShopFavoritesModel shopFavoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesData());
    DioHelper.getData(
      url: Endpoints.FAVORITES,
      token: token,
    ).then((value) {
      emit(ShopSuccessGetFavoritesData());
      shopFavoritesModel = ShopFavoritesModel.fromJson(value.data);
      printFullText(shopFavoritesModel.toJson().toString());
    }).catchError((error) {
      printFullText(error);
      emit(ShopFailedGetFavoritesData());
    });
  }

  ShopUserModel shopUserModel;

  void getUserData() {
    emit(ShopLoadingGetUserData());
    DioHelper.getData(
      url: Endpoints.PROFILE,
      token: token,
    ).then((value) {
      shopUserModel = ShopUserModel.fromJson(value.data);
      printFullText(shopUserModel.toJson().toString());
      emit(ShopSuccessGetUserData(userModel: shopUserModel));
    }).catchError((error) {
      printFullText(error);
      emit(ShopFailedGetUserData());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateUserData());
    DioHelper.putData(
      url: Endpoints.UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      shopUserModel = ShopUserModel.fromJson(value.data);
      printFullText(shopUserModel.toJson().toString());
      emit(ShopSuccessUpdateUserData(userModel: shopUserModel));
    }).catchError((error) {
      printFullText(error);
      emit(ShopFailedUpdateUserData(error));
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:udemy_flutter/models/shop_search_model.dart';
import 'package:udemy_flutter/shared/constants/constants.dart';
import 'package:udemy_flutter/shared/endpoints/endpoints.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

part 'shop_search_state.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitial());

  static ShopSearchCubit get(context) => BlocProvider.of(context);

  final token = CacheHelper.getData(key: 'token');

  ShopSearchModel shopSearchModel;

  void getSearchData({String text}) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: Endpoints.SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      shopSearchModel = ShopSearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState(shopSearchModel));
      printFullText(shopSearchModel.toJson().toString());
    }).catchError((error) {
      printFullText(error);
      emit(ShopSearchErrorState(error: error));
    });
  }
}

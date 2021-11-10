import 'package:Salla/models/shop_search_model.dart';
import 'package:Salla/shared/constants/constants.dart';
import 'package:Salla/shared/endpoints/endpoints.dart';
import 'package:Salla/shared/network/local/cache_helper.dart';
import 'package:Salla/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
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

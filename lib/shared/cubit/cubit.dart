import 'package:Salla/shared/cubit/states.dart';
import 'package:Salla/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);




  bool isDark = true;

  void toggleThemeMode({bool fromCachedData}) {
    if (fromCachedData != null) {
      isDark = fromCachedData;
      emit(AppChangeThemModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then(
        (value) => emit(
          AppChangeThemModeState(),
        ),
      );
    }
  }
}

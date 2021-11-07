import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

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

import 'package:Salla/shared/bloc_observer/bloc_server.dart';
import 'package:Salla/shared/cubit/cubit.dart';
import 'package:Salla/shared/cubit/states.dart';
import 'package:Salla/shared/network/local/cache_helper.dart';
import 'package:Salla/shared/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'layouts/shop_layout.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding/on_boarding.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool _isDark = CacheHelper.getData(key: 'isDark');
  bool _onBoarding = CacheHelper.getData(key: 'onBoarding');
  String _token = CacheHelper.getData(key: 'token');
  runApp(MyApp(
    isDark: _isDark,
    onBoarding: _onBoarding,
    token: _token,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  final isDark;
  final onBoarding;
  final token;

  const MyApp({Key key, this.isDark, this.onBoarding, this.token})
      : super(key: key);

  // constructor

  // build

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) =>
              AppCubit()..toggleThemeMode(fromCachedData: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          bool isDark = AppCubit.get(context).isDark;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: darkTheme,
            theme: lightTheme,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: token != null
                  ? ShopLayout()
                  : onBoarding ?? false
                      ? ShopLoginScreen()
                      : OnBoardingScreen(),
            ),
          );
        },
      ),
    );
  }
}

import 'package:Salla/modules/search_screen/search_screen.dart';
import 'package:Salla/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubit/shop_cubit.dart';


class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _shopCubit = ShopCubit()
      ..getCategoriesData()
      ..getHomeData()
      ..getFavoritesData()
      ..getUserData();
    return BlocProvider(
      create: (context) => _shopCubit,
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final _cubit = ShopCubit.get(context);
          int _currentIndex = _cubit.currentIndex;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Salla',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  onPressed: () =>
                      navigateTo(context: context, screen: SearchScreen(shopCubit: _shopCubit,),),
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            body: _cubit.shopBottomScreens[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                _cubit.changeBottomNavBar(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

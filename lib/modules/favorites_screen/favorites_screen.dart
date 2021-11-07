import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layouts/cubit/shop_cubit.dart';
import 'package:udemy_flutter/models/shop_favorites_model.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var _cubit = ShopCubit.get(context);
        return _cubit.shopFavoritesModel != null &&
                _cubit.favorites.isNotEmpty &&
                state is! ShopLoadingGetFavoritesData
            ? ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (BuildContext context, int index) =>
                    buildProductItem(
                  _cubit,
                  _cubit.shopFavoritesModel.data.data[index].product,
                ),
                itemCount: _cubit.shopFavoritesModel.data.data.length,
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

}

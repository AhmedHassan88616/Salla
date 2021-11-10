import 'package:Salla/layouts/cubit/shop_cubit.dart';
import 'package:Salla/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
                context,
                _cubit.shopFavoritesModel.data.data[index].product,
              ),
          itemCount: _cubit.shopFavoritesModel.data.data.length,
        )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

}

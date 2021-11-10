import 'package:Salla/layouts/cubit/shop_cubit.dart';
import 'package:Salla/models/shop_categories_model.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final _cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: _cubit.categoriesModel != null,
          builder: (ctx) => ListView.separated(
              itemBuilder: (ctx, index) =>
                  _buildCatItem(_cubit.categoriesModel.data.data[index]),
              separatorBuilder: (ctx, index) => Divider(),
              itemCount: _cubit.categoriesModel.data.data.length),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  _buildCatItem(DataItem dataItem) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              dataItem.image,
            ),
            width: 120.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            dataItem.name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w700),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}

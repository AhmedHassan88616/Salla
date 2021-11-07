import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layouts/cubit/shop_cubit.dart';
import 'package:udemy_flutter/models/shop_categories_model.dart';
import 'package:udemy_flutter/models/shop_home_model.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ShopSuccessToggleFavoritesData) if (!state.status)
          showToast(message: state.message, state: ToastStates.FAILED);
      },
      builder: (context, state) {
        var _cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition:
              _cubit.shopHomeModel != null && _cubit.categoriesModel != null,
          builder: (context) => _productsBuilder(
              homeModel: _cubit.shopHomeModel,
              categoriesModel: _cubit.categoriesModel,
              context: context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  _productsBuilder(
      {@required ShopHomeModel homeModel,
      @required CategoriesModel categoriesModel,
      @required context}) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: homeModel.data.banners
                .map((e) => Image(image: NetworkImage(e.image)))
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 0.93,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              autoPlayAnimationDuration: Duration(seconds: 1),
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _buildCatsList(categoriesModel),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.6073,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              children: List.generate(
                homeModel.data.products.length,
                (index) => Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10.0),
                  child: _buildGridProducts(
                      homeModel.data.products[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildGridProducts(Product product, context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    product.image,
                  ),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (product.discount != 0)
                  Container(
                    color: Colors.red[400],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 3.0, vertical: 1.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: defaultColor, height: 1.1),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.round()}',
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      if (product.discount != 0)
                        Text(
                          '\$${product.oldPrice.round()}',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2.0,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).toggleFavorites(product.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorites[product.id]
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                        padding: const EdgeInsets.all(0.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildCatsList(CategoriesModel categoriesModel) {
    return Container(
      height: 110.0,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(categoriesModel.data.data[index].image),
                    width: 110.0,
                    height: 110.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.75),
                    width: 110.0,
                    child: Text(
                      categoriesModel.data.data[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
          separatorBuilder: (context, index) => SizedBox(
                width: 5.0,
              ),
          itemCount: categoriesModel.data.data.length),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layouts/cubit/shop_cubit.dart';
import 'package:udemy_flutter/shared/components/components.dart';

import 'cubit/shop_search_cubit.dart';

class SearchScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final ShopCubit shopCubit;

  SearchScreen({Key key, @required this.shopCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: shopCubit,
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ShopSearchCubit(),
            child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                final ShopSearchCubit _searchCubit =
                    ShopSearchCubit.get(context);
                return Scaffold(
                  appBar: AppBar(),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          defaultFormField(
                              controller: _controller,
                              type: TextInputType.text,
                              validate: (String value) {
                                if (value.isEmpty)
                                  return 'search text is empty!';
                              },
                              label: 'Search',
                              prefix: Icons.search,
                              onSubmit: (String value) {
                                if (!_formKey.currentState.validate()) return;
                                _searchCubit.getSearchData();
                              }),
                          if (state is ShopSearchLoadingState)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: LinearProgressIndicator(),
                            ),
                          if (state is ShopSearchSuccessState)
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) =>
                                    buildProductItem(
                                        context,
                                        _searchCubit
                                            .shopSearchModel.data.data[index]),
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: _searchCubit
                                    .shopSearchModel.data.data.length,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

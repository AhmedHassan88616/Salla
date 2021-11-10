import 'package:Salla/layouts/shop_layout.dart';
import 'package:Salla/modules/register/shop_register_screen.dart';
import 'package:Salla/shared/components/components.dart';
import 'package:Salla/shared/network/local/cache_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/shop_login_cubit.dart';

class ShopLoginScreen extends StatelessWidget {
  var _emailController = TextEditingController();

  var _passwordController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ShopLoginErrorState)
            print('error : ' + state.error.toString());
          else if (state is ShopLoginSuccessState) {
            if (state.shopLoginModel.status) {
              showToast(
                  message: state.shopLoginModel.message,
                  state: ToastStates.SUCCESS);
              print(state.shopLoginModel.message);
              print(state.shopLoginModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.shopLoginModel.data.token,
              ).then((value) => navigateAndFinishTo(
                    context: context,
                    screen: ShopLayout(),
                  ));
            } else {
              showToast(
                  message: state.shopLoginModel.message,
                  state: ToastStates.FAILED);
              print(state.shopLoginModel.message);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: _emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: _passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).visibleIcon,
                          suffixPressed: ShopLoginCubit.get(context)
                              .changePasswordVisibility,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'The password is too short';
                            }
                          },
                          onSubmit: (value) => _submit(context),
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          label: 'password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (BuildContext context) => defaultButton(
                              function: () => _submit(context), text: 'LOGIN'),
                          fallback: (_) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                    context: context,
                                    screen: ShopRegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submit(context) {
    if (!_formKey.currentState.validate()) return;
    print(_emailController.text);
    print(_passwordController.text);
    ShopLoginCubit.get(context).userLogin(
        email: _emailController.text, password: _passwordController.text);
  }
}

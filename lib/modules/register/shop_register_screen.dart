import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layouts/shop_layout.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

import 'cubit/shop_register_cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _phoneController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterErrorState)
            print('error : ' + state.error.toString());
          else if (state is ShopRegisterSuccessState) {
            if (state.shopRegisterModel.status) {
              showToast(
                  message: state.shopRegisterModel.message,
                  state: ToastStates.SUCCESS);
              print(state.shopRegisterModel.message);
              print(state.shopRegisterModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.shopRegisterModel.data.token,
              ).then((value) => Navigator.pop(context));
            } else {
              showToast(
                  message: state.shopRegisterModel.message,
                  state: ToastStates.FAILED);
              print(state.shopRegisterModel.message);
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
                            'Register',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultFormField(
                            controller: _nameController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            label: 'Name',
                            prefix: Icons.person,
                          ),
                          SizedBox(
                            height: 15.0,
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
                            suffix: ShopRegisterCubit.get(context).visibleIcon,
                            suffixPressed: ShopRegisterCubit.get(context)
                                .changePasswordVisibility,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'The password is too short';
                              }
                            },
                            onSubmit: (value) => _submit(context),
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            label: 'password',
                            prefix: Icons.lock_outline,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: _phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'The phone is empty';
                              }
                            },
                            onSubmit: (value) => _submit(context),
                            label: 'phone',
                            prefix: Icons.phone,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopRegisterLoadingState,
                            builder: (BuildContext context) => defaultButton(
                                function: () => _submit(context),
                                text: 'Register'),
                            fallback: (_) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      )),
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
    ShopRegisterCubit.get(context).userRegister(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      phone: _phoneController.text,
    );
  }
}

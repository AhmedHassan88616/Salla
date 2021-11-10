import 'package:Salla/layouts/cubit/shop_cubit.dart';
import 'package:Salla/shared/components/components.dart';
import 'package:Salla/shared/constants/constants.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SettingsScreen extends StatelessWidget {
  GlobalKey _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopFailedUpdateUserData)
          print('error : ' + state.error.toString());
        else if (state is ShopSuccessUpdateUserData) {
          if (state.userModel.status) {
            showToast(
                message: state.userModel.message, state: ToastStates.SUCCESS);
            print(state.userModel.message);
            print(state.userModel.data.token);
          } else {
            showToast(
                message: state.userModel.message, state: ToastStates.FAILED);
            print(state.userModel.message);
          }
        }
      },
      builder: (context, state) {
        var userModel = ShopCubit.get(context).shopUserModel;
        if (userModel != null) {
          _nameController.text = userModel.data.name;
          _emailController.text = userModel.data.email;
          _phoneController.text = userModel.data.phone;
        }
        return ConditionalBuilder(
          condition: userModel != null,
          builder: (ctx) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (state is ShopLoadingUpdateUserData)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: _nameController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) return 'Name is empty!';
                      },
                      label: 'name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      controller: _emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty || !value.contains('@'))
                          return 'Invalid email!';
                      },
                      label: 'name',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormField(
                      controller: _phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) return 'phone is Empty!';
                      },
                      label: 'phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ConditionalBuilder(
                      condition: state is ShopLoadingUpdateUserData,
                      fallback: (_) => defaultButton(
                        function: () {
                          ShopCubit.get(context).updateUserData(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                          );
                        },
                        text: 'Update',
                      ),
                      builder: (BuildContext context) =>
                          CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'Logout',
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (_) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

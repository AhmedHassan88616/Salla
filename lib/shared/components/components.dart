import 'package:Salla/layouts/cubit/shop_cubit.dart';
import 'package:Salla/shared/styles/colors.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );


Widget myDivider() => Container(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
        top: 10.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );


navigateTo({
  @required context,
  @required Widget screen,
}) {

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
}

navigateAndFinishTo({
  @required context,
  @required Widget screen,
}) {


    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
}

showToast({
  @required String message,
  @required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.SUCCESS:
      return Colors.green;
    case ToastStates.FAILED:
      return Colors.red;
    case ToastStates.WARNING:
      return Colors.amber;
  }
}

//  enum
enum ToastStates { SUCCESS, FAILED, WARNING }

Widget buildProductItem(
  context,
  product,
) {
  final cubit = ShopCubit.get(context);

  return Container(
    height: 120.0,
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              width: 120,
              height: 120,
              child: Image(
                image: NetworkImage(
                  product.image,
                ),
                fit: BoxFit.cover,
              ),
            ),
            if (product.discount != 0)
              Container(
                color: Colors.red[400],
                padding:
                    const EdgeInsets.symmetric(horizontal: 3.0, vertical: 1.0),
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
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: defaultColor, height: 1.1),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    '\$${product.price}',
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  if (product.discount != 0)
                    Text(
                      '\$${product.oldPrice}',
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 2.0,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      cubit.toggleFavorites(product.id);
                    },
                    icon: CircleAvatar(
                      backgroundColor: cubit.favorites[product.id]
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
  );
}

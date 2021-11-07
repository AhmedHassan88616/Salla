import 'package:udemy_flutter/modules/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value)
      navigateAndFinishTo(
        context: context,
        screen: ShopLoginScreen(),
      );
  });
}

printFullText(String text) {
  final pattern = RegExp('.{800}');
  pattern.allMatches(text).forEach(
        (match) => print(
          match.group(0),
        ),
      );
}

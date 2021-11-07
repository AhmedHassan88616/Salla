import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class BoardingModel {
  final title;
  final body;
  final image;

  BoardingModel({
    @required this.title,
    @required this.body,
    @required this.image,
  });
}

class OnBoardingScreen extends StatelessWidget {
  final PageController _boardController = PageController();

  List<BoardingModel> _boarding = [
    BoardingModel(
      title: 'Screen1 title',
      body: 'screen1 body',
      image: 'assets/images/onboard_1.jpg',
    ),
    BoardingModel(
      title: 'Screen2 title',
      body: 'screen2 body',
      image: 'assets/images/onboard_1.jpg',
    ),
    BoardingModel(
      title: 'Screen3 title',
      body: 'screen3 body',
      image: 'assets/images/onboard_1.jpg',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: () => _submit(context),
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: _boardController,
                onPageChanged: (index) {
                  if (index == _boarding.length - 1)
                    isLast = true;
                  else
                    isLast = false;
                },
                itemBuilder: (context, index) => _buildBoardingItem(index),
                itemCount: _boarding.length,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Text('indicator'),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast)
                      _submit(context);
                    else
                      _boardController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            SmoothPageIndicator(
              controller: _boardController,
              effect: ExpandingDotsEffect(
                activeDotColor: defaultColor,
                dotColor: Colors.grey,
                expansionFactor: 4.0,
                dotHeight: 10.0,
                dotWidth: 10.0,
                spacing: 5.0,
              ),
              count: _boarding.length,
            ),
          ],
        ),
      ),
    );
  }

  _buildBoardingItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(_boarding[index].image),
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Text(
          _boarding[index].title,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          _boarding[index].body,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ],
    );
  }

  _submit(context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value)
        navigateAndFinishTo(
          context: context,
          screen: ShopLoginScreen(),
        );
    });
  }
}

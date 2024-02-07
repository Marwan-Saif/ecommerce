import 'package:e_commerce_app/models/boarding_model.dart';
import 'package:e_commerce_app/modules/Login/login_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/network/local/cach_helper.dart';
import 'package:e_commerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageViewController = PageController();

  List<OnBoardingModel> onBoardingScreens = [
    OnBoardingModel(
        imgPath: "assets/images/onBoarding1.jpeg",
        title: "On Boarding Screen 1 Title",
        supTitle: "On Boarding Screen 1 supTitle"),
    OnBoardingModel(
        imgPath: "assets/images/onBoarding1.jpeg",
        title: "On Boarding Screen 2 Title",
        supTitle: "On Boarding Screen 2 supTitle"),
    OnBoardingModel(
        imgPath: "assets/images/onBoarding1.jpeg",
        title: "On Boarding Screen 3 Title",
        supTitle: "On Boarding Screen 3 supTitle"),
  ];

  bool isLast = false;
  void endOnBoarding() {
    CachHelper.saveData(key: 'onBoarding', value: true).then((value) {
      print("cachhelper");
      if (value!) navigateWithReplacment(context, LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [defaultTextButton(function: endOnBoarding, text: "Skip")],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    if (value == onBoardingScreens.length - 1) {
                      isLast = true;
                      setState(() {});
                    } else {
                      isLast = false;
                      setState(() {});
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  controller: pageViewController,
                  itemBuilder: (context, index) {
                    return onBoardingItem(onBoardingScreens[index]);
                  },
                  itemCount: onBoardingScreens.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                      controller: pageViewController,
                      effect: const ExpandingDotsEffect(
                          activeDotColor: defaultColor,
                          dotColor: Colors.grey,
                          dotWidth: 10,
                          dotHeight: 10,
                          strokeWidth: 30),
                      count: onBoardingScreens.length),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        endOnBoarding();
                      } else {
                        pageViewController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.easeInQuint);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Column onBoardingItem(OnBoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(model.imgPath))),
        const SizedBox(
          height: 14,
        ),
        Text(
          model.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          model.supTitle,
          style: const TextStyle(fontSize: 14),
        )
      ],
    );
  }
}

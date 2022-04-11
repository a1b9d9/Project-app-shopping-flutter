import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/network/local/shared_preferences.dart';
import '../../shared/components/reuseble_components.dart';
import '../../shared/style/colors.dart';
import '../log_in/log_in_screen.dart';

class Info {
  final String image;
  final String tittle;
  final String details;

  Info({required this.image, required this.tittle, required this.details});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controlboard = PageController();

  var indexPo;

  List<Info> info = [
    Info(
        image: "assets/images/im1.jpg",
        tittle: "Tittle1",
        details: "asfdasdfalsdjfla;sj"),
    Info(
        image: "assets/images/im2.png",
        tittle: "Tittle2",
        details: "asfdasdfalsdjfla;sj"),
    Info(
        image: "assets/images/im3.png",
        tittle: "Tittle3",
        details: "asfdasdfalsdjfla;sj"),
    Info(
        image: "assets/images/im4.png",
        tittle: "Tittle4",
        details: "asfdasdfalsdjfla;sj"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultColorBackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: defaultColorBackGround,
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text("SKIP", style: TextStyle(color: defaultColor)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: PageView.builder(
                    controller: controlboard,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      indexPo = index;
                      return boarding(info[index], index);
                    },
                    itemCount: info.length)),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controlboard,
                  count: info.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: defaultColor,
                      spacing: 4),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  onPressed: () {
                    if (indexPo + 1 < info.length) {
                      controlboard.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastLinearToSlowEaseIn);
                    } else {
                      submit();
                    }
                  },
                  child: const Icon(
                    Icons.arrow_right,
                    size: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget boarding(Info i, index) => Column(
        children: [
          Expanded(
            child: Image.asset(
              i.image,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(i.tittle,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: defaultColor)),
          const SizedBox(
            height: 10,
          ),
          Text(
            i.details,
          ),
        ],
      );
  void submit(){
    CacheHelper.putData(key: "OnBoarding", value: true).then((value) {
      if (value) {
        naviAndExit(context, const LogIn());
      }
    });
  }
}

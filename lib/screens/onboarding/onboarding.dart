import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/buttons/buttons.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/hooks/text/text.dart';
import 'package:guomobile/models/onboarding.dart';
import 'package:guomobile/navigators/navigation.dart';
import 'package:guomobile/screens/auth/signup/signup.dart';
import '../../hooks/servicehooks/hookservice.dart';
import '../auth/login/login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final myController = CarouselController();
  nextSlide() {
    myController.nextPage();
  }

  int imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider.builder(
            carouselController: myController,
            itemCount: slider.length,
            itemBuilder: (context, index, realIndex) =>
                sliderCustom(context, slider[index]),
            options: CarouselOptions(
              viewportFraction: 1,
              height: mqHeight(context, .5),
              onPageChanged: (index, reason) {
                setState(() {
                  imageIndex = index;
                });
              },
            ),
          ),
          sbHeight(mqHeight(context, .03)),
          pageIndicator(context, imageIndex,
              color: imageIndex == 0
                  ? guocolor.primaryColor
                  : imageIndex == 1
                      ? guocolor.secondBlue
                      : guocolor.accent,
              color2: imageIndex == 0
                  ? guocolor.primaryColor.withOpacity(.3)
                  : imageIndex == 1
                      ? guocolor.secondBlue.withOpacity(.4)
                      : guocolor.accent.withOpacity(.4)),
          sbHeight(mqHeight(context, .05)),
          sampleText(context, myText[imageIndex]),
          sbHeight(mqHeight(context, .03)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .028)),
            child: sampleText2(context, myText[imageIndex]),
          ),
          sbHeight(mqHeight(context, imageIndex == 2 ? .05 : .1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
            child: straightButton(
              imageIndex == 2 ? "Get Started" : "Next",
              mqHeight(context, .059),
              mqWidth(context, .915),
              imageIndex == 0
                  ? guocolor.primaryColor
                  : imageIndex == 1
                      ? guocolor.secondBlue
                      : guocolor.accent,
              8,
              fontSize: mqHeight(context, .022),
              fontColor: guocolor.white,
              onT: () {
                imageIndex == 2
                    ? mynextScreenPop(context, const CreateAcc())
                    : nextSlide();
              },
            ),
          ),
          imageIndex == 2 ? sbHeight(mqHeight(context, .02)) : emptyString(),
          imageIndex == 2
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
                  child: straightButton(
                    "Login",
                    mqHeight(context, .059),
                    mqWidth(context, .915),
                    guocolor.white,
                    8,
                    fontSize: mqHeight(context, .022),
                    fontColor: guocolor.accent,
                    onT: () {
                      mynextScreenPop(context, Login());
                    },
                  ),
                )
              : emptyString()
        ],
      ),
    );
  }
}

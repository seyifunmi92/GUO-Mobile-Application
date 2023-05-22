import 'package:flutter/material.dart';
import 'package:guomobile/constant/colors.dart';
import 'package:guomobile/hooks/layout/mediaqueries.dart';
import 'package:guomobile/main.dart';
import 'package:guomobile/providers/callfunctions/providerbloc.dart';
import 'package:provider/provider.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: mqWidth(context, .02)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: mqHeight(context, .1),
                          width: mqWidth(context, .15),
                          color: guocolor.grey,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: mqHeight(context, .1),
                          width: mqWidth(context, .15),
                          color: guocolor.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //write a function to change the color of the container when clicked from grey to black12
  //Also onClick of the function, the other Container should show a text ("Container 1 has been clicked") and the colour changes to green also
  //Also Container 1 show show a text ("Yes i have been clicked")
  //Create this instance when container 2 is clicked also

  //Color codes onclick container 1
  //container 1 = grey to black12
  //container 2 = grey = green

  //Color codes onclick container 1
  //container 2 = green to black12
  //container1  = black12 = grey
}

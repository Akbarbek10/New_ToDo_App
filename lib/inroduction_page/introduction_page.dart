import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset("assets/images/svg/ic_intro.svg"))),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Reminders made simple",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Rubik',
                    color: Color(0xFF554E8F),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 75),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/navigation_page");
                          },
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Color(0xFFFCFCFC)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF4BC60D)),
                              shadowColor:
                                  MaterialStateProperty.all(Color(0xFF4BC60D)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ))),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Rubik',
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

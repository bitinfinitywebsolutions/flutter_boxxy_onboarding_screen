import 'package:flutter/material.dart';
import 'package:flutter_boxxy_onboarding_screen/constants.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  List sliders = [
    {
      "title": "Boost your\nproductivity",
      "imgUrl": "images/box.png",
    },
    {
      "title": "Your messages,\nall in one place",
      "imgUrl": "images/mail.png",
    },
    {
      "title": "Collaborate in\nreal time",
      "imgUrl": "images/tv.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 80.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff161616),
              Color(0xff171717),
            ],
            stops: [0.25, 0.75],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: sliders
                  .map(
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 15.0),
                      width: 50.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: currentIndex == sliders.indexOf(i)
                            ? kActiveIndicatorColor
                            : kInactiveIndicatorColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemCount: sliders.length,
                      itemBuilder: (BuildContext context, i) {
                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.75,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(sliders[i]["imgUrl"]),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      sliders[currentIndex]["title"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 38.0,
                        height: 1.30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: MaterialButton(
                          elevation: 3.0,
                          highlightElevation: 0.0,
                          color: kButtonColor,
                          onPressed: currentIndex == sliders.length - 1
                              ? () => {}
                              : () {
                                  setState(() {
                                    currentIndex = currentIndex + 1;
                                  });
                                  _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear);
                                },
                          padding: const EdgeInsets.symmetric(vertical: 23.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: const Text(
                            "GET STARTED",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

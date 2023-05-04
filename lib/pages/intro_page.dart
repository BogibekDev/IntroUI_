import 'package:flutter/material.dart';
import 'package:introui_task/pages/home_page.dart';
import 'package:introui_task/pages/utils/Strings.dart';

class IntroPage extends StatefulWidget {
  static const String id = "intropage";

  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            controller: _pageController,
            children: [
              makePages(
                image: "assets/images/img.png",
                title: Strings.stepOneTitle,
                content: Strings.stepOneContent,
              ),
              makePages(
                image: "assets/images/img_1.png",
                title: Strings.stepSecondTitle,
                content: Strings.stepSecondContent,
              ),
              makePages(
                image: "assets/images/img_2.png",
                title: Strings.stepThirdTitle,
                content: Strings.stepThirdContent,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              currentPage == 2
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 40, right: 50),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, HomePage.id);
                        },
                        child: const Text(
                          "skip",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentPage == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }

  Widget makePages({image, title, content}) {
    return Container(
      padding: const EdgeInsets.only(
        left: 50,
        right: 50,
        bottom: 50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 26,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(image),
          ),
        ],
      ),
    );
  }
}

Widget _indicator(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: 6,
    width: isActive ? 30 : 6,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

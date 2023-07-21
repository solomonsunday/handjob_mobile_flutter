import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import 'onboarding_view_model.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.nonReactive(
        viewModelBuilder: () => OnboardingViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(),
              child: PageView(
                children: [
                  OnboardingViewOne(
                    onNextPressed: () {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      );
                    },
                    onSkipPressed: () {
                      print('hello skip');
                      model.navigateToAuth();
                    },
                  ),
                  OnboardingViewTwo(
                    onNextPressed: () {
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      );
                    },
                    onSkipPressed: () => model.navigateToAuth(),
                  ),
                  OnboardingViewThree(
                    onFinishPressed: () {
                      _timer?.cancel();
                      model.showDialog();
                    },
                    onSkipPressed: () => model.navigateToAuth(),
                  )
                ],
                scrollDirection: Axis.horizontal,
                controller: _pageController,
              ),
            ),
          );
        });
  }
}

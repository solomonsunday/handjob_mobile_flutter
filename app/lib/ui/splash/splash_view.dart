import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/splash/splash_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewViewModel>.reactive(
      viewModelBuilder: () => SplashViewViewModel(),
      // onModelReady: (model) => model.getCurrentUser(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: viewModel.isBusy
              ? const Center(child: CircularProgressIndicator())
              : viewModel.isLoggedIn
                  ? Container()
                  : Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/jb.png',
                            fit: BoxFit.cover,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DefaultButton(
                                    onPressed: () {},
                                    title: 'Join Now',
                                    buttonBgColor: ColorManager.kSecondaryColor,
                                  ),
                                  SizedBox(height: AppSize.s20),
                                  DefaultButton(
                                    onPressed: viewModel.navigateToLogin,
                                    title: 'Sign In',
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
        );
      },
    );
  }
}

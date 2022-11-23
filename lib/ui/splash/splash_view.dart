import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/splash/splash_view_model.dart';
import 'package:handjob_mobile/ui_package/utils/colors.dart';
import 'package:handjob_mobile/ui_package/widgets/buttons/button.dart';
import 'package:stacked/stacked.dart';

import '../../ui_package/utils/values_manager.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewViewModel>.reactive(
      viewModelBuilder: () => SplashViewViewModel(),
      onModelReady: (model) => model.getCurrentUser(),
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
                                  JBButton(
                                    onPressed: viewModel.navigateToSignup,
                                    title: 'Join Now',
                                    buttonBgColor: ColorManager.kSecondaryColor,
                                  ),
                                  SizedBox(height: AppSize.s20),
                                  JBButton(
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

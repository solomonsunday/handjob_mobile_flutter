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
      onModelReady: (model) async {
        await model.getCurrentUser();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          body: viewModel.isBusy
              ? const Center(
                  child: CircularProgressIndicator(
                  backgroundColor: ColorManager.kPrimary100Color,
                  valueColor:
                      AlwaysStoppedAnimation(ColorManager.kPrimaryColor),
                ))
              : viewModel.isLoggedIn
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}

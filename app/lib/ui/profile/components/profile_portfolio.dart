import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../profile_view_model.dart';
import 'profile_portfolio_gallery.dart';

class ProfilePortfolio extends ViewModelWidget<ProfileViewModel> {
  const ProfilePortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ProfileViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.picture_as_pdf,
                    size: AppSize.s24,
                    color: ColorManager.kDarkColor,
                  ),
                  SizedBox(width: AppSize.s4),
                  Text(
                    'Portfolio',
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.add_circle_outline,
                  size: AppSize.s24,
                  color: ColorManager.kDarkColor,
                ),
              )
            ],
          ),
          const Divider(),
          const ProfilePortfolioGallery(),
          GestureDetector(
            onTap: () {},
            child: Text(
              'View more...',
              style: getRegularStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s12,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

import '../../../../models/user.model.dart';
import 'profile_portfolio_gallery.dart';

class ProfilePortfolio extends StatelessWidget {
  const ProfilePortfolio({
    Key? key,
    this.currentUser,
    this.showPortfolioSheet,
    this.isView = false,
  }) : super(key: key);

  final VoidCallback? showPortfolioSheet;
  final bool isView;
  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.picture_as_pdf,
                    size: AppSize.s24,
                    color: ColorManager.kDarkColor,
                  ),
                  const SizedBox(width: AppSize.s4),
                  Text(
                    'Portfolio',
                    style: getBoldStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s14,
                    ),
                  )
                ],
              ),
              if (showPortfolioSheet != null)
                GestureDetector(
                  onTap: showPortfolioSheet,
                  child: const Icon(
                    Icons.add_circle_outline,
                    size: AppSize.s24,
                    color: ColorManager.kDarkColor,
                  ),
                )
            ],
          ),
          const Divider(
            thickness: 1,
            color: ColorManager.kGrey,
          ),
          ProfilePortfolioGallery(
            currentUser: currentUser,
          ),
        ],
      ),
    );
  }
}

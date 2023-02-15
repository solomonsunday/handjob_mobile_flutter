import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

import '../../../../models/user.model.dart';
import '../../../profile/profile_view_model.dart';

class ProfilePortfolioGallery extends StatelessWidget {
  const ProfilePortfolioGallery({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      padding: EdgeInsets.zero,
      children: (currentUser?.portfolios ?? [])
          .map(
            (portfolio) => ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s4),
              // child: Image.network(
              //   portfolio,
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(
                imageUrl: portfolio,
                fit: BoxFit.cover,
              ),
            ),
          )
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../ui_package.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: ColorManager.kWhiteColor,
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.s4),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/profile.jpeg',
                  ),
                ),
              ),
            ),
          ),
          Text(
            'Adekunle Ola',
            style: getRegularStyle(
              color: ColorManager.kGrey1,
              fontSize: FontSize.s14,
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: const Icon(
            Icons.cloud_download,
            color: ColorManager.kPrimaryColor,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu_sharp,
            color: ColorManager.kPrimaryColor,
          ),
        )
      ],
    );
  }
}

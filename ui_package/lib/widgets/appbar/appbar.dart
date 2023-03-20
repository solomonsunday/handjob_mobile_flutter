import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui_package.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String leadingText;
  final String bottomLeadingText;
  final double fontsize;
  final void Function()? onTap;
  final Color? color;
  final double? elevation;
  final Color? textColor;
  final Color? bottomTextColor;
  final Color? iconThemeColor;
  final Color? iconColor;
  final Widget? trailing;
  final bool automaticallyImplyLeading;
  final double? leadingWidth;
  final Color? statusBarColor;
  final Brightness? statusBarBrightness;
  final Brightness? statusBarIconBrightness;
  final TextStyle? leadingStyle;
  final TextStyle? leadingBottomStyle;
  final TextStyle? titleStyle;
  final Widget? leadingIcon;
  final String? profileImage;

  const Navbar({
    Key? key,
    this.title = '',
    this.titleStyle,
    this.onTap,
    this.color = Colors.white,
    this.fontsize = FontSize.s20,
    this.textColor,
    this.bottomTextColor,
    this.iconThemeColor,
    this.leadingText = '',
    this.bottomLeadingText = '',
    this.trailing,
    this.automaticallyImplyLeading = true,
    this.leadingWidth,
    this.statusBarColor,
    this.statusBarBrightness,
    this.elevation = 4,
    this.iconColor,
    this.leadingBottomStyle,
    this.leadingStyle,
    this.statusBarIconBrightness,
    this.leadingIcon,
    this.profileImage,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(onTap: onTap, child: leadingIcon),
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (profileImage != null)
            Padding(
              padding: const EdgeInsets.all(AppSize.s4),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      profileImage ?? 'assets/images/profile.jpeg',
                    ),
                  ),
                ),
              ),
            ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (leadingText.isNotEmpty)
                Text(
                  leadingText,
                  style: leadingStyle ??
                      getMediumStyle(
                        color: textColor ?? ColorManager.kDarkCharcoal,
                        fontSize: fontsize,
                      ),
                ),
                if (bottomLeadingText.isNotEmpty)
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.9,
                    child: Text(
                      bottomLeadingText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: leadingBottomStyle ??
                          getMediumStyle(
                            color:
                                bottomTextColor ?? ColorManager.kDarkCharcoal,
                            fontSize: fontsize,
                          ),
                    ),
                  ),
              ]),
          if (title != '')
            Expanded(
              child: Text(
                title!,
                style: titleStyle ??
                    getMediumStyle(
                      color: textColor ?? ColorManager.kDarkCharcoal,
                      fontSize: fontsize,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
          // if (trailing != null)
          Container(
            child: trailing,
          ),
          // if (title != '') Container()
        ],
      ),
      // elevation: elevation,
      shadowColor: ColorManager.kAppbarShadowColor.withOpacity(0.5),
      backgroundColor: color,
      iconTheme: IconThemeData(
        color: iconColor ?? ColorManager.kWhiteColor,
      ),
      automaticallyImplyLeading: automaticallyImplyLeading,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? ColorManager.kDarkCharcoal,
        statusBarBrightness: statusBarBrightness ?? Brightness.light,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light,
      ),
    );
  }
}

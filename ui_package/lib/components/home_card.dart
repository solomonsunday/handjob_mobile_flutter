import 'package:flutter/material.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    this.onImageClick,
  }) : super(key: key);

  final Function()? onImageClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.s12,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p24,
                ),
                height: 54,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Color(0xffd9d9d9),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://xsgames.co/randomusers/avatar.php?g=male'),
                        ),
                      ),
                    ),
                    Container(
                      // autogroup9dsterA (CfxH8jDMxCmABqW5Wu9Dst)
                      padding: EdgeInsets.fromLTRB(10, 1, 0, 1),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // autogroupd6pxmvn (CfxGhEwq7nWGdWFF2QD6Px)
                            margin: EdgeInsets.fromLTRB(0, 0, 120, 0),
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // ayojohnsonToc (2052:4272)
                                  'Ayo Johnson',
                                  style: getMediumStyle(
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  // hairstylistLsQ (2052:4273)
                                  'Hair stylist',
                                  style: getMediumStyle(
                                    fontSize: 11,
                                    color: Color(0xff555555),
                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  // autogroups118FzN (CfxGqzCFuy6wvrVzxXs118)
                                  width: 50,
                                  height: 10,
                                  child: Image.network(
                                    'https://t3.ftcdn.net/jpg/03/35/91/90/360_F_335919003_TH0ZtHZZ5QGT34n1NcQXzRGvz4Pthg11.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // group338ZEN (2439:4361)
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 26),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Color(0xffaaaaaa),
                                  ),
                                ),
                                Text(
                                  // hoursago1MG (2439:4362)
                                  '11 hours ago',
                                  style: getMediumStyle(
                                    fontSize: 10,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p24,
                ),
                child: Text(
                  'Checkout the latest brand of  hair we have in stock and see how it looks on our customers. Limited stock available. Send a dm to  place your order.',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s8,
              ),
              GestureDetector(
                onTap: onImageClick,
                child: Container(
                  height: 320,
                  width: double.infinity,
                  child: Image.network(
                    'https://picsum.photos/660/200',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p24,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: ColorManager.kDarkColor,
                          ),
                          Text(
                            '107 likes',
                            style: getRegularStyle(
                              color: ColorManager.kPrimary400Color,
                              fontSize: FontSize.s11,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: AppSize.s12,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.chat_bubble,
                            color: ColorManager.kDarkColor,
                          ),
                          Text(
                            '27 messages',
                            style: getRegularStyle(
                              color: ColorManager.kPrimary400Color,
                              fontSize: FontSize.s11,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.share,
                        color: ColorManager.kDarkColor,
                      ),
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          ),
        ],
      ),
    );
  }
}

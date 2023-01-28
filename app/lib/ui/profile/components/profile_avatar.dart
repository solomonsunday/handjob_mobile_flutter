import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_package/ui_package.dart';

import '../profile_view.dart';
import 'profile_edit_icon.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    this.imgUrl,
    required this.onSelectFile,
  }) : super(key: key);
  final String? imgUrl;
  final VoidCallback onSelectFile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: ColorManager.kBackgroundolor,
            ),
          ),
          width: AppSize.s100,
          height: AppSize.s100,
          child: imgUrl == null
              ? const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/logo.jpeg',
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: imgUrl ??
                      "https://i.picsum.photos/id/866/200/200.jpg?hmac=i0ngmQOk9dRZEzhEosP31m_vQnKBQ9C19TBP1CGoIUA",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                          Colors.red,
                          BlendMode.colorBurn,
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        Positioned(
          child: GestureDetector(
            onTap: () => onSelectFile(),
            child: const ProfileEditIcon(),
          ),
          right: -4,
          bottom: 8,
        )
      ],
    );
  }
}

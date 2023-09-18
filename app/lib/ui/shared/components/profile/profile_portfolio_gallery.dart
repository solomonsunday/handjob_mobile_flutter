import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_package/utils/values_manager.dart';

import '../../../../models/user.model.dart';

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
            (portfolio) => GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (_) =>
                      _showImageDialog('Portfolio', portfolio, context),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s4),
                child: CachedNetworkImage(
                  imageUrl: portfolio,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _showImageDialog(text, path, context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         '$text',
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //       IconButton(
            //         onPressed: () {
            //           Navigator.of(context).pop();
            //         },
            //         icon: Icon(Icons.close_rounded),
            //         color: Colors.redAccent,
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              width: 400,
              height: 600,
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                imageUrl: path,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

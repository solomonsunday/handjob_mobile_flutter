import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../ui/profile/components/profile_portfolio_gallery.dart';

class ProfilePortfolioSheet extends StatelessWidget {
  const ProfilePortfolioSheet({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      onClose: () => completer!(SheetResponse(confirmed: false)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.photo_library_outlined,
                color: ColorManager.kSecondaryColor,
              ),
              SizedBox(width: AppSize.s12),
              Text('Portfolio'),
            ],
          ),
          SizedBox(height: AppSize.s24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selected files'),
              SizedBox(height: AppSize.s12),
              SelectedFileWidget(),
              SelectedFileWidget(),
              SelectedFileWidget(),
            ],
          ),
          SizedBox(height: AppSize.s20),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.add_circle_outline,
              color: ColorManager.kGrey,
              size: AppSize.s32,
            ),
          ),
          SizedBox(height: AppSize.s20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const ProfilePortfolioGallery(),
              const SizedBox(height: AppSize.s8),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View more...',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s24),
          DefaultButton(onPressed: () {}, title: 'Save changes')
        ],
      ),
    );
  }
}

class SelectedFileWidget extends StatelessWidget {
  const SelectedFileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: DottedBorder(
        color: ColorManager.kGrey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: AppSize.s24,
                height: AppSize.s24,
                padding: const EdgeInsets.all(AppSize.s8),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/gallery/1.png',
                    ),
                  ),
                ),
              ),
              SizedBox(width: AppSize.s24),
              Expanded(child: Text('portfolio-o.4419491861470375')),
              Icon(Icons.close, size: AppSize.s24),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/contact/contact_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../../models/experience.model.dart';
import '../../rating/rating.dart';
import '../contact_view.dart';

class ConnnectionRequestView extends StatelessWidget {
  const ConnnectionRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactViewModel>.reactive(
      viewModelBuilder: () => ContactViewModel(),
      builder: (context, model, child) {
        print(
            'data connection req: ${model.connectionRequestList?.map((e) => e.toJson())} loading ${model.busy(CONNECTION_REQUEST)}');
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: AppSize.s24),
                  if ((model.connectionRequestList ?? []).isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'No connection requests available yet!',
                        style: getMediumStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 8,
              ),
              delegate: SliverChildListDelegate(
                List.generate(
                  (model.connectionRequestList ?? []).length,
                  (index) {
                    List<Experience>? experiences =
                        (model.connectionRequestList?[index].experiences ?? [])
                            .where((element) => element.current!)
                            .toList();
                    return ConnectionRequestItem(
                      name:
                          "${model.topSuggestionContactList?[index].firstName} ${model.topSuggestionContactList?[index].lastName}",
                      profession: experiences.isNotEmpty
                          ? "${experiences[0].jobTitle} at ${experiences[0].company}"
                          : "",
                      rating:
                          '${model.topSuggestionContactList?[index].rating}',
                      buttonTitle: 'Accept',
                      onClick: () => model.acceptContact(
                          model.topSuggestionContactList![index].id!),
                      onCancelClick: () => model.rejectContact(
                          model.topSuggestionContactList![index].id!),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: AppSize.s40),
            ),
            // SliverToBoxAdapter(
            //     child: Text(
            //   'Top suggestions',
            //   style: getBoldStyle(
            //     color: ColorManager.kDarkColor,
            //     fontSize: FontSize.s12,
            //   ),
            // )),
            // SliverToBoxAdapter(
            //   child: SizedBox(height: AppSize.s24),
            // ),
            // SliverGrid(
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 14,
            //     crossAxisSpacing: 8,
            //   ),
            //   delegate: SliverChildListDelegate(
            //     List.generate(
            //       (model.topSuggestionContactList ?? []).length,
            //       (index) {
            //         List<Experience>? experiences =
            //             (model.topSuggestionContactList?[index].experiences ??
            //                     [])
            //                 .where((element) => element.current!)
            //                 .toList();
            //         return ConnectionRequestItem(
            //           name:
            //               "${model.topSuggestionContactList?[index].firstName} ${model.topSuggestionContactList?[index].lastName}",
            //           profession: experiences.isNotEmpty
            //               ? "${experiences[0].jobTitle} at ${experiences[0].company}"
            //               : "",
            //           rating:
            //               '${model.topSuggestionContactList?[index].rating}',
            //           buttonTitle: 'Connect',
            //           onClick: (){},
            //           onCancelClick: (){},
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}

class ConnectionRequestItem extends StatelessWidget {
  const ConnectionRequestItem({
    Key? key,
    required this.name,
    required this.profession,
    required this.rating,
    required this.buttonTitle,
    required this.onClick,
    required this.onCancelClick,
  }) : super(key: key);

  final String buttonTitle;
  final Function() onClick;
  final String name;
  final String profession;
  final String rating;
  final Function() onCancelClick;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: ColorManager.kDarkColor,
            ),
            borderRadius: BorderRadius.circular(AppSize.s12)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xffd9d9d9),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/default-avatar.jpeg"),
                    ),
                  ),
                ),
                Text(
                  name,
                  style: getBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
                Text(
                  profession,
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s11,
                  ),
                ),
                Center(
                  child: Rating(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    value: double.parse(rating),
                  ),
                ),
                SizedBox(height: AppSize.s12),
                ContactButton(onPressed: onClick, title: buttonTitle)
              ],
            ),
            Positioned(
              top: AppSize.s4,
              right: AppSize.s8,
              child: GestureDetector(
                onTap: onCancelClick,
                child: const Icon(Icons.close, size: AppSize.s24),
              ),
            ),
          ],
        ));
  }
}

class ContactButton extends StatelessWidget {
  const ContactButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.s12,
          horizontal: AppSize.s28,
        ),
        decoration: BoxDecoration(
          color: ColorManager.kDarkColor,
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Text(
          title,
          style: getRegularStyle(
            color: ColorManager.kWhiteColor,
            fontSize: FontSize.s10,
          ),
        ),
      ),
    );
  }
}

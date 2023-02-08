import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/contact/contact_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../../app/app.locator.dart';
import '../../../models/experience.model.dart';
import '../../../services/contact.service.dart';
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
        if ((model.connectionRequestList ?? []).isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'No connection requests available yet!',
              style: getMediumStyle(
                color: ColorManager.kDarkColor,
                fontSize: FontSize.s14,
              ),
            ),
          );
        }
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSize.s20),
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
                      id: model.connectionRequestList?[index].id ?? "",
                      name:
                          "${model.connectionRequestList?[index].firstName} ${model.connectionRequestList?[index].lastName}",
                      profession: experiences.isNotEmpty
                          ? "${experiences[0].jobTitle} at ${experiences[0].company}"
                          : "",
                      rating: '${model.connectionRequestList?[index].rating}',
                      buttonTitle: 'Accept',
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSize.s40),
            ),
          ],
        );
      },
    );
  }
}

class ConnectionRequestItem extends StatelessWidget {
  const ConnectionRequestItem({
    Key? key,
    required this.id,
    required this.name,
    required this.profession,
    required this.rating,
    required this.buttonTitle,
  }) : super(key: key);

  final String id;
  final String buttonTitle;
  final String name;
  final String profession;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConnectionRequestItemViewModel>.reactive(
        viewModelBuilder: () => ConnectionRequestItemViewModel(),
        builder: (context, model, _) {
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
                          image:
                              AssetImage("assets/images/default-avatar.jpeg"),
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
                    ContactButton(
                        onPressed: () => model.acceptContact(id),
                        title: buttonTitle)
                  ],
                ),
                Positioned(
                  top: AppSize.s4,
                  right: AppSize.s8,
                  child: GestureDetector(
                    onTap: () => model.rejectContact(id),
                    child: const Icon(Icons.close, size: AppSize.s24),
                  ),
                ),
              ],
            ),
          );
        });
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

const String ACCEPT_CONNECTION = "ACCEPT_CONNECTION";
const String REJECT_CONNECTION = "REJECT_CONNECTION";

class ConnectionRequestItemViewModel extends BaseViewModel {
  final _contactService = locator<ContactService>();
  final _dialogService = locator<DialogService>();

  Future<void> acceptContact(String contactId) async {
    var formData = {"contactId": contactId};
    setBusyForObject(ACCEPT_CONNECTION, true);
    try {
      await _contactService.acceptContact(formData);
      await _contactService.getConnectionRequests();
      await _contactService.getContacts();
      await _contactService.getContactsCount();
    } on DioError catch (e) {
    } finally {
      setBusyForObject(CONNECTION_REQUEST, false);
      setBusyForObject(ACCEPT_CONNECTION, false);
      notifyListeners();
    }
  }

  Future<void> rejectContact(String accountId) async {
    setBusyForObject(REJECT_CONNECTION, true);
    try {
      await _contactService.rejectContact(accountId);
      await _contactService.getConnectionRequests();
      await _contactService.getContacts();
      await _contactService.getContactsCount();
    } on DioError catch (e) {
    } finally {
      setBusyForObject(CONNECTION_REQUEST, false);
      setBusyForObject(REJECT_CONNECTION, false);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handjob_mobile/ui/contact/add_new_contact/add_new_contact_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ui_package/ui_package.dart';

import '../../../app/app.locator.dart';
import '../../../models/contact.model.dart';
import '../../../models/experience.model.dart';
import '../../../services/contact.service.dart';
import '../../shared/components/rating/rating.dart';
import '../contact_view_model.dart';

class AddNewContactView extends StatelessWidget {
  const AddNewContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewContactViewModel>.nonReactive(
        viewModelBuilder: () => AddNewContactViewModel(),
        onModelReady: (model) async {
          await model.fetchAllContacts();
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: model.goBack,
                child: const Icon(
                  Icons.arrow_back,
                  color: ColorManager.kDarkColor,
                ),
              ),
              title: Text(
                'Add New Contacts',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              backgroundColor: ColorManager.kWhiteColor,
              centerTitle: false,
              titleSpacing: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: AppSize.s8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      // horizontal: AppSize.s24,
                      vertical: AppSize.s8,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.kWhiteColor,
                    ),
                    child: SearchInput(
                      hintText: 'Search',
                      paddingBottom: AppPadding.p8,
                      paddingTop: AppPadding.p8,
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorManager.kGrey,
                      ),
                      onChanged: model.handleSearch,
                    ),
                  ),
                  SizedBox(height: AppSize.s8),
                  Expanded(child: AddNewContactListView()),
                ],
              ),
            ),
          );
        });
  }
}

class AddNewContactListView extends ViewModelWidget<AddNewContactViewModel> {
  const AddNewContactListView({super.key});

  @override
  Widget build(BuildContext context, AddNewContactViewModel model) {
    return ListView.builder(
      itemCount: (model.contactList ?? []).length,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = model.contactList![index];
        return AddNewContactListItem(
          contact: contact,
        );
      },
    );
  }
}

class AddNewContactListItem extends StatelessWidget {
  const AddNewContactListItem({
    super.key,
    required this.contact,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    List<Experience>? experiences = (contact.experiences ?? [])
        .where((element) => element.current!)
        .toList();

    // print('expereince : $currentExperience');
    return ViewModelBuilder<AddNewContactListItemViewModel>.reactive(
        viewModelBuilder: () => AddNewContactListItemViewModel(),
        builder: (context, model, _) {
          return ListTile(
            onTap: () {
              print('tapping');
            },
            leading: contact.imageUrl == null
                ? const CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/default-avatar.jpeg"),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(contact.imageUrl!),
                  ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${contact.firstName} ${contact.lastName}',
                  style: getBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
                if (experiences.isNotEmpty)
                  Text(
                    '${experiences[0].jobTitle} at ${experiences[0].company}',
                    style: getRegularStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s11,
                    ),
                  ),
                if (experiences.isEmpty)
                  Text(
                    'N/A',
                    style: getRegularStyle(
                      color: ColorManager.kDarkColor,
                      fontSize: FontSize.s11,
                    ),
                  ),
                Rating(
                  value: contact.rating!.toDouble(),
                ),
                Text(
                  'Email: ${contact.email}',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s10,
                  ),
                )
              ],
            ),
            minVerticalPadding: AppPadding.p20,
            trailing: model.isRequestSent
                ? null
                : SizedBox(
                    width: 164,
                    height: 40,
                    child: DefaultButton(
                      onPressed: model.busy(SEND_CONNECTION_REQUEST)
                          ? null
                          : () =>
                              model.handleSendConnectionRequest(contact.id!),
                      title: 'Send Connection Request',
                      paddingHeight: 0,
                      paddingWidth: 2,
                      busy: model.busy(SEND_CONNECTION_REQUEST),
                      disabled: model.busy(SEND_CONNECTION_REQUEST),
                      fontSize: FontSize.s10,
                    ),
                  ),
          );
        });
  }
}

class AddNewContactListItemViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _contactService = locator<ContactService>();
  bool _isRequestSent = false;
  bool get isRequestSent => _isRequestSent;

  handleSendConnectionRequest(String id) async {
    var formData = {"contactId": id};
    setBusyForObject(SEND_CONNECTION_REQUEST, true);
    try {
      await _contactService.sendConnectionRequest(formData);
      await _contactService.getConnectionRequests();
      await _contactService.getAllContacts();
      _isRequestSent = true;
      Fluttertoast.showToast(
        msg: 'Connection request sent!',
        toastLength: Toast.LENGTH_LONG,
      );
    } on DioError catch (e) {
      _isRequestSent = false;
    } finally {
      setBusyForObject(SEND_CONNECTION_REQUEST, false);
      notifyListeners();
    }
  }
}

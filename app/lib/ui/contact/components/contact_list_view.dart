import 'package:flutter/material.dart';
import 'package:handjob_mobile/models/experience.model.dart';
import 'package:handjob_mobile/ui/contact/contact_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

import '../../../models/contact.model.dart';
import '../../shared/components/rating/rating.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({Key? key, required this.contactRequestBusy})
      : super(key: key);
  final bool contactRequestBusy;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactViewModel>.reactive(
        viewModelBuilder: () => ContactViewModel(),
        builder: (context, model, _) {
          print(
              'data contacts: ${model.contactList} loading ${model.busy(CONTACT_LIST_REQUEST)}');
          return Container(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      // horizontal: AppSize.s24,
                      vertical: AppSize.s8,
                    ),
                    decoration: const BoxDecoration(
                      color: ColorManager.kWhiteColor,
                    ),
                    child: InputField(
                      hintText: 'Search',
                      paddingBottom: AppPadding.p8,
                      paddingTop: AppPadding.p8,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ColorManager.kGrey,
                      ),
                      onChanged: model.handleSearch,
                    ),
                  ),
                  // const SizedBox(height: AppSize.s16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${model.contactList?.length ?? 0} results',
                        style: getRegularStyle(
                          color: ColorManager.kGrey5,
                          fontSize: FontSize.s11,
                        ),
                      ),
                      DefaultButton(
                        onPressed: model.navigateToAddNewContact,
                        title: 'Add New Contact',
                        fontSize: FontSize.s11,
                        paddingHeight: 10,
                        buttonType: ButtonType.text,
                        buttonTextColor: ColorManager.kSecondaryColor,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                  // const SizedBox(height: AppSize.s16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (model.contactList ?? []).length,
                      itemBuilder: (BuildContext context, int index) {
                        Contact contact = model.contactList![index];
                        return ContactListItem(
                          contact: contact,
                          onAudioCall: model.handleVoiceCall,
                          onVideoCall: model.handleVideoCall,
                          onChat: model.handleChat,
                          onDeleteContact: model.handleDeleteContact,
                          onViewContactProfile: model.handleViewContactProfile,
                        );
                      },
                    ),
                  )
                ]),
          );
        });
  }
}

class ContactListItem extends StatelessWidget {
  const ContactListItem({
    super.key,
    required this.contact,
    required this.onDeleteContact,
    required this.onAudioCall,
    required this.onVideoCall,
    required this.onChat,
    required this.onViewContactProfile,
  });

  final Contact contact;
  final Function(Contact) onAudioCall;
  final Function(Contact) onVideoCall;
  final Function(Contact) onChat;
  final Function(Contact) onViewContactProfile;
  final Function(String) onDeleteContact;

  @override
  Widget build(BuildContext context) {
    List<Experience>? experiences = (contact.experiences ?? [])
        .where((element) => element.current!)
        .toList();

    // print('expereince : $currentExperience');
    return ListTile(
      onTap: () => onViewContactProfile(contact),
      leading: contact.imageUrl == null
          ? const CircleAvatar(
              backgroundImage: AssetImage("assets/images/default-avatar.jpeg"),
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
          const Rating(),
          Text(
            'Email: ${contact.email}',
            style: getRegularStyle(
              color: ColorManager.kDarkColor,
              fontSize: FontSize.s10,
            ),
          ),
        ],
      ),
      minVerticalPadding: AppPadding.p20,
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          print('value selected: $value');
          switch (value) {
            case AUDIO_CALL:
              onAudioCall(contact);
              break;
            case VIDEO_CALL:
              onVideoCall(contact);
              break;
            case CHAT:
              onChat(contact);
              break;
            case DELETE:
              onDeleteContact(contact.id!);
              break;
            default:
              break;
          }
        },
        itemBuilder: (BuildContext bc) {
          return [
            const PopupMenuItem(
              child: Row(
                children: [
                  Icon(
                    Icons.phone,
                    color: ColorManager.kDarkColor,
                  ),
                  SizedBox(
                    width: AppSize.s16,
                  ),
                  Text('Audio Call')
                ],
              ),
              value: AUDIO_CALL,
            ),
            const PopupMenuItem(
              child: Row(
                children: [
                  Icon(
                    Icons.videocam,
                    color: ColorManager.kDarkColor,
                  ),
                  SizedBox(
                    width: AppSize.s16,
                  ),
                  Text('Video Call')
                ],
              ),
              value: VIDEO_CALL,
            ),
            const PopupMenuItem(
              child: Row(
                children: [
                  Icon(
                    Icons.chat,
                    color: ColorManager.kDarkColor,
                  ),
                  SizedBox(
                    width: AppSize.s16,
                  ),
                  Text('Chat')
                ],
              ),
              value: CHAT,
            ),
            const PopupMenuItem(
              child: Row(
                children: [
                  Icon(
                    Icons.delete,
                    color: ColorManager.kDarkColor,
                  ),
                  SizedBox(
                    width: AppSize.s16,
                  ),
                  Text('Delete')
                ],
              ),
              value: DELETE,
            )
          ];
        },
        child: const Icon(
          Icons.more_vert,
          size: AppSize.s24,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:handjob_mobile/ui/contact/contact_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';
import 'package:ui_package/utils/colors.dart';
import 'package:ui_package/utils/font_styles.dart';
import 'package:ui_package/utils/text_styles.dart';
import 'package:ui_package/utils/values_manager.dart';
import 'package:ui_package/widgets/input/input.dart';

import '../shared/components/rating/rating.dart';
import 'components/connection_request_view.dart';
import 'components/contact_list_view.dart';

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactViewModel>.nonReactive(
        viewModelBuilder: () => ContactViewModel(),
        onModelReady: (model) async {
          await model.fetchContacts();
          await model.fetchTopSuggestionContacts();
          await model.fetchConnectionRequests();
          await model.fetchContactsCount();
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
                'Contacts',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              backgroundColor: ColorManager.kWhiteColor,
              centerTitle: false,
              titleSpacing: 0,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: AppSize.s8),
                SizedBox(height: AppSize.s8),
                Expanded(
                  child: TabHeader(),
                ),
              ],
            ),
          );
        });
  }
}

class TabHeader extends ViewModelWidget<ContactViewModel> {
  const TabHeader({super.key});

  @override
  Widget build(BuildContext context, ContactViewModel model) {
    return CustomTabView(
      tabs: [
        Tab(
          child: Row(
            children: [
              Text(
                'Contact',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s12,
                ),
              ),
              SizedBox(width: AppSize.s8),
              Container(
                padding: EdgeInsets.all(AppSize.s8),
                decoration: BoxDecoration(
                  color: ColorManager.kGreen,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${model.contactListCount}',
                  style: getRegularStyle(
                    color: ColorManager.kWhiteColor,
                  ),
                ),
              )
            ],
          ),
        ),
        Tab(
          child: Row(
            children: [
              Text(
                'Requests',
                style: getRegularStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s12,
                ),
              ),
              const SizedBox(width: AppSize.s8),
              Container(
                padding: EdgeInsets.all(AppSize.s8),
                decoration: const BoxDecoration(
                  color: ColorManager.kGreen,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${model.connectionRequestList?.length ?? 0}',
                  style: getRegularStyle(
                    color: ColorManager.kWhiteColor,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class CustomTabView extends StatefulWidget {
  CustomTabView({
    Key? key,
    required this.tabs,
  }) : super(key: key);
  List<Tab> tabs;

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView>
    with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.s24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TabBar(
            controller: _tabController,
            tabs: widget.tabs,
            indicatorColor: ColorManager.kGrey,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ContactListView(),
                ConnnectionRequestView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

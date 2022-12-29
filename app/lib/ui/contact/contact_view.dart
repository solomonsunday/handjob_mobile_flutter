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

import '../rating/rating.dart';

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContactViewModel>.nonReactive(
        viewModelBuilder: () => ContactViewModel(),
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.s24,
                    vertical: AppSize.s12,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.kWhiteColor,
                  ),
                  child: InputField(
                    hintText: 'Search',
                    paddingBottom: AppPadding.p8,
                    paddingTop: AppPadding.p8,
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorManager.kGrey3,
                    ),
                    onChanged: model.handleSearch,
                  ),
                ),
                SizedBox(height: AppSize.s8),
                Expanded(
                  child: CustomTabView(
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
                                '1',
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
                            SizedBox(width: AppSize.s8),
                            Container(
                              padding: EdgeInsets.all(AppSize.s8),
                              decoration: BoxDecoration(
                                color: ColorManager.kGreen,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '1',
                                style: getRegularStyle(
                                  color: ColorManager.kWhiteColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
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
            indicatorColor: ColorManager.kGreen,
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

class ContactListView extends StatelessWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.s16),
            Text(
              '27 results',
              style: getRegularStyle(
                color: ColorManager.kGrey5,
                fontSize: FontSize.s11,
              ),
            ),
            SizedBox(height: AppSize.s16),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      print('tapping');
                    },
                    leading: CircleAvatar(
                      backgroundColor: ColorManager.kPrimaryColor,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Frank Osas',
                          style: getBoldStyle(
                            color: ColorManager.kDarkColor,
                            fontSize: FontSize.s12,
                          ),
                        ),
                        Text(
                          'Mechanic at Frank Autos',
                          style: getRegularStyle(
                            color: ColorManager.kDarkColor,
                            fontSize: FontSize.s11,
                          ),
                        ),
                        Rating(),
                        Text(
                          'Email: frankosas@gmail.com',
                          style: getRegularStyle(
                            color: ColorManager.kDarkColor,
                            fontSize: FontSize.s10,
                          ),
                        )
                      ],
                    ),
                    minVerticalPadding: AppPadding.p20,
                    trailing: GestureDetector(
                      onTap: () {
                        print('more vert');
                      },
                      child: Icon(
                        Icons.more_vert,
                        size: AppSize.s24,
                      ),
                    ),
                  );
                },
              ),
            )
          ]),
    );
  }
}

class ConnnectionRequestView extends StatelessWidget {
  const ConnnectionRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: AppSize.s24),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 8,
          ),
          delegate: SliverChildListDelegate(
            List.generate(
              2,
              (index) => ConnectionRequestItem(
                name: "Friday Thankgod",
                profession: "Mechanic at Frank Autos",
                rating: '4',
                buttonTitle: 'Accept',
                onClick: () {},
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: AppSize.s40),
        ),
        SliverToBoxAdapter(
            child: Text(
          'Top suggestions',
          style: getBoldStyle(
            color: ColorManager.kDarkColor,
            fontSize: FontSize.s12,
          ),
        )),
        SliverToBoxAdapter(
          child: SizedBox(height: AppSize.s24),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 8,
          ),
          delegate: SliverChildListDelegate(
            List.generate(
              10,
              (index) => ConnectionRequestItem(
                name: "Friday Thankgod",
                profession: "Mechanic at Frank Autos",
                rating: '4',
                buttonTitle: 'Connect',
                onClick: () {},
              ),
            ),
          ),
        ),
      ],
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
  }) : super(key: key);

  final String buttonTitle;
  final Function() onClick;
  final String name;
  final String profession;
  final String rating;

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
                      image: NetworkImage(
                          'https://xsgames.co/randomusers/avatar.php?g=male'),
                    ),
                  ),
                ),
                Text(
                  'Friday Thankgod',
                  style: getBoldStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s12,
                  ),
                ),
                Text(
                  'Mechanic at Frank Autos',
                  style: getRegularStyle(
                    color: ColorManager.kDarkColor,
                    fontSize: FontSize.s11,
                  ),
                ),
                Center(
                  child: Rating(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                SizedBox(height: AppSize.s12),
                ContactButton(onPressed: () {}, title: 'Connect')
              ],
            ),
            Positioned(
              top: AppSize.s4,
              right: AppSize.s8,
              child: GestureDetector(
                onTap: () {},
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

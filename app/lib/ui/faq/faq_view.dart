import 'package:flutter/material.dart';
import 'package:handjob_mobile/ui/faq/faq_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:ui_package/ui_package.dart';

class FAQsView extends StatelessWidget {
  const FAQsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FAQsViewModel>.nonReactive(
      viewModelBuilder: () => FAQsViewModel(),
      builder: (_, model, child) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: model.goBack,
            child: const Icon(
              Icons.arrow_back,
              color: ColorManager.kDarkColor,
            ),
          ),
          title: Text(
            'FAQs',
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
          padding: const EdgeInsets.all(AppPadding.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Top questions',
                style: getBoldStyle(
                  color: ColorManager.kDarkColor,
                  fontSize: FontSize.s16,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: model.faqs.length,
                  itemBuilder: (BuildContext context, int index) {
                    FAQ faq = model.faqs[index];
                    return ExpansionTile(
                      childrenPadding: EdgeInsets.zero,
                      tilePadding: EdgeInsets.zero,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      title: Text(
                        model.faqs[index].title ?? "",
                        style: getBoldStyle(
                          color: ColorManager.kDarkColor,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      children: [
                        Text(
                          model.faqs[index].text ?? "",
                          style: getRegularStyle(
                            color: ColorManager.kDarkerCharcoal,
                            fontSize: FontSize.s11,
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

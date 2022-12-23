import 'package:handjob_mobile/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FAQ {
  String? title;
  String? text;

  FAQ(this.title, this.text);

  @override
  String toString() {
    return '{title: $title, text: $text,}';
  }
}

class FAQsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final List<FAQ> _faqs = [
    FAQ("What is Handjobs app?",
        "Handjobs is a digital platform that allows you to connect with artisans around you open to offering less corporate services."),
    FAQ("Why can’t I make a video call?",
        "Handjobs is a digital platform that allows you to connect with artisans around you open to offering less corporate services."),
    FAQ("How do I delete my account?",
        "Handjobs is a digital platform that allows you to connect with artisans around you open to offering less corporate services."),
    FAQ("How do I upgrade my account?",
        "Handjobs is a digital platform that allows you to connect with artisans around you open to offering less corporate services."),
    FAQ("Is there a refund policy?",
        "Handjobs is a digital platform that allows you to connect with artisans around you open to offering less corporate services."),
  ];
  List<FAQ> get faqs => _faqs;

  goBack() => _navigationService.back();
}

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
    FAQ(" What is the purpose of the handworker application?",
        "The purpose of the handworker application is to connect artisans with their prospective clients, creating a platform where artisans can showcase their products or services and clients can easily discover and connect with them."),
    FAQ("  How does the handworker application work?",
        "The application works by allowing artisans to create profiles and showcase their work, including images, descriptions, and pricing. Clients can search for artisans based on their location, craft, or specific requirements and browse through the available options. Clients can then contact artisans directly through the application to discuss their projects, negotiate prices, and arrange for the delivery or pickup of the products."),
    FAQ("What types of artisans can join the application?",
        " The application is open to various types of artisans across different crafts and industries. This can include artisans specializing in woodworking, pottery, jewelry making, painting, leatherwork, textiles, metalwork, and much more. Any artisan who creates unique handmade products or provides artisanal services can join the platform."),
    FAQ("How can artisans create a profile on the application?",
        " Artisans can create a profile on the application by signing up and providing their basic information such as their name, contact details, and location. They can then add images of their work, write descriptions, specify their craft or specialization, set prices for their products or services, and include any other relevant details that would help potential clients understand their offerings."),
    // FAQ("How can clients find artisans on the application?",
    //     "Clients can search for artisans on the application by using filters such as location, craft, or specific keywords related to the product or service they are looking for. The application will present a list of matching artisans based on the search criteria, and clients can then view the profiles, portfolio, and contact information of the artisans to initiate communication."),
    FAQ("Can clients directly purchase products or services through the application?",
        "The handworker application primarily serves as a platform for connecting artisans with clients. While some artisans may offer the option to purchase products directly through the application, the final transaction and payment details are typically handled between the client and the artisan outside the platform. The application facilitates communication and showcases the artisans' work, but the specific purchasing process may vary depending on the individual artisan."),
    FAQ("Is there a rating or review system for artisans on the application?",
        "Yes, the application may include a rating and review system where clients can provide feedback and rate their experience with a particular artisan. This helps build trust and allows prospective clients to make informed decisions based on the experiences of others. Artisans' profiles may display their average rating and reviews to showcase their reputation and the quality of their work."),
    FAQ("How does the application ensure the quality of artisans and their work?",
        "The application typically relies on the artisans' profiles, portfolios, and client reviews to assess the quality of their work. While the application does not directly control or monitor the artisans' craftsmanship, it encourages artisans to showcase their best work and maintain a positive reputation through excellent customer service and quality products. Clients can also make their own judgments based on the information provided and the reviews from previous clients."),
    FAQ("Is there a fee for artisans to join the application?",
        "Handworker is free but there are options to upgrade to premium."),
    FAQ("How can artisans promote their products or services through the application?",
        "Artisans can promote their products or services on the application by ensuring their profiles are complete and visually appealing"),
  ];
  List<FAQ> get faqs => _faqs;

  goBack() => _navigationService.back();
}

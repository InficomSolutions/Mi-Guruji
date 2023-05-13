import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class Dynamiclinkprovider {
  Future<String> shareReferralLink(String refcode) async {
    // generate the referral link using Firebase Dynamic Links API
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://com.inficom.techno_teacher?ref=$refcode"),
      uriPrefix: "https://inficom.page.link",
      androidParameters:
          const AndroidParameters(packageName: "com.inficom.techno_teacher"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    // create the WhatsApp message with the referral link
    final referralLink = dynamicLink.toString();
    print(referralLink);
    return dynamicLink.shortUrl.toString();
  }

  initdynamiclink() async {
    final instancelink =
        await FirebaseDynamicLinksPlatform.instance.getInitialLink();
    if (instancelink != null) {
      final Uri reflink = instancelink.link;
      // final message = 'Hey, check out this app! ${reflink.data}';
      // Share.share(message);
      // print(message);
      // final whatsappUrl =
      //     Uri.parse('https://wa.me/?text=${Uri.encodeFull(message)}');

      // // open the WhatsApp app with the referral link
      // if (await canLaunchUrl(whatsappUrl)) {
      //   await launchUrl(whatsappUrl);
      // } else {
      //   throw 'Could not launch WhatsApp.';
      // }
      return reflink.queryParameters['ref'];
    }
  }
}

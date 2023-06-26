import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guomobile/constant/colors.dart';

import '../layout/mediaqueries.dart';

Widget listState(BuildContext context, String title) {
  return dText(title, mqHeight(context, .017),
      color: const Color(0xff525F66).withOpacity(.8),
      fontweight: FontWeight.w400);
}

Widget listQ(BuildContext context, String title) {
  return dText(title, mqHeight(context, .017),
      color: const Color(0xff525F66).withOpacity(.8),
      fontweight: FontWeight.w400);
}

Text dText(String text, double fontSize,
    {Color? color, FontWeight? fontweight, double? letterSpacing}) {
  return Text(text,
      style: TextStyle(
        fontFamily: "Futura",
        fontSize: fontSize,
        color: color,
        fontWeight: fontweight,
        letterSpacing: letterSpacing,
      ));
}

Text dTex2t(String text, double fontSize,
    {Color? color, FontWeight? fontweight, double? letterSpacing}) {
  return Text(text,
      style: TextStyle(
        fontFamily: "OpenSans",
        fontSize: fontSize,
        color: color,
        fontWeight: fontweight,
        letterSpacing: letterSpacing,
      ));
}

Text dText4(String text, double fontSize,
    {Color? color, FontWeight? fontweight}) {
  return Text(text,
      style: GoogleFonts.openSans(
          fontSize: fontSize, color: color, fontWeight: fontweight));
}

pageTitle(BuildContext context, String title) {
  return dText(title, mqHeight(context, .02),
      color: guocolor.black, fontweight: FontWeight.w700);
}

termsText(BuildContext context, String title, String body) {
  return Column(
    children: [
      Row(
        children: [
          dText(title, mqHeight(context, .012), color: guocolor.red),
        ],
      ),
      sbHeight(mqHeight(context, .02)),
      dText(body, mqHeight(context, .0129), color: const Color(0xff65727B))
    ],
  );
}

emptyString() {
  return Text("");
}

class GuoText {
  static const ob1 = "Your safety and comfort\n        is our priority";
  static const ob2 = "Enjoy the best travel\n       experience";
  static const ob3 = "Seamless logistics\n   without stress";
  static const fP2 = "We’ve sent you a reset password link to your email.";
  static const tc = "Agree to terms and conditions.";
  static const logisticnotice =
      "You are only entitled to carry a luggage weight of 10kg, any additional kg will attract a charge of 100 naira per kg at our terminal";
  static const fP =
      "Enter the email associated with your account, So we can send you a reset password link";
  static const welcome =
      "Welcome to GUO. Enjoy seamless\n            experiences with us";
  static const verify = "A verification link has been sent to your email";
  static const ob4 =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eros integer non justo euismod pretium pharetra\n                      tempor etiam augue. ";
  static const ob5 =
      "Lorems ipsum dolor sit amet, consectetur adipiscing elit. Eros integer non justo euismod pretium pharetra\n                      tempor etiam augue. ";
  static const ob6 =
      "Loremz ipsum dolor sit amet, consectetur adipiscing elit. Eros integer non justo euismod pretium pharetra\n                      tempor etiam augue. ";

  static const privacyLogistics =
      "1. DEFINITION OF TERMS\n\nGUO Logistics Limited is the carriage company and shall hereinafter be referred to as “GUO Logistics” or “The Company”\n • All customers shall hereinafter be referred to as either “Sender/Consignor” or “Receiver/Consignee”.\n • When requesting GUO Logistics services, the “Sender/Consignor”, represents that he/she acts as the duly appointed agent of the Receiver/Consignee or anyone else with interest in the shipment and hereby agrees on his/her behalf and on behalf of the receiver of the Shipment/Consignment (“Receiver/Consignee”) and anyone else with an interest in the shipment that these Terms and Conditions shall apply\n• “Shipment/Consignment” means all documents or parcels that travel as a waybill and which may be carried by GUO Logistics Ltd through any means it chooses, including road, air, or any other means. A “Parcel Receipt” shall include any Shipment identifier or document produced by GUO Logistics Ltd automated systems such as a label, bar code, waybill or Consignment note as well as any electronic version thereof. Every Shipment is transported on a limited liability basis as provided herein. If Sender requires greater protection, then specific insurance may be arranged at an additional cost. (Please see below for further information). “Owner’s Risk” means that the goods are held upon terms that GUO Logistics Ltd shall not be liable for any loss of whatsoever nature and howsoever caused including negligence in relation to the goods or as a consequence of the goods being in your possession. You will indemnify us against all claims that may be made against us arising from the carriage, retention or storage of such goods.\n\n2. SCOPE OF CONTRACT\n\n By consummating this relationship with the Company, you acknowledge that you have read and accepted our terms and conditions set out in this Agreement and on our website www.guologistics.com on behalf of yourself and/or anyone else who has an interest in the shipment irrespective of whether you have signed the front of our parcel receipt or not. No agent, servant or representative of GUO Logistics has the authority to modify, alter or waive any provision of this contract. When you give us the consignment with oral or written instructions which conflict with our terms and conditions, we shall not be bound by such instructions. You acknowledge and accept that shipments will be consolidated with those of other shippers for transport. When carrying goods, GUO Logistics shall in its sole discretion decide what route to follow. GUO Logistics is not a common carrier and reserves the right in its absolute discretion to refuse carriage to any package/cargo tendered to it for transportation.\n\n3. DOCUMENTATION OF CONSIGNMENT\n\nInspection: It is agreed that you shall declare the actual contents of your consignment and be bound by the description as written on our parcel receipts. GUO Logistics reserves the right to open and inspect a shipment without prior notice to the Sender, Receiver or any other person with interest in the shipment, for safety, security, customs or other regulatory reasons.The names, addresses and telephone numbers of the consignor and consignee shall be provided by you and you agree that we shall not be liable for any loss or delay in delivery occasioned by your failure to provide these details accurately or any change in the details provided. You undertake that it is your responsibility to declare the value of your shipment at all times, and agree that we are not bound to request such information from you. Provided that where you fail to make such a declaration to us, you shall hold us harmless and free from any liability arising from any loss or damage to your shipment. GUO Logistics does not carry illegal or prohibited goods, which are goods prohibited by law, rule or regulation of any country in which the shipment travels. We do not carry animals, currency, precious metals and stones, firearms/parts thereof and ammunition, human remains, pornography and illegal narcotics and drugs,dangerous,noxious,hazardous,corrosive, inflammable or explosive goods other prohibited items, click here. You agree that your consignment is acceptable for carriage and undertake to indemnify GUO Logistics for any customs duties, taxes, sanctions,penalties and other expenses or charges which we incur as a result of the actions of customs or other governmental authorities for your failure to provide proper documentations and/or obtain the required license or permit. You acknowledge that in the event that you make a fraudulent or untrue statement about the shipment or any of its contents you risk a civil claim and/or criminal prosecution the penalties for which include forfeiture and sale of your shipment. You agree to indemnify us and hold us harmless from any claims that may be brought against us arising from the carriage of your consignment and any costs that we may incur regarding this. Perishable and temperature sensitive goods, which include but not limited to fruits, vegetables, other related goods may be accepted for shipment, provided it is entirely at owner's risk.\nDeliveries and Under Deliverables (a) Shipments cannot be delivered to PO boxes or postal codes. Shipments are delivered to the Receiver’s address given by Sender to the named Receiver personally, except with a signed authorization from the Receiver to hand over such shipment to another person. Shipments to addresses with a central receiving area will be delivered to that area. (b) GUO Logistics may notify the Receiver of an upcoming delivery electronically, including but not limited to, via Phone Call or SMS. Receiver may be offered alternative delivery options such as delivery on another day, redirection or collection at a GUO Logistics station. Sender mayexclude some delivery options on request.";
}

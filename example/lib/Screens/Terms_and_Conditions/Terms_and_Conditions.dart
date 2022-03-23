import 'package:CaterMe/model/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';

class TermsAndConditions extends StatefulWidget {
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  List<Terms> t=[];
@override
initState(){
  final authProvider = Provider.of<UserProvider>(context, listen: false);
  t = [

    Terms(
        '${LanguageTr.lg[authProvider.language]['Refund Policy']}',
        '${LanguageTr.lg[authProvider.language][' Cater me takes customer satisfaction very seriously.\n In the case of problems with your order, please contact Cater me through our live chat or call us on our hotline number and we will assist you.\n In appropriate cases, if you have already been billed by Cater me, we will issue full or partial refunds.\n In the following cases: if you did not receive your order or received an incorrect order, you may be issued a full refund; if part of your order is missing, we may issue a partial refund.\n In every event, we will do our best to ensure your satisfaction.']}',
        false),
    Terms(
        '${LanguageTr.lg[authProvider.language]['Price and Payment']}',
        '${LanguageTr.lg[authProvider.language]['Debit / Credit Cards: Please read the following terms of use and disclaimers carefully before using Debit / Credit Cards:The customer order cancellation is limited to a maximum time of 5 minutes from the time of placing the order.The customer refund procedure might take 2-7 working days to process on the Debit /Credit Cards bank payment gateway. The customer has to follow on with the bank in case of any delay in crediting back the customer’s account with the amount previously paid by the customer. We will send an email to the customer that contains a printout of the refund advice printed from Debit / Credit Cards bank payment gateway as reference in case the customer wants to revise the bank with.Customers using the Debit / Credit Cards facility are requested to be available on their respective contact numbers.Credit or Debit cards used in placing orders through the online payment gateway on Cater me website or applications must belong to the user. Otherwise, the user must attain the legal permission from the card owner to perform the transaction.The customer is entirely liable for placing an order using the Debit / Credit Cards facility after carefully reading all the terms & conditions.']}',
        false),
    Terms(
        '${LanguageTr.lg[authProvider.language]['Order Cancellation']}',
        '${LanguageTr.lg[authProvider.language]['You have the right to cancel an order up to 5 minutes from placing the order on our website.While every effort is made to ensure that accurate pricing and descriptions are maintained, we reserve the right to cancel any order that is based on inaccurate information.An order may be subsequently cancelled by Cater me after you have received a confirmation and Cater me reserve the right to cancel any order, before or after acceptance, and will notify you immediately of any such cancellation.']}',
        false)
  ];
}

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;



    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            '${LanguageTr.lg[authProvider.language]['Terms & Conditions']}',
        style:Theme.of(context).textTheme.headline1,
        ),),
body:WebView(
  initialUrl: "https://caterme.azurewebsites.net/caterme/termsandconditions",

  javascriptMode: JavascriptMode.unrestricted,
)
      // body: ListView.builder(
      //     itemCount: 3,
      //     itemBuilder: (context, index) => Container(
      //           width: mediaQueryWidth,
      //           child: Column(
      //             children: [
      //               GestureDetector(
      //                 onTap: () {
      //                   setState(() {
      //                     t[index].checked = !t[index].checked;
      //                   });
      //                 },
      //                 child: Container(
      //                   height: mediaQueryHeight * 0.08,
      //                   decoration: const BoxDecoration(
      //                     border: Border(
      //                       bottom: BorderSide(color: Colors.black, width: 0.2),
      //                     ),
      //                   ),
      //                   child: Container(
      //                     width: mediaQueryWidth,
      //                     child: Row(
      //                       children: [
      //                         Padding(
      //                           padding: EdgeInsets.symmetric(horizontal: 8.0),
      //                           child: Icon(t[index].checked
      //                               ? Icons.keyboard_arrow_up
      //                               : Icons.keyboard_arrow_down),
      //                         ),
      //                         Text(
      //                           t[index].title,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               t[index].checked
      //                   ? Container(
      //                       padding: EdgeInsets.all(8),
      //                       width: mediaQueryWidth,
      //                       //height: mediaQueryHeight * 0.2,
      //                       child: Text(
      //                         t[index].body,
      //                         style:
      //                             TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal, height: 2),
      //                       ))
      //                   : Container(),
      //             ],
      //           ),
      //         )),
    ));
  }
}

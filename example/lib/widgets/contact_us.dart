import 'package:CaterMe/Providers/contact_us_provider.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/contact_us_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../Providers/user.dart';
import '../language/language.dart';
import '../widgets/contact_us.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';


const _ktexts = ['Special Thank You For Using', 'CaterMe'];

class Contact_Us extends StatefulWidget {
  @override
  State<Contact_Us> createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  initState(){
    getdata();
  }
  getdata(){
    final contact = Provider.of<ContactUsProvider>(context, listen: false);


   contact.getPersonalInfo();
  }
  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // For Calling Button
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final contact = Provider.of<ContactUsProvider>(context, listen: true);


    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded),
          iconSize: 40,
          color: Colors.white,
        ),
         title: Text('${LanguageTr.lg[authProvider.language]["Contact Us"]}',


          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      //End Appbar
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Shimmer.fromColors(
                child: Image.asset(
                  'images/CaterMe.png',
                  height: mediaQuery.size.height * 0.15,
                ),
                baseColor: Colors.grey[200],
                direction: ShimmerDirection.ltr,
                highlightColor: colorCustom),

            // Animation shimer finish
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.1,
          ),
          GestureDetector(
            onTap: () async {
              launchUrl("tel://${contact.UsContact.phoneNumber}.");
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: const Color.fromARGB(206, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                    leading: Icon(
                        Icons.call,
                        color: colorCustom,
                      ),

                    title: Text(contact.UsContact.phoneNumber,
                        // contact.UsContact.phoneNumber,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing:Icon(
                        Icons.chevron_right,
                        color: Color(0xFF3F5521),
                      ),
                    )),
              ),
            ),

          SizedBox(
            height: mediaQuery.size.height * 0.01,
          ),
      GestureDetector(
    onTap: () async {
    launchUrl("mailto:${contact.UsContact.email}");},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: const Color.fromARGB(206, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: ListTile(
                  leading:Icon(
                      Icons.email,
                      color: colorCustom,
                    ),

                  title: Text(contact.UsContact.email,style: TextStyle(fontWeight: FontWeight.bold),),
                  trailing: Icon(
                      Icons.chevron_right,
                      color: Color(0xFF3F5521),
                    ),
                  ),
                ),
              ),
            ),


          SizedBox(
            width: mediaQuery.size.height * 0.15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: mediaQuery.size.height*0.1,
              child: AnimatedTextKit(
                onTap: () {},
                animatedTexts: [
                  for (final txt in ['${LanguageTr.lg[authProvider.language]["Special Thank You For Using"]}', 'CaterMe'])
                    FadeAnimatedText(txt,
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: colorCustom,
                            fontWeight: FontWeight.bold))
                ],
                repeatForever: true,
              ),
            ),
          ),

SizedBox(height: mediaQuery.size.height * 0.05,

),
          Text('${LanguageTr.lg[authProvider.language]["We/’d Love to Hear From You"]}'
            ,
            style: TextStyle(fontSize: 22),
          ),
          Text('${LanguageTr.lg[authProvider.language]["Ready to answer any and all questions"]}'
            ,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.01,),

        ],
      ),
    );
  }
}

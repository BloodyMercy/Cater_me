import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import '../widgets/contact_us.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

const _ktexts = ['Special Thank You For Using', 'CaterMe'];

class Contact_Us extends StatelessWidget {
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
    final String number = "00961 777777";
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_rounded),
          iconSize: 40,
          color: Colors.white,
        ),
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
              launchUrl("tel://$number");
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

                    title: Text(number,style: TextStyle(fontWeight: FontWeight.bold)),
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
        onTap: () {},
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

                  title: Text('CaterMe@example.com',style: TextStyle(fontWeight: FontWeight.bold),),
                  trailing: Icon(
                      Icons.chevron_right,
                      color: Color(0xFF3F5521),
                    ),
                  ),
                ),
              ),
            ),

          SizedBox(
            height: mediaQuery.size.height * 0.10,
          ),
          Container(
            color: Colors.white,
            height: mediaQuery.size.height * 0.1,
            width: mediaQuery.size.width * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: mediaQuery.size.height * 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedTextKit(
                    onTap: () {},
                    animatedTexts: [
                      for (final txt in _ktexts)
                        FadeAnimatedText(txt,
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: colorCustom,
                                fontWeight: FontWeight.bold))
                    ],
                    repeatForever: true,
                  ),
                ),
              ],
            ),
          ),

SizedBox(height: mediaQuery.size.height * 0.05,

),
          Text(
            "We'd Love to Hear From You",
            style: TextStyle(fontSize: 22),
          ),
          Text(
            "Ready to answer any and all questions",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.01,),

        ],
      ),
    );
  }
}

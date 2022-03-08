import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import '../widgets/contact_us.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';
const _ktexts = ['Thank You For Using', 'CateMe'];

class Contact_Us extends StatelessWidget {
  // Future<void> launchUrl(String url) async {
  //   if (await canLaunch(url)) {
  //      launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // For Calling Button

  @override
  Widget build(BuildContext context) {
    final String number="00961 777777";
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
          Container(
            color: Colors.white,
            height: mediaQuery.size.height * 0.2,
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
                                fontSize: 28,
                                color: colorCustom,
                                fontWeight: FontWeight.bold))
                    ],
                    repeatForever: true,

                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.04,
          ),
          GestureDetector(
            onTap: ()async {
              launch("tel: //$number");

            } ,
            child: Card(
              color: Colors.grey[100],
              child: ListTile(
                  leading: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.call,
                      color: colorCustom,
                    ),
                  ),
                  title: Text(number),
                  trailing: IconButton(
                    onPressed:(){},
                    icon: Icon(
                      Icons.chevron_right,
                      color: Color(0xFF3F5521),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: mediaQuery.size.height * 0.03,
          ),
          Card(
            color: Colors.grey[100],
            child: ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.email,
                  color: colorCustom,
                ),
              ),
              title: Text('megabee@example.com'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.chevron_right,
                  color: Color(0xFF3F5521),
                ),
              ),
            ),
          ),

      SizedBox(
        height: mediaQuery.size.height * 0.3,),

          Text("We'd Love to Hear From You",
          style: TextStyle(
              fontSize: 22
          ),),
          Text("Ready to answer any and all questions",
            style:TextStyle(color: Colors.grey,fontSize: 14

            ) ,),

        ],
      ),
    );
  }
}

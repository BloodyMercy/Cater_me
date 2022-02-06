import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/model/address.dart';
import 'package:CaterMe/widgets/Frriends/friends_textField.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addresses_screen.dart';

class CardsNewAdress extends StatefulWidget {
  CardsNewAdress({Key? key}) : super(key: key);

  @override
  State<CardsNewAdress> createState() => _CardsNewAdressState();
}

class _CardsNewAdressState extends State<CardsNewAdress> {
  final List<fakeAddress> fakeAddresses = [
    fakeAddress(
      title: 'Address title',
      subtitle: 'HOME',
      id: DateTime.now().toString(),
    ),
  ];

  final titleController = TextEditingController();

  final subTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size.height;
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    PreferredSize appBar = PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height * 0.12,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: (_mediaQuery * 0.02),
        ),
        child: AppBar(
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Adresses',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: _mediaQuery * 0.05),
              SizedBox(
                height: _mediaQuery * 0.03,
              ),
              Column(
                children: fakeAddresses.map((address) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   address.title,
                                    //   style:
                                    //       Theme.of(context).textTheme.headline4,
                                    // ),

                                    Text(
                                      address.subtitle,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: _mediaQuery * 0.5),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAddressScreen(),
            ),
          );
        },
      ),
    );
  }
}

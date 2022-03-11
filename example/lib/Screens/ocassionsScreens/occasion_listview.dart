import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../NavigationBar/navigation_bar.dart';
import '../../Providers/user.dart';
import '../../language/language.dart';
import '../add_new_occasion.dart';
import '../auth/login_screen.dart';
import '../auth/reset_password_screen.dart';
import '../auth/signup_screen.dart';
import '../edit_occasion.dart';

class OccasionListView extends StatefulWidget {
  @override
  State<OccasionListView> createState() => _OccasionListViewState();
}

class _OccasionListViewState extends State<OccasionListView> {
  bool loading = false;

  getData() async {
    // final occasion = Provider.of<PackagesProvider>(context, listen: false);
    //   await occasion.getalloccasions();

    final occa = Provider.of<OccasionProvider>(context, listen: false);
    SharedPreferences sh=await SharedPreferences.getInstance();
    await occa.getAllOccasionType(sh.getString("locale"));
    await occa.getallnewoccasion();
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  Future refreshocasionData() async {
    //   final occasion = Provider.of<PackagesProvider>(context, listen: false);
    final occa = Provider.of<OccasionProvider>(context, listen: false);

    occa.all.clear();
    occa.listoccasiontype.clear();
    SharedPreferences sh=await SharedPreferences.getInstance();
    await occa.getAllOccasionType(sh.getString("locale"));
    await occa.getallnewoccasion();

    return;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final occasion = Provider.of<PackagesProvider>(context, listen: true);
    final occa = Provider.of<OccasionProvider>(context, listen: true);
    var _mediaQuery = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);
    var screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshocasionData,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: false,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: double.maxFinite,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(occa.listoccasiontype.length,
                          (int index) {
                        return GestureDetector(
                          onTap: () {
                            if (occa.listoccasiontype[index].id == -700) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddNewOccasion(0),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddNewOccasion(index),
                                ),
                              );
                            }
                          },
                          child: Card(
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 3,
                              // width: ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      occa.listoccasiontype[index].id == -700
                                          ? Icon(
                                              Icons.add,
                                              size: 40,
                                              color: colorCustom,
                                            )
                                          : Image.network(
                                              occa.listoccasiontype[index]
                                                  .image,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                            ),
                                      Text(
                                        occa.listoccasiontype[index].name,
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
            occa.all.length == 0
                ? SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Image.asset('images/NoOccassionsYet.png'),
                       authProvider.status==Status.Unauthenticated? ElevatedButton(onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }, child: Text( '${LanguageTr.lg[authProvider.language]["Log In"]}',)):Container()
                      ],
                    ),

                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                    (context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditOccasion(occa.all[index]),
                            ),
                          );
                        },
                        child: Container(
                          child: Card(
                            elevation: 3,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromRGBO(63, 85, 33, 1),
                                  ),
                                  height: mediaQuery.size.height * 0.17,
                                  width: mediaQuery.size.width * 0.25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${DateFormat.MMM().format(DateTime.parse(occa.all[index].date))}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                          '${DateFormat.d().format(DateTime.parse(occa.all[index].date))}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   width: mediaQuery.size.width * 0.1,),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Text('${occa.all[index].name}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        // SizedBox(
                                        //   height: 65,
                                        // ),
                                        Text('${occa.all[index].type}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            '${LanguageTr.lg[authProvider.language]["edit"]}',
                                            //  locale: ,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13,
                                                decoration:
                                                    TextDecoration.underline)

                                            // Theme.of(context)
                                            //     .textTheme
                                            //     .overline,
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width:
                                //       MediaQuery.of(context).size.width / 3,
                                // ),

                                Expanded(
                                  child: Image.network(
                                    occa.all[index].image,
                                    // width:
                                    //     MediaQuery.of(context).size.width / 5.5,
                                  ),
                                ),
                                //  ],
                                //  )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: occa.all.length,
                  ))
          ],
        ),
      ),
    );
  }
}

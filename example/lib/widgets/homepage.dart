import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/CustomAlert/alert.dart';
import 'package:CaterMe/Screens/add_new_occasion.dart';
import 'package:CaterMe/Screens/my_favorites.dart';
import 'package:CaterMe/Screens/notifications.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasion_listview.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/chat/pages/chat_page.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/intro/flutter_intro.dart';
import 'package:CaterMe/model/occasions/cuisin_card.dart';
import 'package:CaterMe/model/occasions/cuisins_screen.dart';
import 'package:CaterMe/widgets/Packages/packages_card.dart';
import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:CaterMe/widgets/occasions/occasion_card.dart';
import 'package:CaterMe/widgets/occasions/occasions_list.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'Packages/test_package_add_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;

  Intro intro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getalldata();
    getData();
  }

  bool loading = false;
  List<String> listitemssearch = [];

  Future refreshdata() async {
    final package = Provider.of<PackagesProvider>(context, listen: false);
    //package.loading=false;
    // package.loading = false;
    await package.cleardata();
    await package.getallpacakges(context);

    return;
  }

  TextEditingController controllersearch = TextEditingController();

  getalldata() async {
    final package = Provider.of<PackagesProvider>(context, listen: false);
    package.loading = false;
    await package.getallpacakges(context);

    for (int i = 0; i < package.listItems.length; i++) {
      listitemssearch.add(package.listItems[i].title.toLowerCase());
    }
    package.loading = true;
  }iver

  Future getData() async {
    final occasion = Provider.of<OccasionProvider>(context, listen: false);
    await occasion.getallnewoccasion();

    setState(() {
      loading = false;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    final package = Provider.of<PackagesProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          body: !isSearch
              ? RefreshIndicator(
                  onRefresh: refreshdata,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ColoredBox(
                      color: LightColors.kLightYellow,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: mediaQuery.size.width * 0.6,
                                    height: mediaQuery.size.height / 13,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: TextField(
                                        showCursor: true,
                                        readOnly: true,
                                        autofocus: false,
                                        onTap: () {
                                          setState(() {
                                            isSearch = true;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: colorCustom,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          filled: true,
                                          fillColor: LightColors.kLightYellow2,
                                          hintText: 'Search',
                                          prefixIcon: const Icon(Icons.search),
                                          prefixIconColor:
                                              Theme.of(context).primaryColor,
                                          hintStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 13,
                                              fontFamily: 'Segoe UI'),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => ChatPage(
                                                  peerId: "admin",
                                                  peerAvatar: "",
                                                  peerNickname:
                                                      "Customer Service",
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.chat,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyFavorites(),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Notifications(),
                                            ),
                                          );
                                        },
                                        icon: Badge(
                                            badgeColor:
                                                Color.fromRGBO(253, 202, 29, 1),
                                            badgeContent:
                                                Text(package.nbnotification),
                                            child: Icon(
                                              Icons.notifications,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: (mediaQuery.size.width * 0.035),
                                  top: mediaQuery.size.height * 0.05),
                              child: Text(
                                'Packages',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            Center(child: PackagesCard()),
                            SizedBox(height: MediaQuery.of(context).size.height*0.05),
                            Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                  left: (mediaQuery.size.width * 0.04),
                                  // top: mediaQuery.size.height * 0.05
                                      ),
                                  child:
                                  Text(
                                    'Upcoming Occasions',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Navigationbar(1),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "See All",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'BerlinSansFB',
                                            fontSize: 12),
                                      ))
                                ],
                              ),
                              ((getOccasionsToday(package.occasions).length ==
                                      0))
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            mediaQuery.size.width * 0.01,
                                      ),
                                      child: Column(children: [
                                        SizedBox(
                                          width: mediaQuery.size.width * 0.97,
                                          // height: mediaQuery.size.height * 0.15,
                                          child: Card(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height:
                                                      mediaQuery.size.height *
                                                          0.15,
                                                  width: mediaQuery.size.width *
                                                      0.23,
                                                  child: Card(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            DateFormat.MMM()
                                                                .format(DateTime
                                                                    .now()),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 30,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                              DateFormat.d()
                                                                  .format(DateTime
                                                                      .now()),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 30,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                        ],
                                                      )),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: mediaQuery
                                                                  .size.width *
                                                              0.02),
                                                      child: FittedBox(
                                                        child: Text(
                                                          'You don\'t have any upcoming occasions ',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  'BerlinSansFB'),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        AddNewOccasion(
                                                                            0),
                                                              ),
                                                            );
                                                          },
                                                          icon: const Icon(Icons
                                                              .add_circle_outline_rounded),
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                        Text(
                                                          'Add an occasion ',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'BerlinSansFB'),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Center(
                                            child:
                                                OccasionCard(Axis.horizontal)),
                                      ]),
                                    )
                                  : Container(),
                              Center(child: OccasionCard(Axis.horizontal)),

                                   SizedBox(height: MediaQuery.of(context).size.height*0.1),
                              Container(
                                child: Column(
                                    children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: (mediaQuery.size.width * 0.04),
                                           ),
                                        child: Text(
                                          'Shishas',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ),
                                      // SizedBox(width: mediaQuery.size.width*0.6),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              right:
                                                  (mediaQuery.size.width * 0.04)),
                                          child: GestureDetector(
                                              child: Text("See All",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'BerlinSansFB'
                                                  )),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CuisinsScreen(
                                                            package.cuisins.id),
                                                  ),
                                                );
                                              }))
                                    ],
                                  ),
                                  SizedBox(
                                      height: mediaQuery.size.height * 0.2,
                                      //width: mediaQuery.size.width,
                                      child: CuisinCard()),
                                  // SizedBox(height:mediaQuery.size.height * 0.212,
                                  //   child:adss[0]),
                                  //  SizedBox(height:mediaQuery.size.height * 0.212,
                                  //  child:adss[1]),
                                ]),
                              ),
                              SizedBox(height: mediaQuery.size.height*0.05,)

                            ]),
                            // SizedBox(height: mediaQuery.size.height * 0.1,),

                            ...getAddOnsCard(package.addonsall),
                          ]),
                    ),
                  ),
                )
              : ListView(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isSearch = false;
                            });
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                        SizedBox(
                            width: mediaQuery.size.width * 0.8,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: TextField(
                                autofocus: false,
                                onChanged: (searchText) {
                                  searchText = searchText.toLowerCase();
                                  setState(() {
                                    isSearch = true;
                                  });
                                  if (searchText == "")
                                    setState(() {
                                      isSearch = false;
                                    });
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(232, 232, 232, 1)),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  filled: true,
                                  fillColor:
                                      const Color.fromRGBO(232, 232, 232, 1),
                                  hintText: 'Search',
                                  prefixIcon: const Icon(Icons.search),
                                  prefixIconColor: Colors.black,
                                  hintStyle: TextStyle(
                                      color: Colors.grey[850],
                                      fontSize: 16,
                                      fontFamily: 'Segoe UI'),
                                ),
                                controller: controllersearch,
                              ),
                            )),
                      ],
                    ),

                    //items
                    Container(
                      color: LightColors.kLightYellow,
                      height: mediaQuery.size.height / 1.2,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(25),
                        itemCount: package.listItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return listitemssearch[index]
                                  .contains(controllersearch.text.toLowerCase())
                              ? Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              packageAdsDetailTest(
                                                  package.listItems[index]),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: LightColors.kLightYellow2,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Container(
                                        // width: mediaQuery.size.width*0.8 ,
                                        height: mediaQuery.size.height * 0.1,
                                        child: Row(
                                          children: [
                                            Image.network(
                                              package.listItems[index].image,
                                              height: 100,
                                              width: 100,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${package.listItems[index].title}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        },
                      ),
                    ),
                  ],
                )),
    );
  }
}

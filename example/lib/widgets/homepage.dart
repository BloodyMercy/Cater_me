import 'package:CaterMe/Providers/packages.dart';

import 'package:CaterMe/Screens/add_new_occasion.dart';
import 'package:CaterMe/Screens/cuisins_screen.dart';

import 'package:CaterMe/Screens/my_favorites.dart';
import 'package:CaterMe/Screens/notifications.dart';
import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:CaterMe/widgets/Cuisins/cuisin_card.dart';
import 'package:CaterMe/widgets/items_details.dart';
import 'package:CaterMe/widgets/occasions/occasion_card.dart';
import 'package:CaterMe/widgets/occasions/occasions_list.dart';
import 'package:CaterMe/widgets/Packages/packages_card.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getalldata();
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
  }

  @override
  Widget build(BuildContext context) {
    final package = Provider.of<PackagesProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   automaticallyImplyLeading: false,
          //   elevation: 0,
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(
          //       bottom: Radius.circular(15),
          //     ),
          //   ),
          //   centerTitle: true,
          //   title: Text(
          //     'Home',
          //     style: Theme.of(context).textTheme.headline1,
          //   ),
          //   backgroundColor: Theme.of(context).primaryColor,
          // ),
          body: !isSearch
              ? RefreshIndicator(
                  onRefresh: refreshdata,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ColoredBox(
                      color: Colors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: mediaQuery.size.width * 0.6,
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
                                              borderSide: const BorderSide(
                                                  color: Color.fromRGBO(
                                                      232, 232, 232, 1)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          filled: true,
                                          fillColor: const Color.fromRGBO(
                                              232, 232, 232, 1),
                                          hintText: 'Search',
                                          prefixIcon: const Icon(Icons.search),
                                          prefixIconColor:
                                              Theme.of(context).primaryColor,
                                          hintStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16,
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
                                                builder: (context) =>
                                                    Notifications(),
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
                                            badgeContent: Text("3"),
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
                            Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: (mediaQuery.size.width * 0.04),
                                        top: mediaQuery.size.height * 0.05),
                                    child: Text(
                                      'Upcoming occasions',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  //SizedBox(width: mediaQuery.size.width*0.38),
                                  // IconButton(
                                  //     iconSize: 30,
                                  //     icon: const Icon(Icons.arrow_forward),
                                  //     onPressed: () {
                                  //       Navigator.of(context).push(
                                  //         MaterialPageRoute(
                                  //           builder: (context) => const Ocasions(),
                                  //         ),
                                  //       );
                                  //     }),
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
                                                      child: Text(
                                                        'You don\'t have any upcoming occasions ',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: 11,
                                                            fontFamily:
                                                                'BerlinSansFB'),
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
                                                                        const AddNewOccasion(),
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
                                      ]),
                                    )
                                  : Container(),
                              Center(child: OccasionCard(Axis.horizontal)),
                            ]),
                            Container(
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: (mediaQuery.size.width * 0.04),
                                          top: mediaQuery.size.height * 0.05),
                                      child: Text(
                                        'Cuisines',
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2),
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
                                    height: mediaQuery.size.height * 0.3,
                                    //width: mediaQuery.size.width,
                                    child: CuisinCard()),
                                // SizedBox(height:mediaQuery.size.height * 0.212,
                                //   child:adss[0]),
                                //  SizedBox(height:mediaQuery.size.height * 0.212,
                                //  child:adss[1]),
                              ]),
                            ),
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
                                          builder: (context) => AdsitemDetail(
                                              package.listItems[index]),
                                        ),
                                      );
                                    },
                                    child: Card(
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
                                              width: 50,
                                            ),
                                            Text(
                                              '${package.listItems[index].title}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
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
// _searchBar() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//     child: TextField(
//       autofocus: false,
//       onChanged: (searchText) {
//         searchText = searchText.toLowerCase();
//         setState(() {});
//       },
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//             borderSide:
//             const BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
//             borderRadius: BorderRadius.circular(10)),
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Theme.of(context).primaryColor)),
//         filled: true,
//         fillColor: const Color.fromRGBO(232, 232, 232, 1),
//         hintText: 'Search',
//         prefixIcon: const Icon(Icons.search),
//         prefixIconColor: Colors.black,
//         hintStyle: TextStyle(
//             color: Colors.grey[850], fontSize: 16, fontFamily: 'Segoe UI'),
//       ),
//     ),
//   );
// }
}

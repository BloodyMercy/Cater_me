// import 'package:CaterMe/NavigationBar/navigation_bar.dart';
// import 'package:CaterMe/Screens/add_friend_screen.dart';

// import 'package:CaterMe/Screens/ocassionsScreens/occasions.dart';
// import 'package:CaterMe/widgets/Frriends/friends_list.dart';

// import 'package:CaterMe/widgets/occasions/occasion_card.dart';
// import 'package:CaterMe/widgets/occasions/occasions_list.dart';

// import 'package:flutter/material.dart';

// class Dashboard extends StatelessWidget {
//   const Dashboard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     PreferredSize appBar = PreferredSize(
//       preferredSize: Size.fromHeight(
//         MediaQuery.of(context).size.height * 0.12,
//       ),
//       child: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(15),
//           ),
//         ),
//         centerTitle: true,
//         title: Padding(
//           padding: EdgeInsets.only(top: (mediaQuery.size.height * 0.03)),
//           child: Text(
//             'Dashboard',
//             style: Theme.of(context).textTheme.headline1,
//           ),
//         ),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//     );
//     return SafeArea(
//       child: Scaffold(
//         appBar: appBar,
//         body: ColoredBox(
//             color: Colors.white,
//             child: SingleChildScrollView(
//                 child: Column(children: [
//               SizedBox(
//                 height: mediaQuery.size.height * 0.07,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: (mediaQuery.size.width * 0.04)),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 35.0,
//                       child: ClipRRect(
//                         child: Image.network(
//                             'https://static.wikia.nocookie.net/youtube/images/9/9c/Hecker.jpg/revision/latest/top-crop/width/360/height/360?cb=20211024200708'),
//                         borderRadius: BorderRadius.circular(50.0),
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           EdgeInsets.only(left: (mediaQuery.size.width * 0.05)),
//                       child: Text(
//                         "Kitty the cat",
//                         style: Theme.of(context).textTheme.headline2,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: mediaQuery.size.height * 0.07,
//               ),
//               Container(
//                 child: Column(children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: (mediaQuery.size.width * 0.04)),
//                         child: Text(
//                           'Favorites',
//                           style: Theme.of(context).textTheme.headline2,
//                         ),
//                       ),
//                       SizedBox(width: mediaQuery.size.width * 0.59),
//                       IconButton(
//                           iconSize: 30,
//                           icon: Icon(
//                             Icons.arrow_forward,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                           onPressed: () {
//                             Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                 builder: (context) => Navigationbar(1),
//                               ),
//                             );
//                           }),
//                     ],
//                   ),
//                   SizedBox(
//                       height: mediaQuery.size.height * 0.212,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           ...getFavoritesImages(),
//                         ],
//                       )),
//                 ]),
//               ),
//               Container(
//                 child: Column(children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: (mediaQuery.size.width * 0.04)),
//                         child: Text(
//                           'My occasions',
//                           style: Theme.of(context).textTheme.headline2,
//                         ),
//                       ),
//                       // SizedBox(width: mediaQuery.size.width*0.5),
//                       IconButton(
//                           iconSize: 30,
//                           icon: Icon(Icons.arrow_forward,
//                               color: Theme.of(context).primaryColor),
//                           onPressed: () {
//                             Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                 builder: (context) => Ocasions(),
//                               ),
//                             );
//                           }),
//                     ],
//                   ),
//                   SizedBox(
//                       height: mediaQuery.size.height * 0.212,
//                       child: OccasionCard(Axis.horizontal)),
//                 ]),
//               ),
//               Container(
//                 child: Column(
//                   children: [
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: (mediaQuery.size.width * 0.04)),
//                             child: Text(
//                               'Saved Addresses',
//                               style: Theme.of(context).textTheme.headline2,
//                             ),
//                           ),
//                         ]),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: mediaQuery.size.width * 0.04),
//                       child: Card(
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: mediaQuery.size.width * 0.02),
//                                   child: Text(
//                                     "Home",
//                                     style:
//                                         Theme.of(context).textTheme.headline3,
//                                   ),
//                                 ),
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       IconButton(
//                                           onPressed: () {},
//                                           icon: Icon(
//                                             Icons.edit,
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                           )),
//                                       Container(
//                                         child: Row(
//                                           children: [
//                                             IconButton(
//                                                 onPressed: () {},
//                                                 icon: Icon(
//                                                   Icons.cancel_outlined,
//                                                   color: Colors.red,
//                                                 )),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ])),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: mediaQuery.size.width * 0.04),
//                       child: Card(
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: mediaQuery.size.width * 0.02),
//                                   child: Text(
//                                     "Friend's House",
//                                     style:
//                                         Theme.of(context).textTheme.headline3,
//                                   ),
//                                 ),
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       IconButton(
//                                           onPressed: () {},
//                                           icon: Icon(
//                                             Icons.edit,
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                           )),
//                                       Container(
//                                         child: Row(
//                                           children: [
//                                             IconButton(
//                                                 onPressed: () {},
//                                                 icon: Icon(
//                                                   Icons.cancel_outlined,
//                                                   color: Colors.red,
//                                                 )),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ])),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: mediaQuery.size.width * 0.04),
//                       child: Card(
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(10),
//                             ),
//                           ),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: mediaQuery.size.width * 0.02),
//                                   child: Text(
//                                     "Work",
//                                     style:
//                                         Theme.of(context).textTheme.headline3,
//                                   ),
//                                 ),
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       IconButton(
//                                           onPressed: () {},
//                                           icon: Icon(
//                                             Icons.edit,
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                           )),
//                                       Container(
//                                         child: Row(
//                                           children: [
//                                             IconButton(
//                                                 onPressed: () {},
//                                                 icon: Icon(
//                                                   Icons.cancel_outlined,
//                                                   color: Colors.red,
//                                                 )),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ])),
//                     ),
//                     SizedBox(
//                       height: mediaQuery.size.height * 0.05,
//                     ),
//                     Container(
//                       child: Column(children: [
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: (mediaQuery.size.width * 0.04)),
//                                 child: Text(
//                                   'Friends',
//                                   style: Theme.of(context).textTheme.headline2,
//                                 ),
//                               ),
//                               IconButton(
//                                   iconSize: 30,
//                                   icon: Icon(Icons.add_circle_outline_rounded,
//                                       color: Theme.of(context).primaryColor),
//                                   onPressed: () {
//                                     Navigator.of(context).pushReplacement(
//                                       MaterialPageRoute(
//                                         builder: (context) => AddFriendScreen(),
//                                       ),
//                                     );
//                                   }),
//                             ]),
//                         // AddFriendScreen(),
//                       ]),
//                     ),
//                   ],
//                 ),
//               ),
//             ]))),
//       ),
//     );
//   }
// }

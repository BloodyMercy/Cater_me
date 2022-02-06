// import 'package:CaterMe/NavigationBar/navigation_bar.dart';
// import 'package:CaterMe/Screens/add_friend_screen.dart';
// import 'package:CaterMe/Screens/contact_us_screen.dart';
// import 'package:CaterMe/Screens/auth/logout_screen.dart';
// import 'package:CaterMe/Screens/my_favorites.dart';
//
// import 'package:CaterMe/Screens/settings_screen.dart';
// import 'package:CaterMe/widgets/homepage.dart';
// import 'package:flutter/material.dart';
//
// class DrawerScreen extends StatefulWidget {
//   const DrawerScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DrawerScreen> createState() => _DrawerScreenState();
// }
//
// class _DrawerScreenState extends State<DrawerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     //!FUNCTION
//     Widget buildListTile(
//         String? title, IconData icon, final void Function() tapHandler) {
//       return ListTile(
//         leading: Icon(
//           icon,
//           color: Theme.of(context).primaryColor,
//           size: 30,
//         ),
//         title: Text(
//           title!,
//           style: Theme.of(context).textTheme.headline3,
//         ),
//         onTap: tapHandler,
//       );
//     }
//
//     PreferredSize appBar = PreferredSize(
//       preferredSize: Size.fromHeight(
//         MediaQuery.of(context).size.height * 0.15,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 13.0),
//         child: AppBar(
//           flexibleSpace: _searchBar(),
//           elevation: 0,
//           backgroundColor: Colors.white,
//           title: const Text(''),
//           iconTheme: const IconThemeData(
//             color: Colors.grey,
//             size: 30,
//           ),
//         ),
//       ),
//     );
//
//     return Scaffold(
//       drawer: SafeArea(
//         //?RUN LAL FUNCTION
//         child: Drawer(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   height: 120,
//                   // width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   alignment: Alignment.centerLeft,
//                   color: Theme.of(context).primaryColor,
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35.0,
//                         child: ClipRRect(
//                           child: Image.network(
//                               'https://static.wikia.nocookie.net/youtube/images/9/9c/Hecker.jpg/revision/latest/top-crop/width/360/height/360?cb=20211024200708'),
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 15),
//                         child: Text(
//                           'hecker',
//                           style: TextStyle(
//                             fontSize: 23,
//                             color: Colors.white,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 // const SizedBox(
//                 //   height: 20,
//                 // ),
//                 // buildListTile('Settings', Icons.settings, () {
//                 //   Navigator.of(context).push(
//                 //     MaterialPageRoute(builder: (context) => TABBar()),
//                 //   );
//                 // }),
//                 const SizedBox(height: 10),
//                 buildListTile('Active Order', Icons.shopping_cart, () {}),
//                 const SizedBox(height: 10),
//                 buildListTile('My orders', Icons.backpack, () {}),
//                 const SizedBox(height: 10),
//                 buildListTile('Contact us', Icons.email, () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => ContactUsScreen(),
//                     ),
//                   );
//                 }),
//                 const SizedBox(height: 10),
//                 buildListTile('Friends', Icons.person_add, () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => AddFriendScreen(),
//                     ),
//                   );
//                 }),
//                 const SizedBox(height: 10),
//                 buildListTile('Favorites', Icons.favorite, () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => Navigationbar(1),
//                     ),
//                   );
//                 }),
//                 const SizedBox(height: 10),
//                 buildListTile('Sign out', Icons.logout, () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => LogOutScreen(),
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//       appBar: appBar,
//       body: SafeArea(child: HomePage()),
//     );
//   }
//
//   _searchBar() {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20.0,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 40),
//           child: TextField(
//             autofocus: false,
//             onChanged: (searchText) {
//               searchText = searchText.toLowerCase();
//               setState(() {});
//             },
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                   borderSide:
//                       const BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
//                   borderRadius: BorderRadius.circular(10)),
//               focusedBorder: OutlineInputBorder(
//                   borderSide:
//                       BorderSide(color: Theme.of(context).primaryColor)),
//               filled: true,
//               fillColor: const Color.fromRGBO(232, 232, 232, 1),
//               hintText: 'Search',
//               prefixIcon: const Icon(Icons.search),
//               prefixIconColor: Colors.black,
//               hintStyle: TextStyle(
//                   color: Colors.grey[850],
//                   fontSize: 16,
//                   fontFamily: 'Segoe UI'),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:CaterMe/Drawer/drawer_screen.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              //DrawerScreen(),
            ],
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: TextField(
          autofocus: false,
          onChanged: (searchText) {
            searchText = searchText.toLowerCase();
            setState(() {});
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromRGBO(232, 232, 232, 1)),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            filled: true,
            fillColor: const Color.fromRGBO(232, 232, 232, 1),
            focusColor: Color(0xff3F5521),
            hintText: 'Search',
            prefixIcon: const Icon(
              Icons.search,
            ),
            prefixIconColor: Colors.black,
            hintStyle: TextStyle(
                color: Colors.grey[850], fontSize: 16, fontFamily: 'Segoe UI'),
          ),
        ),
      ),
    );
  }
}

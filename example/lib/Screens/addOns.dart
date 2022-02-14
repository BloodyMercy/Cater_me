import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/add_on.dart';

import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOns extends StatefulWidget {
  int addOns;
  String title;

  AddOns(this.addOns, this.title);

  @override
  State<AddOns> createState() => _AddOnsState();
}

class _AddOnsState extends State<AddOns> {
  @override
  void initState() {
    getallons();
    super.initState();
  }

  getallons() async {
    final _cuisin = Provider.of<PackagesProvider>(context, listen: false);
    _cuisin.loading = true;
    await _cuisin.getonid(widget.addOns);
    _cuisin.loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final _cuisin = Provider.of<PackagesProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    PreferredSize appBar = PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).size.height * 0.08,
      ),
      child: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
          iconSize: 30,
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        centerTitle: true,
        title: Text(
          '${widget.title}',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: ColoredBox(
        color: Colors.white,
        child: _cuisin.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView(

                padding: const EdgeInsets.all(25),
                children: getAddOns(_cuisin.allons),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2.9 / 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 5,
                ),
              ),
      ),
    );
  }
}

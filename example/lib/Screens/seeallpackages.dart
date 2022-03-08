import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class seeAllPackages extends StatefulWidget {
  int addOns;
  String title;

  seeAllPackages(this.addOns, this.title);

  @override
  State<seeAllPackages> createState() => _seeAllPackages();
}

class _seeAllPackages extends State<seeAllPackages> {
  @override
  void initState() {
    seeAllPackages();
    super.initState();
  }
  bool loading=true;
  seeAllPackages() async {
    final pack = Provider.of<PackagesProvider>(context, listen: false);
    // _cuisin.loading = true;
    // await pack.getonid(widget.addOns);
    await pack.seeAllPackages();
    // _cuisin.loading = false;
    setState(() {
      loading=false;
    });

  }


  @override
  Widget build(BuildContext context) {
    final pack = Provider.of<PackagesProvider>(context, listen: true);
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
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     bottom: Radius.circular(15),
        //   ),
        // ),
        centerTitle: true,
        title: Text(
          'Texxxxxxxxxttttttttt',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: ColoredBox(
        color: Colors.white,
        child: loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : GridView(
          padding: const EdgeInsets.all(25),
          children: [Text("hola1"),Text("hola1"),Text("hola1"),],
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

import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/widgets/addOns/add_on_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../language/language.dart';
import '../widgets/Packages/test_package_add_details.dart';

class seeAllPackages extends StatefulWidget {
  // int addOns;
  String title;

  seeAllPackages(this.title);

  @override
  State<seeAllPackages> createState() => _seeAllPackages();
}

class _seeAllPackages extends State<seeAllPackages> {
  @override
  void initState() {
    seeAllPackages();
    super.initState();
  }

  bool loading = true;

  seeAllPackages() async {
    final pack = Provider.of<PackagesProvider>(context, listen: false);
    // _cuisin.loading = true;
    // await pack.getonid(widget.addOns);
    await pack.seeAllPackages();
    // _cuisin.loading = false;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final pack = Provider.of<PackagesProvider>(context, listen: true);
    final authProvider = Provider.of<UserProvider>(context, listen: true);
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
          '${LanguageTr.lg[authProvider.language]["Packages"]}',
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
            : ListView.builder(
                itemCount: pack.seeallpackages.length,
                itemBuilder: (context, index) {
                  return FittedBox(
                      child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            packageAdsDetailTest(pack.seeallpackages[index]),
                      ));
                    },
                    child: Card(
                      // clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 12,
                      child: Image.network(pack.seeallpackages[index].image,
                          fit: BoxFit.scaleDown,
                          // width: double.maxFinite,
                          height: screenHeight * 0.175,
                          width: _width * 0.8),
                    ),
                  ));
                }),
      ),
    );
  }
}

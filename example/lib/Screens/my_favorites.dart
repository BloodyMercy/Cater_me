import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/widgets/occasions/occasions_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFavorites extends StatefulWidget {
  const MyFavorites({Key? key}) : super(key: key);

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  bool loading=true;
  getData()async{
    final package=Provider.of<PackagesProvider>(context,listen: false);
    await package.getAllFavorite();
    setState(() {
      loading=false;
    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final package=Provider.of<PackagesProvider>(context,listen: true);

    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
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
            'My Favorites',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child:!loading?
              package.listfavorite.length==0?Center(child: Text("No Favorite To Dispaly!"),):
              Column(
                children: [...getFavorites(package.listfavorite)],
              ):
              Center(child: CircularProgressIndicator(),),
            ),
          ),
        ),
      ),
    );
  }
}

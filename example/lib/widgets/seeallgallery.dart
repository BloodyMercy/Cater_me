import 'package:CaterMe/Providers/GalleryProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/user.dart';
import '../Screens/full_photo_page.dart';
import '../language/language.dart';

class seeAllGallery extends StatefulWidget {

  @override
  State<seeAllGallery> createState() => _seeAllGalleryState();
}

class _seeAllGalleryState extends State<seeAllGallery> {
  getdata(){
   final _gallery= Provider.of<GalleryProvider> (context, listen: false );
   _gallery.getseeall();
  }
  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }
  @override

  Widget build(BuildContext context) {

    final _gallery= Provider.of<GalleryProvider> (context, listen: true );
    final mediaQuery = MediaQuery.of(context);
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
       appBar: AppBar(
         title:Text('${authProvider.lg[authProvider.language]["Gallery"]}'),
             centerTitle: true,
          leading:IconButton(
            onPressed:(){
              Navigator.of(context).pop();

            },

            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
       ),
      body:_gallery.loading?GridView.builder(
          itemCount: _gallery.seeall.length,
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:  2 ), itemBuilder:(context ,inde){
        return  InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullPhotoPage(url:  _gallery.seeall[inde].link),
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
              decoration: BoxDecoration(
                border: Border.all(style: BorderStyle.none),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: mediaQuery.size.width /3,
              height: mediaQuery.size.height /5,
              child:Image.network(_gallery.seeall[inde].link,
                fit: BoxFit.fill,
                width: mediaQuery.size.width * 0.3,
                height: mediaQuery.size.height * 0.50,
              ),
            ),
          ),
        );
      } ) :Center(child: CircularProgressIndicator(color:Color(0xFF3F5521) ,),),
    );
  }
}

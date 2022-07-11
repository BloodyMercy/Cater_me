import 'package:CaterMe/Providers/GalleryProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/user.dart';
import '../Screens/full_photo_page.dart';

class seeAllGallery extends StatefulWidget {

  @override
  State<seeAllGallery> createState() => _seeAllGalleryState();
}

class _seeAllGalleryState extends State<seeAllGallery> {
  getdata()async{
   final _gallery= Provider.of<GalleryProvider> (context, listen: false );
   await _gallery.getseeall();
   setState(() {
     loading = false;
   });

  }
  bool loading = true;
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
      body:
      !loading?
      GridView.builder(
          itemCount: _gallery.seeall.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:  2 ), itemBuilder:(context ,inde){
        return  InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullPhotoPage(url:  _gallery.seeall,ind: inde),
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
                image: DecorationImage(image: NetworkImage(_gallery.seeall[inde].link,
                ),  fit: BoxFit.cover,),
                border: Border.all(style: BorderStyle.none),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: mediaQuery.size.width /3,
              height: mediaQuery.size.height /5,
            ),
          ),
        );
      } ) :Center(child: CircularProgressIndicator(color:Color(0xFF3F5521) ,),),
    );
  }
}

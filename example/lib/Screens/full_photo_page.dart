import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../Providers/user.dart';
import '../model/GaleryModel.dart';




class FullPhotoPage extends StatefulWidget {
  final List<GalleryModel> url;
  int ind;
  FullPhotoPage({Key key,    this.url ,this.ind}) : super(key: key);

  @override
  State<FullPhotoPage> createState() => _FullPhotoPageState();
}

class _FullPhotoPageState extends State<FullPhotoPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.url.insert(0, widget.url[widget.ind]);
    widget.url.removeAt(widget.ind);
  }
  @override

  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      backgroundColor:  Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF3F5521),
        title: Text(
          '${authProvider.lg[authProvider.language]["Photo"]}',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:
        PageView.builder(
          itemCount: widget.url.length,

          itemBuilder: (context, index) {
          return  Container(
decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(18))),
            child: PhotoView(

         tightMode: true,

              imageProvider: NetworkImage(widget.url[index].link,  ),
            ),
            );
        },)
      // Container(

        // child: PhotoView(
        //   imageProvider: NetworkImage(url),
        // ),
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../Providers/user.dart';




class FullPhotoPage extends StatelessWidget {
  final String url;
  FullPhotoPage({Key key,    this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      backgroundColor:  Color(0xFF3F5521),
      appBar: AppBar(
        backgroundColor: Color(0xFF3F5521),
        title: Text(
          '${authProvider.lg[authProvider.language]["Photo"]}',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(url),
        ),
      ),
    );
  }
}

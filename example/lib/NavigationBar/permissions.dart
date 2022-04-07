import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
class PermissionHandlerScreen extends StatefulWidget {
  @override
  _PermissionHandlerScreenState createState() =>
      _PermissionHandlerScreenState();
}

class _PermissionHandlerScreenState extends State<PermissionHandlerScreen> {
  @override
  void initState() {
    super.initState();
    permissionServiceCall();
  }

  permissionServiceCall() async {
    await permissionServices().then(
          (value) {
        if (value != null) {
          if (value[Permission.storage].isGranted &&
              value[Permission.camera].isGranted &&
              value[Permission.microphone].isGranted) {
            /* ========= New Screen Added  ============= */
            //
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => SplashScreen()),
            // );
          }
        }
      },
    );
  }

  /*Permission services*/
  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [


      Permission.contacts
      //add more permission to request here.
    ].request();

    if (statuses[Permission.contacts].isPermanentlyDenied) {
      openAppSettings();
      //setState(() {});
    } else {
      if (statuses[Permission.contacts].isDenied) {
        permissionServiceCall();
      }
    }





    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: Container(
          child: Center(
            child: InkWell(
                onTap: () {
                  permissionServiceCall();
                },
                child: Text("Click here to enable Enable Permissions")),
          ),
        ),
      ),
    );
  }
}

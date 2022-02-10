import 'dart:async';
import 'dart:typed_data';
import 'package:CaterMe/Providers/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;


class ConfirmLocation extends StatefulWidget {

  //String  idprof;
  ConfirmLocation();
  @override
  _ConfirmLocationState createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 //  @override
 // void dispose(){
 //    _scaffoldKey.currentState.removeCurrentSnackBar();
 //    super.dispose();
 //  }
  LatLng currentLatLng= LatLng(0.0, 0.0); //initial currentPosition values cannot assign null values
  Completer<GoogleMapController> _controller = Completer();
bool loading=false;

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 20,tilt: 50.0,
      bearing: 45.0,)));
  }

  void getCurrentLocation() async{

    await Geolocator.getCurrentPosition().then((currLocation) async {
      setState(() {
        currentLatLng =
        new LatLng(currLocation.latitude, currLocation.longitude);

      });
      final address=Provider.of<AdressProvider>(context,listen: false);
      address.latitudenumbercontroller.text=currentLatLng.latitude.toString();
      address.longtituenumbercontroller.text=currentLatLng.longitude.toString();
      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: currentLatLng,
          zoom: 12.0,
        ),
      ));

    });

  }
  String cityselected="";
  LocationPermission permission = LocationPermission.denied;
  void checkPermission() async{
    permission = await Geolocator.checkPermission();
    if(permission.name=="denied") {
      await Geolocator.requestPermission();
      getCurrentLocation();
    }
    else
    getCurrentLocation();
  }

  bool ready=true;
  LatLng initPosition = LatLng(0, 0);

  checkReady(LatLng x, LocationPermission y) {
    if (x == initPosition || y == LocationPermission.denied || y == LocationPermission.deniedForever) {
      setState(() {
        ready=true;
      });
    } else {
      setState(() {
        ready=false;
      });
    }
  }
  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: currentLatLng,
        zoom: 12.0,
      ),
    ));
  }
 Uint8List myIcon;
   BitmapDescriptor mybit;
  @override
  initState(){

    checkPermission();


    getmarker();


  }
 Future getmarker() async{
     Uint8List markerIcon = await getBytesFromAsset('images/marker.png', 80);
  setState(() {
    mybit= BitmapDescriptor.fromBytes(markerIcon);
  });

  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }


  bool loadingMap=true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final address=Provider.of<AdressProvider>(context,listen: true);


    return Scaffold(
      backgroundColor:  Color(0xFF3F5521),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title:  Text(
          "Choose Address",
          style: TextStyle(
              color: Colors.white, fontFamily: 'Ubuntu', fontSize: 14),
        ),
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),


        actions: [address.loading?Center(child: CircularProgressIndicator(color: Colors.white,)):
          IconButton(
            icon:  Icon(Icons.done),
            onPressed: () async{
              _gotoLocation(double.parse( address.latitudenumbercontroller.text.toString()),double.parse(address.longtituenumbercontroller.text.toString()));

              address.loading=true;
              address.notifyListeners();
              if(address.createOrUpdate==0){
                await address.createAddress();
                address.loading=false;
                if( address.addressCreated.id==0){
                  // _scaffoldKey.currentState.showSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add address")));
                }else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address added")));
                await  Future.delayed(Duration(seconds: 2));
                  Navigator.of(context).pop();
                }
              }else{
                 await address.updateAddresss();
                address.loading=false;
                if( address.addressUpdated.id!=0){
                  address.getAllAddress();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("updated done ")));
                  await  Future.delayed(Duration(seconds: 2));
                  Navigator.of(context).pop();// ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update address")));
                }else{
                  address.getAllAddress();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated failed ")));
                  // Navigator.of(context).pop();
                }
              }


            },
          )
        ],

      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          markers: Set<Marker>.of(
            <Marker>[
          Marker(
          onTap: () {
        print('Tapped');
        },
            draggable: true,
            markerId: MarkerId('Marker'),
            // icon: mybit,
            position: LatLng(currentLatLng.latitude, currentLatLng.longitude),
            onDragEnd: ((newPosition) {
              print(newPosition.latitude);
              print(newPosition.longitude);
              address.latitudenumbercontroller.text=newPosition.latitude.toString();
              address.longtituenumbercontroller.text=newPosition.longitude.toString();
            })),

            ],
          ),

         initialCameraPosition: CameraPosition(target: currentLatLng),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          //  controller.setMapStyle('[  {    "elementType": "geometry",    "stylers": [      {        "color": "#212121"      }    ]  },  {    "elementType": "labels.icon",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#757575"      }    ]  },  {    "elementType": "labels.text.stroke",    "stylers": [      {        "color": "#212121"      }    ]  },  {    "featureType": "administrative",    "elementType": "geometry",    "stylers": [      {        "color": "#757575"      },      {        "visibility": "off"      }    ]  },  {    "featureType": "administrative.country",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#9e9e9e"      }    ]  },  {    "featureType": "administrative.land_parcel",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "administrative.locality",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#bdbdbd"      }    ]  },  {    "featureType": "poi",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "poi",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#757575"      }    ]  },  {    "featureType": "poi.park",    "elementType": "geometry",    "stylers": [      {        "color": "#181818"      }    ]  },  {    "featureType": "poi.park",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#616161"      }    ]  },  {    "featureType": "poi.park",    "elementType": "labels.text.stroke",    "stylers": [      {        "color": "#1b1b1b"      }    ]  },  {    "featureType": "road",    "elementType": "geometry.fill",    "stylers": [      {        "color": "#2c2c2c"      }    ]  },  {    "featureType": "road",    "elementType": "labels.icon",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "road",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#8a8a8a"      }    ]  },  {    "featureType": "road.arterial",    "elementType": "geometry",    "stylers": [      {        "color": "#373737"      }    ]  },  {    "featureType": "road.highway",    "elementType": "geometry",    "stylers": [      {        "color": "#3c3c3c"      }    ]  },  {    "featureType": "road.highway.controlled_access",    "elementType": "geometry",    "stylers": [      {        "color": "#4e4e4e"      }    ]  },  {    "featureType": "road.local",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#616161"      }    ]  },  {    "featureType": "transit",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "transit",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#757575"      }    ]  },  {    "featureType": "water",    "elementType": "geometry",    "stylers": [      {        "color": "#000000"      }    ]  },  {    "featureType": "water",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#3d3d3d"      }    ]  }]');
          },

        ),
      ),
    );
  }
}

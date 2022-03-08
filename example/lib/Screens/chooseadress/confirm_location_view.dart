import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:CaterMe/widgets/Addresses/addresses_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ConfirmLocation extends StatefulWidget {
  //String  idprof;
  ConfirmLocation();
  @override
  _ConfirmLocationState createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LatLng currentLatLng = LatLng(
      0.0, 0.0); //initial currentPosition values cannot assign null values
  Completer<GoogleMapController> _controller = Completer();
  bool loading = false;

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 40,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
requestlocation() async{
  var status = await Permission.locationWhenInUse.status;
  if(!status.isGranted){
    var status = await Permission.locationWhenInUse.request();
    if(status.isGranted){
      var status = await Permission.locationAlways.request();
      if(status.isGranted){
        //Do some stuff
      }else{
        //Do another stuff
      }
    }else{
      //The user deny the permission
    }
    if(status.isPermanentlyDenied){
      //When the user previously rejected the permission and select never ask again
      //Open the screen of settings
      bool res = await openAppSettings();
    }
  }else{
    //In use is available, check the always in use
    var status = await Permission.locationAlways.status;
    if(!status.isGranted){
      var status = await Permission.locationAlways.request();
      if(status.isGranted){
        //Do some stuff
      }else{
        //Do another stuff
      }
    }else{
      //previously available, do some stuff or nothing
    }
  }
}
  void getCurrentLocation() async {
    // await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    await Geolocator.requestPermission();


    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true
    )
        .then((currLocation) async {
      setState(() {
        currentLatLng =
            new LatLng(currLocation.latitude, currLocation.longitude);
      });

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: currentLatLng,
          zoom: 15.0,
        ),
      ));
      final address = Provider.of<AdressProvider>(context, listen: false);
      address.latitudenumbercontroller.text = currentLatLng.latitude.toString();
      address.longtituenumbercontroller.text =
          currentLatLng.longitude.toString();
     // await getcityname(currLocation.latitude, currLocation.longitude);
    });
  }

  Future<void> getcityname(double a, double b) async {
    final address = Provider.of<AdressProvider>(context, listen: false);

    List<Placemark> placemarks = await placemarkFromCoordinates(a, b);
    print(placemarks[0]);
    address.countrycontrollerstring.text = placemarks[0].country;
    address.countrycontroller.text = placemarks[0].country;
    address.citycontrollerstring.text = placemarks[0].locality;
    address.citycontroller.text = placemarks[0].locality;
    address.streetcontroller.text = placemarks[0].street;

    setState(() {});
  }

  String cityselected = "";
  LocationPermission permission = LocationPermission.denied;
  void checkPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission.name == "denied") {
      await Geolocator.requestPermission();
      getCurrentLocation();
    } else
      getCurrentLocation();
  }

  bool ready = true;
  LatLng initPosition = LatLng(0, 0);

  checkReady(LatLng x, LocationPermission y) {
    if (x == initPosition ||
        y == LocationPermission.denied ||
        y == LocationPermission.deniedForever) {
      setState(() {
        ready = true;
      });
    } else {
      setState(() {
        ready = false;
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
  initState() {
  //  requestlocation();
    checkPermission();
    getCurrentLocation();

    //getmarker();
  }

  Future getmarker() async {
    Uint8List markerIcon = await getBytesFromAsset('images/marker.png', 80);
    setState(() {
      mybit = BitmapDescriptor.fromBytes(markerIcon);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  List<Addresses> _address = [];
  void _addNewAddress(
    String contactName,
    String email,
    String phoneNumber,
    String country,
    String city,
    String addressTitle,
    // String id,
  ) {
    final newAddress = Addresses(
      // image: image,
      contactName: contactName,
      email: email,
      phoneNumber: phoneNumber,
      country: country,
      city: city,
      addressTitle: addressTitle,
      id: DateTime.now().toString(),
    );

    setState(() {
      _address.add(newAddress);
    });
  }

  bool loadingMap = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final address = Provider.of<AdressProvider>(context, listen: true);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                _gotoLocation(
                    double.parse(
                        address.latitudenumbercontroller.text.toString()),
                    double.parse(
                        address.longtituenumbercontroller.text.toString()));
                getcityname(
                    double.parse(
                        address.latitudenumbercontroller.text.toString()),
                    double.parse(
                        address.longtituenumbercontroller.text.toString()));
                //address.loading=true;
                // address.notifyListeners();

                address.createOrUpdate = 0;
                address.addresstitlecontroller.clear();
                // address.countrycontroller.clear();
                //  address.citycontrollerstring.clear();
                // address.streetcontroller.clear();
                address.buildingcontroller.clear();
                address.floornumbercontroller.clear();
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (_) {
                      return AddressesTextField(_addNewAddress, context);
                    });
              },
              child: Text(
                "Confirm location",
                style: const TextStyle(
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3F5521)),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(255, 255, 255, 1.0),
                ),
                minimumSize: MaterialStateProperty.all(Size(200, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
              ),
            ),
          ),
        ]),
        backgroundColor: Color(0xFF3F5521),
        body: Stack(children: <Widget>[


          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            //   markers: Set<Marker>.of(
            //     <Marker>[
            //   Marker(
            //   onTap: () {
            // print('Tapped');
            // },
            //     draggable: true,
            //     markerId: MarkerId('Marker'),
            //     // icon: mybit,
            //     position: LatLng(currentLatLng.latitude, currentLatLng.longitude),
            //     onDragEnd: ((newPosition) {
            //       print(newPosition.latitude);
            //       print(newPosition.longitude);
            //       address.latitudenumbercontroller.text=newPosition.latitude.toString();
            //       address.longtituenumbercontroller.text=newPosition.longitude.toString();
            //     })),
            //
            //     ],
            //   ),
            onCameraMove: (position) {
              if (position != null) {
                address.latitudenumbercontroller.text =
                    position.target.latitude.toString();
                address.longtituenumbercontroller.text =
                    position.target.longitude.toString();
              } // setState(() {
              //   markers.add(Marker(markerId: markerId,position: position.target));
              // });
            },
            initialCameraPosition: CameraPosition(target: currentLatLng),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              //  controller.setMapStyle('[  {    "elementType": "geometry",    "stylers": [      {        "color": "#212121"      }    ]  },  {    "elementType": "labels.icon",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#757575"      }    ]  },  {    "elementType": "labels.text.stroke",    "stylers": [      {        "color": "#212121"      }    ]  },  {    "featureType": "administrative",    "elementType": "geometry",    "stylers": [      {        "color": "#757575"      },      {        "visibility": "off"      }    ]  },  {    "featureType": "administrative.country",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#9e9e9e"      }    ]  },  {    "featureType": "administrative.land_parcel",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "administrative.locality",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#bdbdbd"      }    ]  },  {    "featureType": "poi",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "poi",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#757575"      }    ]  },  {    "featureType": "poi.park",    "elementType": "geometry",    "stylers": [      {        "color": "#181818"      }    ]  },  {    "featureType": "poi.park",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#616161"      }    ]  },  {    "featureType": "poi.park",    "elementType": "labels.text.stroke",    "stylers": [      {        "color": "#1b1b1b"      }    ]  },  {    "featureType": "road",    "elementType": "geometry.fill",    "stylers": [      {        "color": "#2c2c2c"      }    ]  },  {    "featureType": "road",    "elementType": "labels.icon",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "road",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#8a8a8a"      }    ]  },  {    "featureType": "road.arterial",    "elementType": "geometry",    "stylers": [      {        "color": "#373737"      }    ]  },  {    "featureType": "road.highway",    "elementType": "geometry",    "stylers": [      {        "color": "#3c3c3c"      }    ]  },  {    "featureType": "road.highway.controlled_access",    "elementType": "geometry",    "stylers": [      {        "color": "#4e4e4e"      }    ]  },  {    "featureType": "road.local",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#616161"      }    ]  },  {    "featureType": "transit",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "transit",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#757575"      }    ]  },  {    "featureType": "water",    "elementType": "geometry",    "stylers": [      {        "color": "#000000"      }    ]  },  {    "featureType": "water",    "elementType": "labels.text.fill",    "stylers": [      {        "color": "#3d3d3d"      }    ]  }]');
            },
          ),


              Padding(
          padding: const EdgeInsets.only(top: 37,left: 15),
          child:
          Align(alignment: Alignment.topLeft,
             child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)
                  ),
                child: IconButton(onPressed:(){
                  Navigator.of(context).pop(); }
                  , icon: Icon(Icons.close,size: 25,),color:Color(0xFF3F5521),))),),



          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: (){
                getCurrentLocation();
              },
                child:Icon(
              Icons.place,
              size: 30,
            )),
          ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: IconButton(onPressed: (){
          //       Navigator.pop(context);
          //     }, icon: Icon(Icons.chevron_left, size: 50,)),
          //   ),
          // ),
        ]));
  }
}

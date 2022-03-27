import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:CaterMe/widgets/Addresses/address_list_settings.dart';
import 'package:CaterMe/widgets/Addresses/addresses_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/user.dart';
import '../language/language.dart';
import 'chooseadress/confirm_location_view.dart';

class AddAddressSettingsScreen extends StatefulWidget {
  const AddAddressSettingsScreen({Key key}) : super(key: key);

  @override
  State<AddAddressSettingsScreen> createState() =>
      _AddAddressSettingsScreenState();
}

class _AddAddressSettingsScreenState extends State<AddAddressSettingsScreen> {
  @override
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

  void _startAddNewAddress(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return AddressesTextField(_addNewAddress,ctx);
        });
  }


  void deleteAddress(String id) {
    setState(() {
      _address.removeWhere(
        (element) => element.id == id,
      );
    });
  }

  bool loading = true;

  getData() async {
    final adress = Provider.of<AdressProvider>(context, listen: false);
    await adress.getAllAddress();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true);
    final address = Provider.of<AdressProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    var _mediaQuery = MediaQuery.of(context).size.height;

    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              address.clearAddressController();
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
          elevation: 0,

          centerTitle: true,
          title: Text(
            '${user.lg[user.language][ "Addresses"]}',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(onPressed: (){
              // address.createOrUpdate=0;
              // address.addresstitlecontroller.clear();
              // address.citycontrollerstring.clear();
              // address.streetcontroller.clear();
              // address.buildingcontroller.clear();
              // address.floornumbercontroller.clear();
              // showModalBottomSheet(
              //   isScrollControlled: true,
              //   context: context,
              //   builder: (_) {
              //     return AddressesTextField(_addNewAddress, context);
              //   });
              address.isUpdate=false;
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ConfirmLocation() ));
              },
                icon: Icon(Icons.add))
          ],
        ),
        body: loading? Center(child:CircularProgressIndicator()) :
          AddressesListSettings(address.listaddress),
        // !loading
        //     ? Center(
        //       child: CircularProgressIndicator(
        //         color: Color(0xFF3F5521),
        //       ),
        //     )
        //     :
      //   Center(
      //       child: Image.asset('images/NoAdresses.png'))
      // ),
    ));
  }
}

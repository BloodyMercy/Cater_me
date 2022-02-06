import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:CaterMe/widgets/Addresses/addresses_list.dart';
import 'package:CaterMe/widgets/Addresses/addresses_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
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
        context: ctx,
        builder: (_) {
          return AddressesTextField(_addNewAddress);
        });
  }

  void deleteAddress(String id) {
    setState(() {
      _address.removeWhere(
        (element) => element.id == id,
      );
    });
  }
  bool loading=true;

  getData()async{
    final adress=Provider.of<AdressProvider>(context,listen: false);
    await adress.getAllAddress();
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
    final adress=Provider.of<AdressProvider>(context,listen: true);
    final mediaQuery = MediaQuery.of(context);
    var _mediaQuery = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: [
          SizedBox(
              height: mediaQuery.size.height*0.53,
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    !loading? AddressesList(adress.listaddress, deleteAddress):Center(child: CircularProgressIndicator(),),
                  ],
                ),
              ),
          ),
          SizedBox(
            height: mediaQuery.size.height*0.1,
            width: mediaQuery.size.width * 0.52,
            child:
          Padding(
            padding:  EdgeInsets.only(top:mediaQuery.size.height*0.01),
            child: ElevatedButton(onPressed:  () => _startAddNewAddress(context), child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Add An Address", style: TextStyle(color: Color(0xFF3F5521), fontFamily:'BerlinSansFB' , fontSize: 20),),
              Icon(Icons.add, color: Color(0xFF3F5521),)
            ],),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Colors.white,
             ),

            ),
          ),
          ),
        ],
      ),

        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Theme.of(context).primaryColor,
        //   child: Icon(Icons.add),
        //   onPressed: () => _startAddNewAddress(context),
        // ),

    );
  }
}

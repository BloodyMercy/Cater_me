import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Screens/regular_daberne_screen.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:CaterMe/widgets/Addresses/addresses_list.dart';
import 'package:CaterMe/widgets/Addresses/addresses_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressScreenFAB extends StatefulWidget {
  const AddAddressScreenFAB({Key key}) : super(key: key);

  @override
  State<AddAddressScreenFAB> createState() => _AddAddressScreenStateFAB();
}

class _AddAddressScreenStateFAB extends State<AddAddressScreenFAB> {
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
          return AddressesTextField(_addNewAddress ,ctx);
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

    var _mediaQuery = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            child: Column(
              children: [
              !loading?  AddressesList(adress.listaddress, deleteAddress):Center(child: CircularProgressIndicator(),),
                SizedBox(height: _mediaQuery * 0.150),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RegularDaberneScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'NEXT',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(
                        _mediaQuery * 0.18,
                        _mediaQuery * 0.02,
                        _mediaQuery * 0.18,
                        _mediaQuery * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: const Color(0xff3F5521),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => _startAddNewAddress(context),
      ),
    );
  }
}

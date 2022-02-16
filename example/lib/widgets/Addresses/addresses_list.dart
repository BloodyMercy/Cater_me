import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addresses_textField.dart';

class AddressesList extends StatefulWidget {
  final List<Address> address;
  Function deleteAddress;

  AddressesList(this.address, this.deleteAddress);

  @override
  State<AddressesList> createState() => _AddressesListState();
}

class _AddressesListState extends State<AddressesList> {
  int _value = -1;
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
          return AddressesTextField(_addNewAddress, ctx);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//getdata();
  }

  getdata() {
    final orderprovider =
        Provider.of<OrderCaterProvider>(context, listen: false);

    _value = orderprovider.valueIndex;
    print(_value);
  }

  @override
  Widget build(BuildContext context) {
    final orderprovider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var _mediaQuery = MediaQuery.of(context).size.height;
    return Container(
        height: _mediaQuery * 0.6,
        child: widget.address.isEmpty
            ? Column(
              children: [
                Center(child: Image.asset('images/noaddresses.png')),
                Center(
          child:  TextButton(
                onPressed: () => _startAddNewAddress(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add An Address",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFF3F5521),
                          fontFamily: 'BerlinSansFB',
                          fontSize: 17),
                    ),
                    Icon(
                      Icons.add,
                      color: Color(0xFF3F5521),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.white,
                ),
          ),
        ),
              ],
            )
            : CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int i) {
                      return Card(
                        color: LightColors.kLightYellow2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _mediaQuery * 0.04,
                              horizontal: _mediaQuery * 0.01),
                          child: Row(
                            children: [
                              Radio(
                                fillColor: MaterialStateColor.resolveWith((states) => colorCustom),
                                toggleable: true,
                                groupValue: orderprovider.valueIndex ,
                                value: i,
                                onChanged: (value) {
                                  setState(() {
                                    _value = i;
                                    orderprovider.valueIndex = i;
                                  });
                                  orderprovider.value = widget.address[i];
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(

                                        style: DefaultTextStyle.of(context).style,
                                        children:  <TextSpan>[
                                          // TextSpan(text: 'Title :', style: TextStyle(fontWeight: FontWeight.bold)),
                                          TextSpan(text: ' ${widget.address[i].title.toString()}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22)),
                                        ],
                                      ),
                                    ),

                                    RichText(
                                      text: TextSpan(

                                        style: DefaultTextStyle.of(context).style,
                                        children:  <TextSpan>[
                                          // TextSpan(text: 'City :', style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                                          TextSpan(text: ' ${widget.address[i].city.toString()}',style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                                        ],
                                      ),
                                    ),

                                    RichText(
                                      text: TextSpan(

                                        style: DefaultTextStyle.of(context).style,
                                        children:  <TextSpan>[
                                          TextSpan(text: ' Street :', style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                                          TextSpan(text: ' ${widget.address[i].street.toString()}',style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                                        ],
                                      ),
                                    ),

                                    RichText(
                                      text: TextSpan(

                                        style: DefaultTextStyle.of(context).style,
                                        children:  <TextSpan>[
                                          TextSpan(text: ' Building :',style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                                          TextSpan(text: ' ${widget.address[i].buildingName.toString()}',style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                                        ],
                                      ),
                                    ),
                                    // Text(
                                    //   "Building Name: ${widget.address[i].buildingName.toString()}",
                                    //   style: const TextStyle(
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    // Radio(
                                    //   value: 5,
                                    //   groupValue: _value,
                                    //   onChanged: (value) {
                                    //     setState(() {
                                    //       _value = _value;
                                    //     });
                                    //   },
                                    // ),
                                    RichText(
                                      text: TextSpan(

                                        style: DefaultTextStyle.of(context).style,
                                        children:  <TextSpan>[
                                          TextSpan(text: ' Floor :', style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                                          TextSpan(text: ' ${widget.address[i].floorNumber.toString()}',style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                                        ],
                                      ),
                                    ),
                                    // Text(
                                    //   "Floor Number: ${widget.address[i].floorNumber.toString()}",
                                    //   style: const TextStyle(
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: widget.address.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: TextButton(
                    onPressed: () => _startAddNewAddress(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add An Address",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xFF3F5521),
                              fontFamily: 'BerlinSansFB',
                              fontSize: 17),
                        ),
                        Icon(
                          Icons.add,
                          color: Color(0xFF3F5521),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.white,
                    ),
                  ),
                )
              ],
            )

        );
  }
}

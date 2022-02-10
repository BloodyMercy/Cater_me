import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
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
        context: ctx,
        builder: (_) {
          return AddressesTextField(_addNewAddress);
        });
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
            ? Center(
                child: Container(
                child: Image.asset('images/no addresses yet-01.png'),
              ))
            : Expanded(
                child: CustomScrollView(
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
                                  SizedBox(
                                    width: 45,
                                  ),
                                  Radio(
                                    toggleable: true,
                                    groupValue: orderprovider.valueIndex,
                                    value: i,
                                    onChanged: (value) {
                                      setState(() {
                                        _value = i;
                                        orderprovider.valueIndex = i;
                                      });
                                      orderprovider.value = widget.address[i];
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Title: ${widget.address[i].title.toString()}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Radio(
                                      //   value: 2,
                                      //   groupValue: _value,
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       _value = _value;
                                      //     });
                                      //   },
                                      // ),
                                      Text(
                                        "City: ${widget.address[i].city.toString()}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Radio(
                                      //   value: 3,
                                      //   groupValue: _value,
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       _value = _value;
                                      //     });
                                      //   },
                                      // ),
                                      Text(
                                        "Street: ${widget.address[i].street.toString()}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Radio(
                                      //   value: 4,
                                      //   groupValue: _value,
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       _value = _value;
                                      //     });
                                      //   },
                                      // ),
                                      Text(
                                        "Building Name: ${widget.address[i].buildingName.toString()}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Radio(
                                      //   value: 5,
                                      //   groupValue: _value,
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       _value = _value;
                                      //     });
                                      //   },
                                      // ),
                                      Text(
                                        "Floor Number: ${widget.address[i].floorNumber.toString()}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
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
                      child: ElevatedButton(
                      onPressed: () => _startAddNewAddress(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add An Address",
                            style: TextStyle(
                                color: Color(0xFF3F5521),
                                fontFamily: 'BerlinSansFB',
                                fontSize: 20),
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
                ),
              )
        // : ListView.builder(
        //     itemCount: widget.address.length,
        //     itemBuilder: (ctx, index) {
        //       return Card(
        //         color: LightColors.kLightYellow2,
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(
        //               vertical: _mediaQuery * 0.04,
        //               horizontal: _mediaQuery * 0.01),
        //           child: Row(
        //             children: [
        //               SizedBox(
        //                 width: 45,
        //               ),
        //               Radio(
        //                 toggleable: true,
        //                 groupValue: orderprovider.valueIndex,
        //                 value: index,
        //                 onChanged: (value) {
        //                   setState(() {
        //                     _value = index;
        //                     orderprovider.valueIndex = index;
        //                   });
        //                   orderprovider.value = widget.address[index];
        //                 },
        //               ),
        //
        //               Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     "Title: ${widget.address[index].title.toString()}",
        //                     style: const TextStyle(
        //                         fontSize: 15, fontWeight: FontWeight.bold),
        //                   ),
        //                   // Radio(
        //                   //   value: 2,
        //                   //   groupValue: _value,
        //                   //   onChanged: (value) {
        //                   //     setState(() {
        //                   //       _value = _value;
        //                   //     });
        //                   //   },
        //                   // ),
        //                   Text(
        //                     "City: ${widget.address[index].city.toString()}",
        //                     style: const TextStyle(
        //                         fontSize: 15, fontWeight: FontWeight.bold),
        //                   ),
        //                   // Radio(
        //                   //   value: 3,
        //                   //   groupValue: _value,
        //                   //   onChanged: (value) {
        //                   //     setState(() {
        //                   //       _value = _value;
        //                   //     });
        //                   //   },
        //                   // ),
        //                   Text(
        //                     "Street: ${widget.address[index].street.toString()}",
        //                     style: const TextStyle(
        //                         fontSize: 15, fontWeight: FontWeight.bold),
        //                   ),
        //                   // Radio(
        //                   //   value: 4,
        //                   //   groupValue: _value,
        //                   //   onChanged: (value) {
        //                   //     setState(() {
        //                   //       _value = _value;
        //                   //     });
        //                   //   },
        //                   // ),
        //                   Text(
        //                     "Building Name: ${widget.address[index].buildingName.toString()}",
        //                     style: const TextStyle(
        //                         fontSize: 15, fontWeight: FontWeight.bold),
        //                   ),
        //                   // Radio(
        //                   //   value: 5,
        //                   //   groupValue: _value,
        //                   //   onChanged: (value) {
        //                   //     setState(() {
        //                   //       _value = _value;
        //                   //     });
        //                   //   },
        //                   // ),
        //                   Text(
        //                     "Floor Number: ${widget.address[index].floorNumber.toString()}",
        //                     style: const TextStyle(
        //                         fontSize: 15, fontWeight: FontWeight.bold),
        //                   ),
        //                 ],
        //               ),
        //               // Text(
        //               //   'Address Title',
        //               //   style: const TextStyle(
        //               //       fontSize: 20, fontWeight: FontWeight.bold),
        //               // ),
        //
        //               // SizedBox(height: _mediaQuery * 0.01),
        //             ],
        //           ),
        //         ),
        //       );
        //     }),
        );
  }
}

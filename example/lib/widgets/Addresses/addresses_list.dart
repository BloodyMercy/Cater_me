import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesList extends StatefulWidget {
  final List<Address> address;
  Function deleteAddress;

  AddressesList(this.address, this.deleteAddress);

  @override
  State<AddressesList> createState() => _AddressesListState();
}

class _AddressesListState extends State<AddressesList> {
  int _value = -1;

  @override
  Widget build(BuildContext context) {
    final orderprovider =
        Provider.of<OrderCaterProvider>(context, listen: true);
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var _mediaQuery = MediaQuery.of(context).size.height;
    return Container(
      height: _mediaQuery * 0.65,
      child: widget.address.isEmpty
          ? Center(
              child: Container(
              child: Image.asset('images/no addresses yet-01.png'),
            ))
          : ListView.builder(
              itemCount: widget.address.length,
              itemBuilder: (ctx, index) {
                return Card(
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
                          value: index,
                          onChanged: (value) {
                            setState(() {
                              _value = index;
                              orderprovider.valueIndex = index;
                            });
                            orderprovider.value = widget.address[index];
                          },
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title: ${widget.address[index].title.toString()}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              "City: ${widget.address[index].city.toString()}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              "Street: ${widget.address[index].street.toString()}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              "Building Name: ${widget.address[index].buildingName.toString()}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              "Floor Number: ${widget.address[index].floorNumber.toString()}",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // Text(
                        //   'Address Title',
                        //   style: const TextStyle(
                        //       fontSize: 20, fontWeight: FontWeight.bold),
                        // ),

                        // SizedBox(height: _mediaQuery * 0.01),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}

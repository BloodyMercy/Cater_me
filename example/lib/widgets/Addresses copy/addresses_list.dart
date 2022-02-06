import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesListFAB extends StatelessWidget {
  final List<Addresses> address;
  Function deleteAddress;

  AddressesListFAB(this.address, this.deleteAddress);

  @override
  Widget build(BuildContext context) {

    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var _mediaQuery = MediaQuery.of(context).size.height;
    return Container(
      height: _mediaQuery * 0.6,
      child: address.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No addresses added yet!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: _mediaQuery * 0.05),
                  Container(
                    height: _mediaQuery * 0.4,
                    child: Image.asset(
                      'images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: address.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address Title',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            address[index].addressTitle,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),

                          // SizedBox(height: _mediaQuery * 0.01),
                        ],
                      ),


                );
              },
            ),
    );
  }
}

import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Screens/chooseadress/confirm_location_view.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';
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

  String language;

  bool loading = true;

  getdata() async {
    final orderprovider =
        Provider.of<OrderCaterProvider>(context, listen: false);

    _value = orderprovider.valueIndex;
    print(_value);
    SharedPreferences sh = await SharedPreferences.getInstance();

    setState(() {
      language = sh.getString("locale");
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final address = Provider.of<AdressProvider>(context, listen: true);
    final orderprovider =
        Provider.of<OrderCaterProvider>(context, listen: true);

    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var _mediaQuery = MediaQuery.of(context).size.height;
    return !loading
        ? Container(
            height: _mediaQuery * 0.68,
            child: widget.address.isEmpty
                ? Column(
                    children: [
                      Center(
                          child: language == "en"
                              ? Image.asset('images/NoAddressesYet.png')
                              : Image.asset(
                                  'images/no address yetعربي/no addresses yetبالعربي-04.png')),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          primary: Colors.white,
                      fixedSize: const Size(50, 50),
                      shape: const CircleBorder(),
                      ),
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          address.isUpdate=false;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ConfirmLocation()));
                        },
                      )

                      // Center(
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //           builder: (_) => ConfirmLocation()));
                      //     },
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text(
                      //           '${LanguageTr.lg[authProvider.language]["Add an Address"]}',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.underline,
                      //               color: Color(0xFF3F5521),
                      //               fontFamily: 'BerlinSansFB',
                      //               fontSize: 17),
                      //         ),
                      //         Icon(
                      //           Icons.add,
                      //           color: Color(0xFF3F5521),
                      //         )
                      //       ],
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       primary: Colors.white,
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                : Stack(
                    children: [
                      CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int i) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _value = i;
                                        orderprovider.valueIndex = i;
                                      });
                                      orderprovider.value = widget.address[i];
                                    },
                                    child: Card(
                                      color: LightColors.kLightYellow2,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: _mediaQuery * 0.04,
                                            horizontal: _mediaQuery * 0.01),
                                        child: Row(
                                          children: [
                                            Radio(
                                              fillColor: MaterialStateColor
                                                  .resolveWith(
                                                      (states) => colorCustom),
                                              toggleable: true,
                                              groupValue:
                                                  orderprovider.valueIndex,
                                              value: i,
                                              onChanged: (value) {
                                                setState(() {
                                                  _value = i;
                                                  orderprovider.valueIndex = i;
                                                  orderprovider.value =
                                                      widget.address[i];
                                                });
                                              },
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
                                                      children: <TextSpan>[
                                                        // TextSpan(text: 'Title :', style: TextStyle(fontWeight: FontWeight.bold)),
                                                        TextSpan(
                                                            text:
                                                                ' ${widget.address[i].title.toString()}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 22)),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
                                                      children: <TextSpan>[
                                                        // TextSpan(text: 'City :', style: TextStyle(fontWeight: FontWeight.normal,color:Colors.black)),
                                                        TextSpan(
                                                            text:
                                                                ' ${widget.address[i].city.toString()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                '${LanguageTr.lg[authProvider.language]["Street:"]}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                        TextSpan(
                                                            text:
                                                                ' ${widget.address[i].street.toString()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                '${LanguageTr.lg[authProvider.language]["Building:"]}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                        TextSpan(
                                                            text:
                                                                ' ${widget.address[i].buildingName.toString()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                      ],
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style:
                                                          DefaultTextStyle.of(
                                                                  context)
                                                              .style,
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                '${LanguageTr.lg[authProvider.language]["Floor:"]}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                        TextSpan(
                                                            text:
                                                                ' ${widget.address[i].floorNumber.toString()}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .black)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                              childCount: widget.address.length,
                            ),
                          ),
                          // SliverToBoxAdapter(
                          //   child: TextButton(
                          //     onPressed: (){
                          //       Navigator.of(context).push(MaterialPageRoute(
                          //           builder: (_) => ConfirmLocation()));
                          //     },
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           '${LanguageTr.lg[authProvider.language]["Add an Address"]}',
                          //           style: TextStyle(
                          //               decoration: TextDecoration.underline,
                          //               color: Color(0xFF3F5521),
                          //               fontFamily: 'BerlinSansFB',
                          //               fontSize: 17),
                          //         ),
                          //         Icon(
                          //           Icons.add,
                          //           color: Color(0xFF3F5521),
                          //         )
                          //       ],
                          //     ),
                          //     style: ElevatedButton.styleFrom(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       primary: Colors.white,
                          //     ),
                          //   ),
                          // ),
                          SliverToBoxAdapter(
                              child: Container(
                            height: MediaQuery.of(context).size.height / 3,
                          ))
                        ],
                      ),
                      Positioned(
                        top: _mediaQuery * 0.52,
                        left: _mediaQueryWidth * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 8,
                            primary: Colors.white,
                            fixedSize: const Size(50, 50),
                            shape: const CircleBorder(),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            address.isUpdate=false;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ConfirmLocation()));
                          },
                        ),
                      )
                    ],
                  ))
        : Center(child: CircularProgressIndicator());
  }
}

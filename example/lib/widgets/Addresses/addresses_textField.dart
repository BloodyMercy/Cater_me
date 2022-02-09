import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Screens/chooseadress/confirm_location_view.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesTextField extends StatefulWidget {
  final Function addAddress;

  AddressesTextField(this.addAddress);

  @override
  State<AddressesTextField> createState() => _AddressesTextFields();
}

class _AddressesTextFields extends State<AddressesTextField> {
  final contactNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final addressTitleController = TextEditingController();

  bool loadingfinal = false;
  bool loading = true;

  getdata() async {
    final adress = Provider.of<AdressProvider>(context, listen: false);
    await adress.getallcountry();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final adress = Provider.of<AdressProvider>(context, listen: true);

    var _mediaQueryText = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: !loading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: _mediaQueryText * 0.03),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Address Title',
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                      controller: adress.addresstitlecontroller,
                    ),
                    SizedBox(height: _mediaQueryText * 0.03),

                    adress.listcountry.length != 0
                        ? CustomCupertinoPicker(
                            label: 'Country',
                            items: adress.listcountryname,
                            country: adress.listcountry,
                            selectedValue: 0,
                            inputType: TextInputType.number,
                            controller: adress.countrycontrollerstring,
                          )
                        : Center(child: CircularProgressIndicator(),),
                    SizedBox(height: _mediaQueryText * 0.03),


                    adress.listcity.length!=0
                        ? CustomCupertinoPicker(
                            label: 'City',
                            items: adress.listcityname,
                            city: adress.listcity,
                            selectedValue: 0,
                            inputType: TextInputType.number,
                            controller: adress.citycontrollerstring,
                          )
                        : Center(),
                    SizedBox(height: _mediaQueryText * 0.03),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Street',
                        contentPadding: EdgeInsets.only(left: 20),
                      ),

                      // keyboardType: TextInputType.phone,
                      controller: adress.streetcontroller,
                    ),
                    SizedBox(height: _mediaQueryText * 0.03),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Building',
                        contentPadding: EdgeInsets.only(left: 20),
                      ),

                      // keyboardType: TextInputType.phone,
                      controller: adress.buildingcontroller,
                    ),
                    SizedBox(height: _mediaQueryText * 0.03),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Floor',
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                      // keyboardType: TextInputType.phone,
                      controller: adress.floornumbercontroller,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: _mediaQueryText * 0.03),


                    SizedBox(height: _mediaQueryText * 0.03),

                    SizedBox(height: _mediaQueryText * 0.03),
                    !loadingfinal
                        ? ElevatedButton(
                            onPressed: () {
                              // setState(() {
                              //   loadingfinal = true;
                              // });
                              if (adress
                                      .addresstitlecontroller.text.isEmpty ||
                                  adress.countrycontroller.text.isEmpty ||
                                  adress.citycontroller.text.isEmpty ||
                                  adress.streetcontroller.text.isEmpty ||
                                  adress.buildingcontroller.text.isEmpty ||
                                  adress.floornumbercontroller.text.isEmpty) {
                                // setState(() {
                                //   loadingfinal = false;
                                // });
                                print("Added Failed");
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Add Address Failed!",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                                return;
                              }

                              // adress.createAddress();
                              // setState(() {
                              //   loadingfinal = false;
                              // });
                              // _scaffoldKey.currentState!.showSnackBar(
                              //   SnackBar(
                              //     content: Text(
                              //       "Add Address Succes",
                              //       style: TextStyle(color: Colors.white),
                              //     ),
                              //   ),
                              // );
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ConfirmLocation() ));
                            },
                            child: Text(
                              'Next',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(
                                left: 35,
                                right: 35,
                                top: 15,
                                bottom: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              primary: Theme.of(context).primaryColor,
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

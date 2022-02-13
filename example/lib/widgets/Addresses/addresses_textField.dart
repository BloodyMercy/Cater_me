import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Screens/chooseadress/confirm_location_view.dart';
import 'package:CaterMe/Screens/widgets/Costumtextfield.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesTextField extends StatefulWidget {
  final Function addAddress;
BuildContext main;
  AddressesTextField(this.addAddress, this.main);

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
  // @override
  // void dispose() {
  //   _scaffoldKey.currentState.removeCurrentSnackBar();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    final adress = Provider.of<AdressProvider>(context, listen: true);

    var _mediaQueryText = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      key:_scaffoldKey ,
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
                    customTextField(label:'Address Title' ,controller:adress.addresstitlecontroller ,read: false,)
                   ,


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
                    customTextField(label:'Street' ,controller:adress.streetcontroller ,read: false,),



                      // keyboardType: TextInputType.phone,

                    SizedBox(height: _mediaQueryText * 0.03),
                    customTextField(label:'Building' ,controller:adress.buildingcontroller ,read: false,),


                    SizedBox(height: _mediaQueryText * 0.03),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,

                        controller: adress.floornumbercontroller,
                        focusNode: focusNode,

                        decoration: InputDecoration(



                            contentPadding:
                            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),

                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                                fontSize: focusNode.hasFocus ? 18 : 16.0,//I believe the size difference here is 6.0 to account padding
                                color:
                                focusNode.hasFocus ? Color(0xFF3F5521) : Colors.grey),
                            labelText: "Floor",
                            hintStyle:const TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BerlinSansFB'),

                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3F5521),
                                ))),
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'BerlinSansFB'),
                      ),
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
                                ScaffoldMessenger.of(widget.main).showSnackBar( SnackBar(
                                  content: Text(
                                    "Add Address Failed!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),);

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

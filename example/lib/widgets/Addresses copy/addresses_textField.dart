import 'package:flutter/material.dart';

class AddressesTextFieldFAB extends StatefulWidget {
  final Function addAddress;

  AddressesTextFieldFAB(this.addAddress);

  @override
  State<AddressesTextFieldFAB> createState() => _AddressesTextFieldsFAB();
}

class _AddressesTextFieldsFAB extends State<AddressesTextFieldFAB> {
  final contactNameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneNumberController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final addressTitleController = TextEditingController();

  void submitData() {
    final enteredContactName = contactNameController.text;
    final enteredemail = emailController.text;
    final enteredphoneNumber = phoneNumberController.text;
    final enteredCountryNumber = countryController.text;
    final enteredCity = cityController.text;
    final enteredaddressTitle = addressTitleController.text;

    if (enteredContactName.isEmpty ||
        enteredemail.isEmpty ||
        enteredphoneNumber.isEmpty ||
        enteredCountryNumber.isEmpty ||
        enteredCity.isEmpty ||
        enteredaddressTitle.isEmpty) {
      return;
    }

    widget.addAddress(
      enteredContactName,
      enteredemail,
      enteredphoneNumber,
      enteredCountryNumber,
      enteredCity,
      enteredaddressTitle,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryText = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: _mediaQueryText * 0.03),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Contact Name',
                contentPadding: EdgeInsets.only(left: 20),
              ),
              onSubmitted: (_) => submitData(),
              controller: contactNameController,
            ),
            SizedBox(height: _mediaQueryText * 0.03),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                contentPadding: EdgeInsets.only(left: 20),
              ),
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            SizedBox(height: _mediaQueryText * 0.03),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                contentPadding: EdgeInsets.only(left: 20),
              ),
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.phone,
              controller: phoneNumberController,
            ),
            SizedBox(height: _mediaQueryText * 0.03),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Country',
                contentPadding: EdgeInsets.only(left: 20),
              ),
              onSubmitted: (_) => submitData(),
              // keyboardType: TextInputType.phone,
              controller: countryController,
            ),
            SizedBox(height: _mediaQueryText * 0.03),
            TextField(
              decoration: const InputDecoration(
                labelText: 'City',
                contentPadding: EdgeInsets.only(left: 20),
              ),
              onSubmitted: (_) => submitData(),
              // keyboardType: TextInputType.phone,
              controller: cityController,
            ),
            SizedBox(height: _mediaQueryText * 0.03),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Adress Title',
                contentPadding: EdgeInsets.only(left: 20),
              ),
              onSubmitted: (_) => submitData(),
              // keyboardType: TextInputType.phone,
              controller: addressTitleController,
            ),
            SizedBox(height: _mediaQueryText * 0.03),
            ElevatedButton(
              onPressed: submitData,
              child: Text(
                'Add',
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
          ],
        ),
      ),
    );
  }
}

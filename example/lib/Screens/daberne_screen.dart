import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class DaberneScreen extends StatefulWidget {
  const DaberneScreen({Key? key}) : super(key: key);

  @override
  _DaberneScreenState createState() => _DaberneScreenState();
}

class _DaberneScreenState extends State<DaberneScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState!.validate()) {
        print('Validated');
        return true;
      } else {
        // ignore: avoid_print
        print('Not validated');
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      title: Text(
        'Date',
        style: Theme.of(context).textTheme.headline1,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
    );

    var screenHeight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight * 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'images/daberne.png',
                      height: screenHeight * 0.275,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Event Name',
                            labelStyle: Theme.of(context).textTheme.headline4,
                            contentPadding: const EdgeInsets.only(left: 20),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Required *'),
                          ]),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Number of guests',
                            labelStyle: Theme.of(context).textTheme.headline4,
                            contentPadding: const EdgeInsets.only(left: 20),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Required *'),
                          ]),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Event Date',
                            labelStyle: Theme.of(context).textTheme.headline4,
                            contentPadding: const EdgeInsets.only(left: 20),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Required *'),
                          ]),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Type of Event',
                            labelStyle: Theme.of(context).textTheme.headline4,
                            contentPadding: const EdgeInsets.only(left: 20),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Required *'),
                          ]),
                        ),
                        SizedBox(height: screenHeight * 0.0125),
                        ElevatedButton(
                          onPressed: () {
                            validate();
                          },
                          child: Text(
                            'Next',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.fromLTRB(
                                screenHeight * 0.18,
                                screenHeight * 0.02,
                                screenHeight * 0.18,
                                screenHeight * 0.02),
                            onPrimary: const Color.fromRGBO(255, 255, 255, 1),
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/widgets/Costumtextfield.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';

class FreindsTextField extends StatefulWidget {
  final Function addFriend;

  FreindsTextField(this.addFriend);

  @override
  State<FreindsTextField> createState() => _FreindsTextFieldState();
}

class _FreindsTextFieldState extends State<FreindsTextField> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState.validate()) {
        // ignore: avoid_print
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

  bool loading = false;
  var _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    FocusNode focusnode = FocusNode();
    final friends = Provider.of<FriendsProvider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);
    FocusNode focusNode = FocusNode();

    var _mediaQueryText = MediaQuery.of(context).size.height;
    return Card(
      key: _key,
      child: SingleChildScrollView(
        child: Container(
          color: LightColors.kLightYellow,
          child: Padding(
            padding: EdgeInsets.only(
                right: 10,
                left: 10,
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: _mediaQueryText * 0.06),
                  customTextField(
                    read: false,
                    label: '${LanguageTr.lg[authProvider.language]['Full Name']}',
                    controller: friends.namecontroller,
                  ),

                  //     SizedBox(height: _mediaQueryText * 0.02),
                  //      customTextField(read: false,label:'Email' ,controller:friends.emailcontroller ,),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: friends.emailcontroller,
                        focusNode: focusNode,
                      //  autovalidateMode: AutovalidateMode.onUserInteraction,

                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: mediaQuery.size.width * 0.04),
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                                fontSize: focusNode.hasFocus ? 18 : 16.0,
                                //I believe the size difference here is 6.0 to account padding
                                color: focusNode.hasFocus
                                    ? Color(0xFF3F5521)
                                    : Colors.grey),
                            labelText: '${LanguageTr.lg[authProvider.language]["Email"]}',
                            hintStyle: TextStyle(
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
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:  BorderSide(
                                  color: redColor,
                                )),
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
                      )),
                  Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: friends.phonecontroller,
                        focusNode: focusnode,
                        validator: (value){
                          if(value.isEmpty){

                            return  '${LanguageTr.lg[authProvider.language]["Please enter phone number"]}'
                              ;
                          }else return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide:  BorderSide(
                                  color: redColor,
                                )),
                            contentPadding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.04),
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                                fontSize: focusnode.hasFocus ? 18 : 16.0,
                                //I believe the size difference here is 6.0 to account padding
                                color: focusnode.hasFocus
                                    ? Color(0xFF3F5521)
                                    : Colors.grey),
                            labelText: '${LanguageTr.lg[authProvider.language]['Phone number']}'
                            ,
                            hintStyle: TextStyle(
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
                      )),
                  SizedBox(height: _mediaQueryText * 0.03),

                  SizedBox(height: _mediaQueryText * 0.03),
                  !loading
                      ? ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            if (formkey.currentState.validate() == false) {
                              // ignore: avoid_print
                              print('${LanguageTr.lg[authProvider.language]['Not Validated']}'
                                  );
                              setState(() {
                                loading = false;
                              });
                              // reset!=null?
                            } else {
                              if(await friends.createNewFriend()) {
                                setState(() {
                                  loading = false;
                                });

                                Navigator.of(context).pop();
                              }
                              else{
                                setState(() {
                                  loading = false;
                                });
                                showDialog(
                                  context: this.context,
                                  builder: (BuildContext
                                  context) {
                                    return AlertDialog(
                                      title:  Text('${LanguageTr.lg[authProvider.language]["error"]}'
                                          ),
                                      content:  Text('${LanguageTr.lg[authProvider.language]["friend already exists!"]}'
                                          ),
                                      actions: <Widget>[
                                        TextButton(
                                            child:
                                             Text('${LanguageTr.lg[authProvider.language]["Ok"]}'
                                                ),
                                            onPressed: () =>
                                                Navigator.pop(
                                                    context))
                                      ],
                                    );
                                  },
                                );
                              }

                            }
                          },
                          child: Text('${LanguageTr.lg[authProvider.language]['Add']}'
                            ,
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

bool isEmailValid(String email) {
  RegExp regex = new RegExp(
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");
  return regex.hasMatch(email);
}

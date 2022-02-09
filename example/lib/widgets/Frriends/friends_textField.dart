import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final friends = Provider.of<FriendsProvider>(context, listen: true);
    submitData() {
      final enteredfullName = friends.namecontroller.text;
      final enteredemail = friends.emailcontroller.text;
      final enteredphoneNumber = friends.phonecontroller.text;

      if (enteredfullName.isEmpty ||
          enteredemail.isEmpty && enteredphoneNumber.isEmpty) {
        return;
      }

      widget.addFriend(
        enteredfullName,
        enteredemail,
        enteredphoneNumber,
      );

      Navigator.of(context).pop();
    }

    var _mediaQueryText = MediaQuery
        .of(context)
        .size
        .height;
    return Card(
      child: SingleChildScrollView(
        child: Container(
          color: LightColors.kLightYellow,
          child: Padding(
            padding: EdgeInsets.only(
                right: 10,
                left: 10,
                top: 10,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom + 10),
            child: Form(
              key:formkey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: _mediaQueryText * 0.06),
                  TextFormField(

                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                    // onSubmitted: (_) => submitData(),
                    autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                    controller: friends.namecontroller,
                  ),
                  SizedBox(height: _mediaQueryText * 0.03),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                    autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                    // onSubmitted: (_) => submitData(),
                    keyboardType: TextInputType.emailAddress,
                    controller: friends.emailcontroller,
                  ),
                  SizedBox(height: _mediaQueryText * 0.03),
                  TextFormField(
                    controller: friends.phonecontroller,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                    // onSubmitted: (_) => submitData(),
                    autovalidateMode:
                    AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,

                  ),
                  SizedBox(height: _mediaQueryText * 0.03),
                  !loading ? ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      if (formkey.currentState.validate() == false) {
                        // ignore: avoid_print
                        print('Not Validated');
                        setState(() {
                          loading = false;
                        });
                        // reset!=null?
                      }
                      else
                        {

                        await friends.createNewFriend();

                          setState(() {
                            loading = false;

                          });

                        Navigator.of(context).pop();
                      }
                    },


                    child: Text(
                      'Add',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline1,
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
                      primary: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ):Center(child: CircularProgressIndicator(),),
                ],
              ),
            ),
          ),
        )
        ,
      )
      ,
    );
  }
}

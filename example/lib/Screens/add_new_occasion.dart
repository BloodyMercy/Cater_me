import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasion_added.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasions.dart';
import 'package:CaterMe/Screens/widgets/Costumtextfield.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/occasions/occasion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../custom_date_picker_form_field.dart';

class AddNewOccasion extends StatefulWidget {
  const AddNewOccasion({Key key}) : super(key: key);

  @override
  State<AddNewOccasion> createState() => _AddNewOccasionState();
}

class _AddNewOccasionState extends State<AddNewOccasion> {




  bool loading = true;
  getData() async {
    final occasion = Provider.of<OccasionProvider>(context, listen: false);
    await occasion.getAllOccasionType();
    await occasion.getallnewoccasion();

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  bool ispressed = false;
  final _scaff = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
   final occasion = Provider.of<OccasionProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);


    return SafeArea(
      child: Scaffold(
        key: _scaff,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(
              );
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            iconSize: 30,
          ),
          elevation: 0,

          centerTitle: true,
          title: Text(
            'Add An Occasion',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: !loading? SingleChildScrollView(
          child:

           Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: mediaQuery.size.height * 0.07),

                  customTextField(controller: occasion.nameofoccasioncontroller,label:'Name Of Occasion' ,),

                  CustomCupertinoPicker(
                          label: 'Type of Occasion',
                          items: occasion.listoccasiontypename,
                          listoccasiontype: occasion.listoccasiontype,
                          selectedValue: 0,
                          inputType: TextInputType.number,
                          controller: occasion.typeofoccasioncontrollername,
                        ),

                  customTextField(label:"Dd / mm / yyyy" ,controller:occasion.datechosencontroller ,read: true,),



                  SizedBox(
                    height: mediaQuery.size.height * 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !ispressed
                          ? ElevatedButton(
                              onPressed: () async {
                                if (occasion.datechosencontroller.text == "" ||
                                    occasion.typeofoccasioncontroller.text ==
                                        "" ||
                                    occasion.nameofoccasioncontroller.text ==
                                        "") {
                                  _scaff.currentState.showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("you cant add empty occasion"),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    ispressed = true;
                                  });

                                  bool a =
                                      await occasion.createOccasions(context);
                                  if (!a)
                                    {
                                      setState(() {
                                        ispressed=false;
                                      });
                                    _scaff.currentState.showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Please fill all the fields"),
                                      ),

                                    );  }
                                  else {
                                    occasion.cleardata();
                                    setState(() {
                                      ispressed = false;
                                    });
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const OccasionAdded(),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'ADD',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: (mediaQuery.size.width * 0.3),
                                  vertical: (mediaQuery.size.height * 0.02),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: Theme.of(context).primaryColor,
                              ),
                            )
                          : const Center(child: const CircularProgressIndicator()),
                    ],
                  )
                ],
              )),
        ): const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

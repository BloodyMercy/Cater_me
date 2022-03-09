import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Screens/ocassionsScreens/occasion_added.dart';
import 'package:CaterMe/Screens/widgets/Costumtextfield.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/user.dart';
import '../language/language.dart';

class AddNewOccasion extends StatefulWidget {
  int getposition =0 ;
   AddNewOccasion(this.getposition) ;

  @override
  State<AddNewOccasion> createState() => _AddNewOccasionState();
}

class _AddNewOccasionState extends State<AddNewOccasion> {




  bool loading = true;
  getData() async {
    final occasion = Provider.of<OccasionProvider>(context, listen: false);

    await occasion.getallnewoccasion();
await occasion.getAllOccasionType();
    occasion.typeofoccasioncontrollername.text=occasion.listoccasiontype[widget.getposition].name;
    occasion.typeofoccasioncontroller.text=occasion.listoccasiontype[widget.getposition].id.toString();

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
    final authProvider = Provider.of<UserProvider>(context, listen: true);
   final occasion = Provider.of<OccasionProvider>(context, listen: true);

    final mediaQuery = MediaQuery.of(context);
   FocusNode focusNode = FocusNode();

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
            '${LanguageTr.lg[authProvider.language]["Add an occasion"]}',
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextFormField(


                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'BerlinSansFB'),
                          decoration: InputDecoration(



                              contentPadding:
                              EdgeInsets.only(left: mediaQuery.size.width * 0.04),

                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                  fontSize: focusNode.hasFocus ? 18 : 16.0,//I believe the size difference here is 6.0 to account padding
                                  color:
                                  focusNode.hasFocus ? Color(0xFF3F5521) : Colors.grey),
                              labelText: '${LanguageTr.lg[authProvider.language][ "Name of Occasion"]}',
                              hintStyle:TextStyle(
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
                          controller:occasion.nameofoccasioncontroller,

                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text
                      ),
                    ),
                  ),
                  // customTextField(controller: occasion.nameofoccasioncontroller,label:'Name Of Occasion' ,),

                  CustomCupertinoPicker(
                          label: '${LanguageTr.lg[authProvider.language][ "Type of Occasion "]}',
                          items: occasion.listoccasiontypename,
                          listoccasiontype: occasion.listoccasiontype,
                          selectedValue: widget.getposition,
                          inputType: TextInputType.number,
                          controller: occasion.typeofoccasioncontrollername,
                        ),

                  customTextField(label:"Dd / mm / yyyy" ,
                    controller:occasion.datechosencontroller ,
                    read: true,),



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
                                    await occasion.getallnewoccasion();
                                    setState(() {
                                      ispressed = false;
                                    });
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => OccasionAdded(occasion.nameofoccasioncontroller.text.toString(),occasion.datechosencontroller.text.toString()),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                '${LanguageTr.lg[authProvider.language]["Add"]}',
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

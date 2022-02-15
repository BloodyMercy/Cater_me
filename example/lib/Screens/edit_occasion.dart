import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Screens/widgets/Costumtextfield.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditOccasion extends StatefulWidget {
  Occasion occ;

  EditOccasion(this.occ);

  @override
  State<EditOccasion> createState() => _EditOccasionState();
}

class _EditOccasionState extends State<EditOccasion> {
  final typeController = TextEditingController();
  final nameController = TextEditingController();
   DateTime selectedDate ;
  void _presentDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(DateTime.now().year + 1),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    OccasionProvider occasion = Provider.of<OccasionProvider>(context, listen: false);
    selectedDate = DateTime.parse(widget.occ.date);
    occasion.nameofoccasioncontroller.text=widget.occ.name;
    occasion.datechosencontroller.text=widget.occ.date.substring(0,10);
    occasion.typeofoccasioncontrollername.text=widget.occ.type;
    for(int i=0;i<occasion.listoccasiontype.length;i++){
if(occasion.listoccasiontype[i].name==    occasion.typeofoccasioncontrollername.text)
      occasion.typeofoccasioncontroller.text=occasion.listoccasiontype[i].id.toString();


    }
  //  occasion.typeofoccasioncontroller.text=widget.occ.type;


}
  // late bool yearly;
  //
  //
  // @override
  // void initState() {
  //   yearly = widget.occ.yearly;
  // }
  final _scaff = GlobalKey<ScaffoldState>();
bool loading=false;
bool ispressed = false;
  @override
  Widget build(BuildContext context) {
    //List<Occasion> occasion = occasionSS;
    final mediaQuery = MediaQuery.of(context);
    OccasionProvider occasion = Provider.of<OccasionProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
  key:_scaff,
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
            'Edit Occasion',
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
                              occasion.typeofoccasioncontrollername.text ==
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
                            await occasion.updateoccation(idss: widget.occ.id);
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
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        child: Text(
                          'Update',
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

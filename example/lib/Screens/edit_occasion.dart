import 'package:CaterMe/Screens/ocassionsScreens/occasions.dart';
import 'package:CaterMe/model/occasion.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditOccasion extends StatefulWidget {
  Occasion occ;

  EditOccasion(this.occ);

  @override
  State<EditOccasion> createState() => _EditOccasionState();
}

class _EditOccasionState extends State<EditOccasion> {
  final typeController = TextEditingController();
  final nameController = TextEditingController();
  late DateTime? selectedDate = DateTime.parse(widget.occ.date);
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

  // late bool yearly;
  //
  //
  // @override
  // void initState() {
  //   yearly = widget.occ.yearly;
  // }

  @override
  Widget build(BuildContext context) {
    //List<Occasion> occasion = occasionSS;
    final mediaQuery = MediaQuery.of(context);


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(
              );
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
            iconSize: 30,
          ),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          centerTitle: true,
          title: Text(
            'Edit Occasion',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: mediaQuery.size.height * 0.07),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: widget.occ.name,
                  labelText: 'Name Of Occasion',
                  labelStyle: Theme.of(context).textTheme.headline4,
                  contentPadding: EdgeInsets.only(left: 20),
                ),
              ),
              SizedBox(height: mediaQuery.size.height * 0.04),
              TextFormField(
                controller: typeController,
                decoration: InputDecoration(
                  hintText: widget.occ.type,
                  labelText: 'Type of Occasion',
                  labelStyle: Theme.of(context).textTheme.headline4,
                  contentPadding: EdgeInsets.only(left: 20),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: mediaQuery.size.height * 0.04),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(selectedDate == null
                        ? "No Date chosen!"
                        : 'Picked date: ${DateFormat.yMd().format(selectedDate!)}'),
                    TextButton(
                      onPressed: _presentDataPicker,
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //   Text(
              //     "Yearly reminder",
              //     style: Theme.of(context).textTheme.headline2,
              //   ),
                // Switch.adaptive(
                //   activeColor: Theme.of(context).primaryColor,
                //   value: yearly,
                //   onChanged: (val) {
                //     setState(() {
                //       yearly = val;
                //     });
                //   },
                // ),
             // ]),
              SizedBox(
                height: mediaQuery.size.height * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.occ.name = nameController.text.toString();
                      widget.occ.type = typeController.text.toString();
                      //widget.occ.yearly = yearly;
                      widget.occ.date = selectedDate.toString();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Ocasions(),
                        ),
                      );
                    },
                      child: Text(
                      'SAVE',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                        left: 130,
                        right: 130,
                        top: 20,
                        bottom: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}

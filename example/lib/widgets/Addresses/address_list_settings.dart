import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class AddressesListSettings extends StatefulWidget {
  final List<Address> address;
  Function deleteAddress;

  AddressesListSettings(this.address, this.deleteAddress);

  @override
  State<AddressesListSettings> createState() => _AddressesListSettingsState();
}

class _AddressesListSettingsState extends State<AddressesListSettings> {
  int _value = -1;

  @override
  Widget build(BuildContext context) {
    final orderprovider =
    Provider.of<OrderCaterProvider>(context, listen: true);
    final address=Provider.of<AdressProvider>(context,listen: true);
    var _mediaQueryWidth = MediaQuery.of(context).size.width;
    var _mediaQuery = MediaQuery.of(context).size.height;
    return Container(
      height: _mediaQuery * 0.65,
      child: widget.address.isEmpty
          ? Center(
          child: Container(
            child: Image.asset('images/no addresses yet-01.png'),
          ))
          : ListView.builder(
          itemCount: widget.address.length,
          itemBuilder: (ctx, index) {
            return Slidable(

              key: UniqueKey(),
              endActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),

                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () async{
               var delete= await  address.deleteAddress(widget.address[index].id);
               if(delete=="deleted"){
                 print("done 1");
                 widget.address.remove(widget.address[index]);
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                   content: Text('Address Deleted'),
                 ));


               }else{
                 print("not done");
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                   content: Text('Address cannot be Deleted'),
                 ));
               }
                }),

                // All actions are defined in the children parameter.
                children:  [
                  IconButton(onPressed: () async{
                    var delete= await  address.deleteAddress(widget.address[index].id);
                    if(delete=="deleted"){
                      print("done 1");
                      widget.address.remove(widget.address[index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Address Deleted'),
                      ));


                    }else{
                      print("not done");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Address cannot be Deleted'),
                      ));
                    }
                  }, icon:Icon(Icons.delete) ),
                  SlidableAction(
                    onPressed: delete,
                    backgroundColor: Color(0xFF3F5521),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  // A SlidableAction can have an icon and/or a label.
                  SlidableAction(
                    onPressed: delete,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),

                ],
              ),

              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: _mediaQuery * 0.03,
                      horizontal: _mediaQuery * 0.01),
                  child: Row(
                    children: [
                      SizedBox(
                        width: _mediaQueryWidth*0.01,
                      ),
                      // Radio(
                      //   toggleable: true,
                      //   groupValue: address.valueIndex,
                      //
                      //   // groupValue: widget.address.length,
                      //   value: index,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _value = index;
                      //       address.valueIndex = index;
                      //     });
                      //     // orderprovider.value = widget.address[index];
                      //   },
                      // ),SizedBox(
                      //   width: _mediaQueryWidth*0.01,
                      // ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title : ${widget.address[index].title.toString()}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),

                          Text(
                            "City : ${widget.address[index].city.toString()}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),

                          Text(
                            "Street : ${widget.address[index].street.toString()}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),

                          Text(
                            "Building Name : ${widget.address[index].buildingName.toString()}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),

                          Text(
                            "Floor Number : ${widget.address[index].floorNumber.toString()}",
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
void delete(BuildContext context) async{
  final address=Provider.of<AdressProvider>(context,listen: false);
  print("Delete");
}

void share(BuildContext context) {
  print("share");
}
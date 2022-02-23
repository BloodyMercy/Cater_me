import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class ListViewOrderDriver extends StatefulWidget {
  const ListViewOrderDriver({Key key}) : super(key: key);

  @override
  _ListViewOrderDriverState createState() => _ListViewOrderDriverState();
}

class _ListViewOrderDriverState extends State<ListViewOrderDriver> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context,index){
        return   GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (builder) =>
            //         OrderId(orders.listOrder[index].id, 0),
            //   ),
            // );
          },
          child: Card(
              elevation: 5,
              color: LightColors.kLightYellow2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Event Name",
                            // orders.listOrder[index].eventName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        Text("Order Status",
                          // orders.listOrder[index].orderStatus,
                          style: TextStyle(
                            // color:
                            // _getColorByEvent(orders
                            //     .listOrder[index]
                            //     .orderStatus.toString()),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "23-02-2022",
                      // "${DateFormat("dd-MM-yyyy").format(DateTime.parse(orders.listOrder[index].eventDate))}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      // "Address: ${orders.listOrder[index].addressTitle}",
                      "Address: KSA",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              )),
        );
      },
    );


  }
}

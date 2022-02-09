import 'package:flutter/material.dart';

class YourOrders extends StatefulWidget {
  const YourOrders({Key key}) : super(key: key);

  @override
  State<YourOrders> createState() => _YourOrdersState();
}

class _YourOrdersState extends State<YourOrders> {
  String cityselect;
  List<String> listOrders = [
    "Catering nb1",
    "Catering nb2",
    "Catering nb3",
    "Catering nb4",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: const Color(0xff3F5521),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: DropdownButton(
                underline: const SizedBox(),
                focusColor: Colors.white,
                hint: const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Order #5678",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'BerlinSansFB'),
                  ),
                ),
                dropdownColor: Colors.white,
                iconSize: 36,
                isExpanded: true,
                style: const TextStyle(color: Colors.black54, fontSize: 15),
                // value: cityChoose,
                onChanged: (newValue) {
                  setState(() {
                    cityselect = newValue.toString();
                  });
                },
                items: listOrders.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(valueItem),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

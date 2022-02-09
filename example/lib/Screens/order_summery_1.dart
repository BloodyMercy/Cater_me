import 'package:CaterMe/Providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSummery1 extends StatefulWidget {
  const OrderSummery1({Key key}) : super(key: key);

  @override
  _OrderSummery1State createState() => _OrderSummery1State();
}

class _OrderSummery1State extends State<OrderSummery1> {
  Future<bool> _onWillPop() async {
    //UserProvider _user=Provider.of<UserProvider>(context,listen:true);

    return (await showDialog(
            context: context,
            builder: (context) => setupAlertDialoadContainer(context))) ??
        false;
  }

  // Widget setupAlertDialoadContainer() {
  //   return new Scaffold(
  //     body: new Container(
  //     height: 300.0, // Change as per your requirement
  //     width: 300.0, // Change as per your requirement
  //     child: new ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: 5,
  //       itemBuilder: (BuildContext context, int index) {
  //         return new ListTile(
  //           title: Text('Gujarat, India'),
  //         );
  //       },
  //     ),
  //   ));
  // }
  List<bool> _isChecked = List<bool>.filled(15, false);

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(15, false);
  }

  Widget setupAlertDialoadContainer(context) {
    // final details=Provider.of<OrderCaterProvider>(context,listen: true);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.white,
            height: 400.0, // Change as per your requirement
            width: 400.0, // Change as per your requirement
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  activeColor: Theme.of(context).primaryColor,
                  value: _isChecked[index],
                  onChanged: (val) {
                    setState(() {
                      setState(() {
                        _isChecked[index] = val;
                      });
                    });
                  },
                  title: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          child: ClipRRect(
                            child: Image.network(
                                'https://static.wikia.nocookie.net/youtube/images/9/9c/Hecker.jpg/revision/latest/top-crop/width/360/height/360?cb=20211024200708'),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        Text('List Item $index'),
                      ],
                    ),
                  )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isSearch = false;

  int count = 3;
  String item_name = "Name";
  double Price = 20;
  double total = 0;
  double sub_total = 0;
  int tax = 0;
  double price = 20;

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    // List<ItemOrders> itemorder = [];
    final mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: mediaQuery.size.height * 0.3,
                child: ListView.builder(
                  itemCount: details.itemOrders.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaQuery.size.width * 0.05),
                      child: Card(
                        elevation: 3,
                        color: Color.fromRGBO(219, 226, 237, 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: mediaQuery.size.width * 0.03,
                                ),
                                Text(
                                  details.itemOrders[i].quantity.toString(),
                                  style: TextStyle(fontFamily: 'BerlinSansFB'),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        count--;
                                        // if(count==0){
                                        //   price=0;
                                        // }
                                        // else{
                                        price = Price * count;
                                        // }
                                      });
                                    },
                                    icon: Icon(Icons.minimize)),
                                Text(
                                  details.itemOrders[i].title,
                                  style: TextStyle(fontFamily: 'BerlinSansFB'),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      count++;
                                      // if(count==0){
                                      //   price=0;
                                      // }
                                      //else{
                                      price = Price * count;
                                      // }
                                    });
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${details.itemOrders[i].totalprice} SAR",
                                  style: TextStyle(fontFamily: 'BerlinSansFB'),
                                ),
                                SizedBox(
                                  width: mediaQuery.size.width * 0.03,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaQuery.size.width * 0.03),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub-total",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontFamily: 'BerlinSansFB'),
                        ),
                        Text(
                          "${details.subTotal.toString()} SAR",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontFamily: 'BerlinSansFB'),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontFamily: 'BerlinSansFB'),
                        ),
                        Text(
                          "${details.tax.toString()} %",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontFamily: 'BerlinSansFB'),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontFamily: 'BerlinSansFB'),
                        ),
                        Text(
                          "${details.totale.toString()}SAR",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontFamily: 'BerlinSansFB'),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.02,//thid one
              ),
              ElevatedButton(
                onPressed: () {
                  // return  await showDialog(
                  //   context: context,
                  //   builder: (context) =>
                  //       setupAlertDialoadContainer()
                  // );
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: SingleChildScrollView(
                            child: Container(
                                child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.check,
                                          color: Theme.of(context).primaryColor,
                                        ))
                                  ],
                                ),
                                Text(
                                  'Choose the friends you want to share the order with.',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontFamily: 'BerlinSansFB'),
                                ),
                                SizedBox(
                                  height: mediaQuery.size.height * 0.02,
                                ),
                                SizedBox(
                                  height: mediaQuery.size.height * 0.06,
                                  child: TextField(
                                    autofocus: false,
                                    onTap: () {
                                      setState(() {
                                        isSearch = true;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  232, 232, 232, 1)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      filled: true,
                                      fillColor: const Color.fromRGBO(
                                          232, 232, 232, 1),
                                      hintText: 'Search',
                                      prefixIcon: const Icon(Icons.search),
                                      prefixIconColor: Colors.black,
                                      hintStyle: TextStyle(
                                          color: Colors.grey[850],
                                          fontSize: 16,
                                          fontFamily: 'BerlinSansFB'),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          content: setupAlertDialoadContainer(context),
                        );
                      });
                },
                child: const Text(
                  "Share Bill",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BerlinSansFB'),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: (mediaQuery.size.width * 0.13),
                    vertical: (mediaQuery.size.height * 0.01),
                  ),
                  primary: Theme.of(context).primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'widgets/payment_bottomsheet.dart';

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

enum CardType { Paypal, PaybyCard }

class _PaymentsState extends State<Payments> {
  CardType _character = CardType.Paypal;
  TextEditingController CNumberController = new TextEditingController();
  TextEditingController CHolderController = new TextEditingController();
  TextEditingController EDateController = new TextEditingController();
  TextEditingController CCVCodeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // UserProvider _user = Provider.of<UserProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: Color(0xff313444),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "Payment",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 19),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                icon:Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet<dynamic>(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => DraggableScrollableSheet(
                      builder: (context, scrollController) =>
                          SingleChildScrollView(
                        controller: scrollController,
                        child: PaymentBottomSheet(),
                      ),
                    ),
                  );
                }),
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Stack(
                        children: [
                          Image.asset('assets/images/Card.png'),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Image.asset('assets/icons/check_id.png'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Stack(
                        children: [
                          Image.asset('assets/images/Card.png'),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8),
                            child: Image.asset('assets/icons/check_id.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                   'Transaction history',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Container(
              width: width,
              height: height / 15,
              color: Color.fromRGBO(59, 63, 82, 1),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                child: Text(
                  'AUG 18,2021',
                  style: TextStyle(
                    color: Color.fromRGBO(159, 172, 189, 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ClipOval()
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: " "+"\n",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                          text: " ",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Container(
              width: width,
              height: height / 15,
              color: Color.fromRGBO(59, 63, 82, 1),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                child: Text(
                  'AUG 07,2021',
                  style: TextStyle(
                    color: Color.fromRGBO(159, 172, 189, 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height / 50,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ClipOval(
                    // child:
                    // Image.asset(
                    //   fit: BoxFit.cover,
                    //   width: 50,
                    //   height: 50,
                    // ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        // text: " " + transaction.salonname + "\n",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                          // text: " " + transaction.time,
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "",// transactiondata.price,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TextFormField _customfield(
    TextEditingController controller, String hint, IconData icon) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Color(0xff00A9A5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
        ),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(20.0),
          borderSide: new BorderSide(),
        ),
        hintText: hint,
        hintStyle: TextStyle(fontSize: 12.0, color: Colors.black),
        suffixIcon: Icon(
          icon,
          color: Color(0xff8792A4),
          size: 20,
        )),
    style: TextStyle(
      fontSize: 15,
      color: Colors.black,
    ),
    validator: (value) {
      if (value == null) {
        return 'Please Enter $hint';
      }
      return null;
    },
  );
}

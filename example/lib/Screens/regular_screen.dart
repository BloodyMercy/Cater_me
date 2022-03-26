import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Screens/widgets/custom_cupertino_picker.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/widgets/custom_daily_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/user.dart';
import '../custom_date_picker_form_field.dart';
import '../language/language.dart';
import 'occasion/theme/colors/light_colors.dart';

class ReguarScreen extends StatefulWidget {
  ReguarScreen(List<FriendModel> friends);

  // final List<FriendModel> Friends;
  //  ReguarScreen(this.Friends);

  @override
  _ReguarScreenState createState() => _ReguarScreenState();
}

class _ReguarScreenState extends State<ReguarScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState.validate()) {
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

  DateTime _selectedDay = DateTime.utc(2000, 10, 16);

  getData() async {
    final address = Provider.of<AdressProvider>(context, listen: false);
    SharedPreferences sh=await SharedPreferences.getInstance();
    await address.getRegular(sh.getString("locale"));
    final occasion = Provider.of<FriendsProvider>(context, listen: false);
    if (occasion.listFriends.length == 0) await occasion.getAllFriends();
    List<String> l = [];
    for (int i = 0; i < occasion.listFriends.length; i++) {
      l.add(occasion.listFriends[i].name);
    }
    setState(() {
      listFriendssearch = l;
    });
    // controllersearch.text="p";
    setState(() {
      loading = false;
     //_value= address.value2Index;
    });
    if(address.value2Index==1)
      _value=address.value2Index;

  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  int _value = 0;
  bool loading = true;

  List<String> listFriendssearch = [];

  Future<bool> _onWillPop() async {
    final frnd = Provider.of<FriendsProvider>(context, listen: true);

    return (await showDialog(
            context: context,
            builder: (context) =>
                setupAlertDialoadContainer(context, frnd.listFriends))) ??
        false;
  }

  TextEditingController controllersearch = TextEditingController();

  Widget setupAlertDialoadContainer(context, List<FriendModel> l) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final frnd = Provider.of<FriendsProvider>(context, listen: true);
    final details = Provider.of<OrderCaterProvider>(context, listen: true);
    return SingleChildScrollView(
      child: Container(
        // color: LightColors.kLightYellow2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // color: Colors.white,
              height: 400.0, // Change as per your requirement
              width: 400.0, // Change as per your requirement
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: frnd.listFriends.length,
                itemBuilder: (BuildContext context, int index) {
                  return listFriendssearch[index]
                          .contains(controllersearch.text.toLowerCase())
                      ? CheckboxListTile(
                          activeColor: Theme.of(context).primaryColor,
                          value: details.choosebillFriend
                              .contains(frnd.listFriends[index]),
                          onChanged: (val) {
                            if (val == true)
                              details.addfriend(frnd.listFriends[index]);
                            else
                              details.removefriend(frnd.listFriends[index]);
                          },
                          title: Card(
                            color: LightColors.kLightYellow2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 25.0,
                                    child: ClipRRect(
                                      child: Image.network(l[index].image),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  Text(l[index].name),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    final address = Provider.of<AdressProvider>(context, listen: true);
    var screenHeight = MediaQuery.of(context).size.height;
    FocusNode focusNode = FocusNode();
    return address.load
        ? GestureDetector(  behavior: HitTestBehavior.translucent,
      onTap: (){
        FocusScopeNode currentfocus = FocusScope.of(context);
        if(!currentfocus.hasPrimaryFocus){
          currentfocus.unfocus();
        }
      },
          child: SingleChildScrollView(
              child: Container(
                color: LightColors.kLightYellow,
                height: screenHeight * 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'BerlinSansFB'),
                                  decoration: InputDecoration(

                                      alignLabelWithHint: true,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              focusNode.hasFocus ? 18 : 16.0,
                                          //I believe the size difference here is 6.0 to account padding
                                          color: focusNode.hasFocus
                                              ? Color(0xFF3F5521)
                                              : Colors.grey),
                                      labelText: '${LanguageTr.lg[authProvider.language]["Event Description"]}',

                                      hintStyle: TextStyle(
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
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF3F5521),
                                          ))),
                                  controller: address.eventnamecontroller,
 keyboardType: TextInputType.text),
                            ),
                            // customTextField(label: 'Event Name' ,read: false,controller: address.eventnamecontroller,)



                            Container(
                              height: MediaQuery.of(context).size.height / 12,
                              // child: CustomDatePickerFormField(
                              //   label: '${LanguageTr.lg[authProvider.language]["Event Date"]}',
                              //   controller: address.evendatecontroller,
                              // ),
                              child: CustomDatePickerFormField(
                                casee: "order",
                                label: '${LanguageTr.lg[authProvider.language]["Event Date"]}',
                                controller: address.evendatecontroller,
                                controllerlan: address.evendatelancontroller,
                                lang:authProvider.language
                              ),
                            ),



                            Container(
                              height: MediaQuery.of(context).size.height / 12,
                              child: CustomDailyDate(
                                label: '${LanguageTr.lg[authProvider.language]["Event Time "]}',
                                controller: address.DailyDatecontroller,
                                controllerlan: address.DailyDatelancontroller,
                                lang:authProvider.language
                              ),
                            ),

                            Container(height: MediaQuery.of(context).size.height / 12,
                              child: CustomCupertinoPicker(
                                label:'${LanguageTr.lg[authProvider.language]["Number Of Guests"]}',


                                items: address.listnamenumber,
                                numberOfGuests: address.regular.numberOfGuests,
                                selectedValue: 1,
                                inputType: TextInputType.number,
                                controller: address.numberofguestcontrollerstring,
                              ),
                            ),



                            // Container(height: MediaQuery.of(context).size.height / 12,
                            //   child: CustomCupertinoPicker(
                            //     label:
                            //     '${LanguageTr.lg[authProvider.language]["Type Of Event"]}',
                            //     items: address.listnameevent,
                            //
                            //     events: address.regular.events,
                            //     selectedValue: 0,
                            //     inputType: TextInputType.number,
                            //     controller: address.typeofeventcontrollerstring,
                            //   ),
                            // ),

                            SizedBox(height: screenHeight * 0.01),
                            Center(
                              child: Text(
                                '${LanguageTr.lg[authProvider.language]["Contact Person"]}',
                                style: TextStyle(
                                    color: Color(0xFF3F5521),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  toggleable: true,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => colorCustom),
                                  // value: 'female',
                                  value: 0,

                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      address.form = false;
                                      _value=value;
                                      address.value2Index = value;
                                    });
                                  },
                                ),
                                Text('${LanguageTr.lg[authProvider.language]["Me"]}',),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 12,
                                ),
                                Radio(
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => colorCustom),
                                  toggleable: true,
                                  // value: 'female',
                                  value: 1,
                                  groupValue: _value,
                                  onChanged: (value) {
                                   // print(value);
                                    setState(() {
                                      address.form = true;
                                      _value=value;
                                      address.value2Index = value;
                                    });
                                  },
                                ),
                                Text('${LanguageTr.lg[authProvider.language]["Others"]}',),
                              ],
                            ),

                            address.form
                                ?       Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'BerlinSansFB'),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                      alignLabelWithHint: true,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                          focusNode.hasFocus ? 18 : 16.0,
                                          //I believe the size difference here is 6.0 to account padding
                                          color: focusNode.hasFocus
                                              ? Color(0xFF3F5521)
                                              : Colors.grey),
                                      labelText: '${LanguageTr.lg[authProvider.language]["Name"]}',
                                      hintStyle: TextStyle(
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
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF3F5521),
                                          ))),
                                  controller: address.name,

                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.text),
                            )
                                : Container(),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                            address.form
                                ?       Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'BerlinSansFB'),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                      alignLabelWithHint: true,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                          focusNode.hasFocus ? 18 : 16.0,
                                          //I believe the size difference here is 6.0 to account padding
                                          color: focusNode.hasFocus
                                              ? Color(0xFF3F5521)
                                              : Colors.grey),
                                      labelText: '${LanguageTr.lg[authProvider.language][ "Phone number"]}',
                                      hintStyle: TextStyle(
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
                                          borderRadius:
                                          BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF3F5521),
                                          ))),
                                  controller: address.phone,

                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.phone),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

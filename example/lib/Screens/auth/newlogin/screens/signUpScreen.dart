// import 'dart:io';
//
// import 'package:CaterMe/Providers/user.dart';
// import 'package:CaterMe/Screens/auth/newlogin/widgets/inputTextWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
//
// import '../../../greeting.dart';
// import 'loginScreen.dart';
//
// class SignUpScreen extends StatefulWidget {
//   SignUpScreen() : super();
//
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   File image;
//   // ignore: non_constant_identifier_names
//   Future PickImage(ImageSource source) async {
//     try {
//       final image = await ImagePicker().pickImage(source: source);
//       if (image == null) return;
//       final imageTemporary = File(image.path);
//       setState(() {
//         this.image = imageTemporary;
//       });
//       // ignore: nullable_type_in_catch_clause
//     } on PlatformException catch (e) {
//       print('Failed : $e');
//     }
//   }
//
//
//   String password = '',
//       mobile = '',
//       confirmPassword = '',
//       email = '',
//       name = '';
//   bool passObscure = true;
//   bool confObscure = true;
//
//
//   String genderChoose;
//   List<Map<String, dynamic>> listGender = [
//     {"id": 1, "gender": "male"},
//     {"id": 2, "gender": "female"},
//   ];
//   DateTime selectedDate = DateTime.now();
//   DateTime _newDate;
//   _datePicker() async {
//     _newDate = (await showDatePicker(
//       context: context,
//       builder: (context, child) => Theme(
//           data: ThemeData().copyWith(
//             colorScheme: ColorScheme.light(
//                 primary: Color(0xff3F5521),
//                 surface: Color(0xff3F5521),
//                 onPrimary: Colors.black),
//           ),
//           child: child),
//       initialDate: selectedDate,
//       firstDate: DateTime(1930),
//       lastDate: DateTime.now(),
//       initialEntryMode: DatePickerEntryMode.calendarOnly,
//     ));
//     setState(() {
//       if (_newDate != null) {
//         selectedDate = _newDate;
//
//       }
//     });
//   }
//   final signkey = GlobalKey<ScaffoldState>();
//   bool loading =false;
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<UserProvider>(context);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       key: signkey,
//       appBar: AppBar(
//         title: Text("Register",
//             style: TextStyle(
//               color:Color(0xFF3F5521),
//               fontFamily: 'Segoe UI',
//               fontSize: 30,
//               shadows: [
//                 Shadow(
//                   color: const Color(0xba000000),
//                   offset: Offset(0, 3),
//                   blurRadius: 6,
//                 )
//               ],
//             )),
//         //centerTitle: true,
//         leading: InkWell(
//           // onTap: () => Get.to(LoginScreen()),
//           child: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 15.0),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//             color: Colors.white,
//
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: Offset(0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//           width: screenWidth,
//           height: screenHeight,
//           child: SingleChildScrollView(
//             //controller: controller,
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//
//
//                   GestureDetector(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 0.0),
//                       child: Center(
//                         child: CircleAvatar(
//                           minRadius: 16,
//                           maxRadius: screenHeight * 0.07,
//                           backgroundImage: image == null ? null : FileImage(image),
//                           child: image == null
//                               ? Image(
//                             image: const AssetImage('images/profile.png'),
//                             // width: 800,
//                             height: screenHeight * 0.15,
//                           )
//                               : Container(),
//                         ),
//                       ),
//                     ),
//                     onTap: () {
//                       showModalBottomSheet(
//                           shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(20),
//                                   topRight: Radius.circular(20))),
//                           context: context,
//                           builder: (context) {
//                             return Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 ListTile(
//                                   leading: const Icon(
//                                     Icons.camera,
//                                     color: Color.fromRGBO(63, 85, 33, 1),
//                                   ),
//                                   title: const Text(
//                                     'Camera',
//                                     style: TextStyle(
//                                       fontFamily: 'BerlinSansFB',
//                                       fontSize: 16,
//                                       color: Color.fromRGBO(63, 85, 33, 1),
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     PickImage(ImageSource.camera);
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                                 ListTile(
//                                   leading: const Icon(
//                                     Icons.image,
//                                     color: Color.fromRGBO(63, 85, 33, 1),
//                                   ),
//                                   title: const Text(
//                                     'Gallery',
//                                     style: TextStyle(
//                                       fontFamily: 'BerlinSansFB',
//                                       fontSize: 16,
//                                       color: Color.fromRGBO(63, 85, 33, 1),
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     PickImage(ImageSource.gallery);
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                               ],
//                             );
//                           });
//                     },
//                   ),
//
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   InputTextWidget(
//                       labelText: "Name",
//                       icon: Icons.person,
//                        controller: authProvider.name,
//                       obscureText: false,
//                       keyboardType: TextInputType.text),
//                   SizedBox(
//                     height: 12.0,
//                   ),
//
//
//                   InputTextWidget(
//                       controller: authProvider.email,
//                       labelText: "Email",
//                       icon: Icons.email,
//                       obscureText: false,
//                       keyboardType: TextInputType.emailAddress),
//                   SizedBox(
//                     height: 12.0,
//                   ),
//                   InputTextWidget(
//                       labelText: "Phone number",
//                       icon: Icons.phone,
//                       obscureText: false,
//                       controller: authProvider.phoneNumber,
//                       keyboardType: TextInputType.number),
//                   SizedBox(
//                     height: 12.0,
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//                     child: Container(
//                       child: Material(
//                         elevation: 15.0,
//                         shadowColor: Colors.black,
//                         borderRadius: BorderRadius.circular(15.0),
//                         child: Padding(
//                           padding:
//                               const EdgeInsets.only(right: 20.0, left: 15.0),
//                           child: TextFormField(
//                               obscureText: true,
//                               autofocus: false,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 icon: Icon(
//                                   Icons.lock,
//                                   color: Colors.black,
//                                   size: 32.0, /*Color(0xff224597)*/
//                                 ),
//                                 labelText: "Password",
//                                 labelStyle: TextStyle(
//                                     color: Colors.black54, fontSize: 18.0),
//                                 hintText: '',
//                                 enabledBorder: InputBorder.none,
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black54),
//                                 ),
//                                 border: InputBorder.none,
//                               ),
//                               controller: authProvider.password,
//                               validator: (val) {
//                                 if (val.isEmpty) {
//                                   return 'Required ';
//                                 } else if (val.length < 6) {
//                                   return 'mot de passe doit etre > 6 caractère';
//                                 }
//
//                                 return null;
//                               }),
//
//
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//                     child: Container(
//                       child: Material(
//                         elevation: 15.0,
//                         shadowColor: Colors.black,
//                         borderRadius: BorderRadius.circular(15.0),
//                         child: Padding(
//                           padding:
//                               const EdgeInsets.only(right: 20.0, left: 15.0),
//                           child: TextFormField(
//                               obscureText: true,
//                               autofocus: false,
//                               keyboardType: TextInputType.text,
//                               decoration: InputDecoration(
//                                 icon: Icon(
//                                   Icons.lock,
//                                   color: Colors.black,
//                                   size: 32.0, /*Color(0xff224597)*/
//                                 ),
//                                 labelText: "Comfirm Password",
//                                 labelStyle: TextStyle(
//                                     color: Colors.black54, fontSize: 18.0),
//                                 hintText: '',
//                                 enabledBorder: InputBorder.none,
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black54),
//                                 ),
//                                 border: InputBorder.none,
//                               ),
//                               controller: authProvider.confirmpassword,
//                               validator: (val) {
//                                 if (val.isEmpty)
//                                   return 'Confirm Password';
//                                 if (val != authProvider.password.text)
//                                   return 'Mot de passe incorrect';
//                                 return null;
//                               }),
//                         ),
//                       ),
//                     ),
//                   ),
//
//
//                   Padding(
//                     padding: const EdgeInsets.only(left: 32),
//                     child: Row(
//                       children: [
//                         Text(selectedDate == null
//                             ? "No Date chosen!"
//                             : 'Picked date: ${DateFormat.yMd().format(selectedDate)}'),
//                         IconButton(
//                           onPressed: ()async{
//
//                             _newDate = (await showDatePicker(
//                               context: context,
//                               builder: (context, child) => Theme(
//                                   data: ThemeData().copyWith(
//                                     colorScheme: ColorScheme.light(
//                                         primary: Color(0xff3F5521),
//                                         surface: Color(0xff3F5521),
//                                         onPrimary: Colors.black),
//                                   ),
//                                   child: child),
//                               initialDate: selectedDate,
//                               firstDate: DateTime(1930),
//                               lastDate: DateTime.now(),
//                               initialEntryMode: DatePickerEntryMode.calendarOnly,
//                             ));
//
//                             setState(() {
//                               if (_newDate != null) {
//                                 selectedDate = _newDate;
//                                 authProvider.birthday.text=_newDate.toString() ;
//
//                               }
//                             });
//                           },
//
//                           icon: Icon(
//                             Icons.date_range,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.0,
//                   ),
//                   Container(
//                     height: 55.0,
//                     child:!loading? ElevatedButton(
//                       onPressed: () async {
//                         setState(() {
//                           loading = true;
//                         });
//
//                         if (_formKey.currentState.validate() == false) {
//                           // ignore: avoid_print
//                           print('Not Validated');
//                           setState(() {
//                             loading = false;
//                           });
//                           // reset!=null?
//                         } else {
//                           if (await authProvider.signUp(image,DateFormat.yMd().format(selectedDate).toString())) {
//                         setState(() {
//                         loading = false;
//                         });
//                         Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                         builder: (context) => Greeting(),
//                         ),
//                         );
//                         } else {
//                         setState(() {
//                         loading = false;
//                         });
//                         signkey.currentState.showSnackBar(
//                         SnackBar(
//                         content: Text(
//                         "${authProvider.messageSignUp.toString()}"),
//                         ),
//                         );
//                         authProvider.messageSignUp = "";
//                         }
//                       }
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) =>
//                         //         Greeting()));
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.white,
//                         elevation: 0.0,
//                         minimumSize: Size(screenWidth, 150),
//                         padding: EdgeInsets.symmetric(horizontal: 30),
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(0)),
//                         ),
//                       ),
//                       child: Ink(
//                         decoration: BoxDecoration(
//                             boxShadow: <BoxShadow>[
//                               BoxShadow(
//                                   color: Color(0xFF3F5521),
//                                   offset: const Offset(1.1, 1.1),
//                                   blurRadius: 10.0),
//                             ],
//                             color: Color(0xFF3F5521),
//                             borderRadius: BorderRadius.circular(12.0)),
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Register",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: Colors.white, fontSize: 25),
//                           ),
//                         ),
//                       ),
//                     ):Center(child: CircularProgressIndicator())
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

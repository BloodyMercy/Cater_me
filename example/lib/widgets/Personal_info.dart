import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:CaterMe/Providers/personal_info_provider.dart';
import 'package:CaterMe/Providers/user.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  void initState() {
    getData();
    super.initState();
  }
  bool loading = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  getData() async{
    final personalInfo= await Provider.of<PersonalInfoProvider>(context,listen: false);
    await personalInfo.getPersonalInfo();
    setState(() {
      loading=false;
    });

  }
  bool validate() {
    if (formkey.currentState != null) {
      if (formkey.currentState!.validate()) {
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

  DateTime selectedDate = DateTime.now();
  late DateTime? _newDate;
  _datePicker() async {
    _newDate = (await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.light(
                primary: Color(0xff3F5521),
                surface: Color(0xff3F5521),
                onPrimary: Colors.black),
          ),
          child: child!),
      initialDate: selectedDate,
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    ));
    setState(() {
      if (_newDate != null) {
        selectedDate = _newDate!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final personalInfoProvider= Provider.of<PersonalInfoProvider>(context,listen: true);
    final user=Provider.of<UserProvider>(context,listen: true);
    // personalInfoProvider.personalInfo.name=user.name.text;
    var _mediaQuery =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
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
            'Personal Info',
            style: Theme.of(context).textTheme.headline1,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body:loading?Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: _mediaQuery * 0.06),
                Text(personalInfoProvider.personalInfo.name),
                SizedBox(height: _mediaQuery * 0.06),
                Text(personalInfoProvider.personalInfo.email),
                SizedBox(height: _mediaQuery * 0.06),
                TextFormField(
                  controller: user.name,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: Theme.of(context).textTheme.headline4,
                    contentPadding: const EdgeInsets.only(left: 20),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Required *'),
                  ]),
                ),
                SizedBox(height: _mediaQuery * 0.03),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: Theme.of(context).textTheme.headline4,
                    contentPadding: const EdgeInsets.only(left: 20),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Required *'),
                  ]),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: _mediaQuery * 0.03),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: Theme.of(context).textTheme.headline4,
                    contentPadding: const EdgeInsets.only(left: 20),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Required *'),
                  ]),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: _mediaQuery * 0.03),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       'Date Of Birth',
                //       style: Theme.of(context).textTheme.headline4,
                //     ),
                //   ),
                // ),
                // SizedBox(height: _mediaQuery * 0.03),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(selectedDate == null
                          ? "No Date chosen!"
                          : 'Picked date: ${DateFormat.yMd().format(selectedDate)}'),
                      IconButton(
                        onPressed: _datePicker,
                        icon: Icon(
                          Icons.date_range,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: _mediaQuery * 0.07),
                ElevatedButton(
                  onPressed: () {
                    validate();
                  },
                  child: Text(
                    'SUBMIT',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(_mediaQuery * 0.18,
                        _mediaQuery * 0.02, _mediaQuery * 0.18, _mediaQuery * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: const Color(0xff3F5521),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

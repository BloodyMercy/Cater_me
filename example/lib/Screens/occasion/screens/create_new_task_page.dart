import 'package:CaterMe/Screens/occasion/screens/home_page.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/occasion/widgets/my_text_field.dart';
import 'package:CaterMe/Screens/occasion/widgets/top_container.dart';
import 'package:flutter/material.dart';
import 'package:CaterMe/Screens/occasion/widgets/back_button.dart';



class CreateNewTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              height: 300,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Create new ocasion',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(

                        style: TextStyle(color: Colors.black87),
                        minLines: 1,
                        maxLines: 1,
                        decoration: InputDecoration(
                          //suffixIcon: icon == null ? null: icon,
                            labelText: "title",
                            labelStyle: TextStyle(color: Colors.black45),

                            focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            border:
                            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: MyTextField(
                              label: 'Date',
                              icon: downwardIcon,
                            ),
                          ),
                          HomePageOc.calendarIcon(),
                        ],
                      )
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[

                  SizedBox(height: 20),
                  TextField(

                    style: TextStyle(color: Colors.black87),
                    minLines: 3,
                    maxLines: 3,
                    decoration: InputDecoration(
                      //suffixIcon: icon == null ? null: icon,
                        labelText: "Description",
                        labelStyle: TextStyle(color: Colors.black45),

                        focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                        border:
                        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
                  ),

                ],
              ),
            )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Create occasion',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: LightColors.kBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

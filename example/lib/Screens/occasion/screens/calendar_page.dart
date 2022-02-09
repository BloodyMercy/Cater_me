import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/occasion/widgets/back_button.dart';
import 'package:CaterMe/Screens/occasion/widgets/calendar_dates.dart';
import 'package:CaterMe/Screens/occasion/widgets/task_container.dart';
import 'package:flutter/material.dart';

import '../dates_list.dart';
import 'create_new_task_page.dart';

class CalendarPage extends StatelessWidget {
  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              MyBackButton(),
              SizedBox(height: 30.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'occasion',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 40.0,
                      width: 120,
                      decoration: BoxDecoration(

                        color: LightColors.kGreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateNewTaskPage(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Add ocasions',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ]),
           //   SizedBox(height: 10),





















              SizedBox(height: 20.0),
              // Container(
              //   height: 58.0,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: days.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return CalendarDates(
              //         day: days[index],
              //         date: dates[index],
              //         dayColor: index == 0 ? LightColors.kRed : Colors.black54,
              //         dateColor:
              //             index == 0 ? LightColors.kRed : LightColors.kDarkBlue,
              //       );
              //     },
              //   ),
           //   ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 5,
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              // _dashedText(),
                              // TaskContainer(
                              //   title: 'Project Research',
                              //   subtitle:
                              //       'Discuss with the colleagues about the future plan',
                              //   boxColor: LightColors.kLightYellow2,
                              // ),
                              _dashedText(),
                              TaskContainer(
                                title: 'Work on Medical App',
                                subtitle: 'Add medicine tab',
                                boxColor: LightColors.kLavender,
                              ),
                              TaskContainer(
                                title: 'Call',
                                subtitle: 'Call to david',
                                boxColor: LightColors.kPalePink,
                              ),
                              TaskContainer(
                                title: 'Design Meeting',
                                subtitle:
                                    'Discuss with designers for new task for the medical app',
                                boxColor: LightColors.kLightGreen,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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

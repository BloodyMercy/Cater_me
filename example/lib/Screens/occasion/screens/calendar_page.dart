import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Screens/add_new_occasion.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/occasion/widgets/back_button.dart';
import 'package:CaterMe/Screens/occasion/widgets/calendar_dates.dart';
import 'package:CaterMe/Screens/occasion/widgets/task_column.dart';
import 'package:CaterMe/Screens/occasion/widgets/task_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dates_list.dart';
import 'create_new_task_page.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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

  bool loading=false;

  Future getData() async {
    final occasion = Provider.of<OccasionProvider>(context, listen: false);
    await occasion.getallnewoccasion();

    setState(() {
      loading = false;
    });
    return;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final occasion = Provider.of<OccasionProvider>(context, listen: true);
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
                              builder: (context) => AddNewOccasion(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Add occasions',
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
                  child: CustomScrollView(slivers: <Widget>[



                    SliverToBoxAdapter(child: SizedBox(height: 20),),

                    SliverList(
                        delegate: SliverChildBuilderDelegate(

                              (BuildContext context, int index) {
                            return
                              TaskColumn(
                                icon: Icons.alarm,
                                iconBackgroundColor: LightColors.kRed,
                                title:  occasion.all[index].name,
                                subtitle: occasion.all[index].date,

                              );

                          },
                          childCount:  occasion.all.length,
                        )


                    ),




                  ])),
            ],
          ),
        ),
      ),
    );
  }
}

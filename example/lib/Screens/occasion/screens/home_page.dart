import 'package:CaterMe/Providers/occasion.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/Screens/occasion/widgets/active_project_card.dart';
import 'package:CaterMe/Screens/occasion/widgets/task_column.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calendar_page.dart';


class HomePageOc extends StatefulWidget {
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  State<HomePageOc> createState() => _HomePageOcState();
}

class _HomePageOcState extends State<HomePageOc> {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
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
    final occasion= Provider.of<OccasionProvider>(context,listen:true);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[

           // subheading('today'),
             //   SizedBox(height: 5.0),
            Expanded(
              child: CustomScrollView(slivers: <Widget>[

                SliverToBoxAdapter(child: SizedBox(height: 40),),


                SliverToBoxAdapter(child:    Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    subheading('My ocasions'),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarPage()),
                        );
                      },
                      child: HomePageOc.calendarIcon(),
                    ),
                  ],
                )),
                SliverToBoxAdapter(child: SizedBox(height: 40),),
                SliverToBoxAdapter(child: subheading('Today ocasions'),),
                SliverToBoxAdapter(child: SizedBox(height: 20),),

                SliverList(
                    delegate: SliverChildBuilderDelegate(

                          (BuildContext context, int index) {
                        return
                          TaskColumn(
                            icon: Icons.alarm,
                            iconBackgroundColor: LightColors.kRed,
                            title:  occasion.today[index].name,
                            subtitle: occasion.today[index].date,

                          );

                      },
                      childCount:  occasion.today.length,
                    )


                ),
                SliverToBoxAdapter(child: SizedBox(height: 40),),
                SliverToBoxAdapter(child: subheading('weekly ocasions'),),
                SliverToBoxAdapter(child: SizedBox(height: 20),),

                SliverList(
                    delegate: SliverChildBuilderDelegate(

                          (BuildContext context, int index) {
                        return
                          TaskColumn(
                            icon: Icons.alarm,
                            iconBackgroundColor: LightColors.kRed,
                            title: occasion.thisWeek[index].name,
                            subtitle: occasion.thisWeek[index].date,

                          );

                      },
                      childCount:  occasion.thisWeek.length,
                    )


                )

              ])),

          ],
        ),
      ),
    );
  }
}

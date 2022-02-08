import 'package:CaterMe/Providers/packages.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../add_new_occasion.dart';

class OccasionListView extends StatefulWidget {


  @override
  State<OccasionListView> createState() => _OccasionListViewState();
}

class _OccasionListViewState extends State<OccasionListView> {
  bool loading=false;
  getData()async{
    final occasion=Provider.of<PackagesProvider>(context,listen: false);
    await occasion.getalloccasions();

  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  Future refreshocasionData() async {
    final occasion = Provider.of<PackagesProvider>(context, listen: false);


    occasion.alloccasions.clear();
    await occasion.getalloccasions();
    return;
  }
  @override
  Widget build(BuildContext context) {
    final occasion=Provider.of<PackagesProvider>(context,listen: true);
    var _mediaQuery = MediaQuery.of(context).size.height;
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child:RefreshIndicator(
        onRefresh: refreshocasionData,
        child: !loading? Column(
          children: [
            SizedBox(
              height: _mediaQuery * 0.78,
              child:occasion.alloccasions.isEmpty
                  ? Center(
                child: Container(
                  child: Image.asset('images/no addresses yet-02.png'),
                ),
              )
                  : ListView.builder(
                  itemCount: occasion.alloccasions.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: mediaQuery.size.height * 0.15,
                            width: mediaQuery.size.width * 0.23,
                            child: Card(
                                color: Theme.of(context).primaryColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${DateFormat.MMM().format(DateTime.parse(occasion.alloccasions[index].date))}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        '${DateFormat.d().format(DateTime.parse(occasion.alloccasions[index].date))}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))
                                  ],
                                )),
                          ),
                          SizedBox(
                            width: mediaQuery.size.width * 0.1,),
                          Text(
                            '${occasion.alloccasions[index].name}',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                    );
                    // Card(
                    //   child: Row(
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.symmetric(
                    //             vertical: _mediaQuery * 0.02,
                    //             horizontal: _mediaQuery * 0.01),
                    //         child: CircleAvatar(
                    //           radius: 25.0,
                    //           child: ClipRRect(
                    //             child: Image.network(
                    //               occasion[index].name,
                    //             ),
                    //             borderRadius: BorderRadius.circular(50.0),
                    //           ),
                    //         ),
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             occasion[index].date,
                    //             style: const TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.bold),
                    //           ),
                    //           Text(
                    //             friend[index].email,
                    //             style: const TextStyle(
                    //                 fontSize: 15, fontWeight: FontWeight.bold),
                    //           ),
                    //           // SizedBox(height: _mediaQuery * 0.01),
                    //           Text(
                    //             friend[index].phoneNumber,
                    //             style: const TextStyle(
                    //                 fontSize: 13, fontWeight: FontWeight.bold),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // );


                  }),

            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddNewOccasion(),
                  ),
                );
              },
              child: const Text(
                "Add new occasion",
                style: TextStyle(
                    color: Color.fromRGBO(63, 85, 33, 1),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BerlinSansFB'),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                padding: EdgeInsets.symmetric(
                  horizontal: (mediaQuery.size.width * 0.05),
                  vertical: (mediaQuery.size.height * 0.01),
                ),
                primary:  Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),

          ],
        ):Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

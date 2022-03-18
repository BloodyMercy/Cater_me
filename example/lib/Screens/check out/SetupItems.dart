import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/user.dart';
import '../../language/language.dart';

// Adapted from the data table demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart
class SetupItems extends StatefulWidget {
  const SetupItems({Key key}) : super(key: key);

  @override
  _SetupItemsState createState() => _SetupItemsState();
}

class _SetupItemsState extends State<SetupItems> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  List<bool> _isChecked=[];
 bool loading=false;
  getData()async{
    final order=Provider.of<OrderByIdProvider>(context,listen: false);
    setState(() {
      loading=true;
    });
    SharedPreferences sh =await SharedPreferences.getInstance();
    await order.getItemModel(sh.getString("locale"));
    if(order.setupItemmodel.length>0) {
      _isChecked = List<bool>.filled(order.setupItemmodel.length, false);
    }
    setState(() {
      loading=false;
    });
  }


  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: true);
    final order=Provider.of<OrderByIdProvider>(context,listen: true);
    final orderCater=Provider.of<OrderCaterProvider>(context,listen: true);
    return SafeArea(
      child: Scaffold(


        backgroundColor: Colors.white,
        body:loading?Center(child: CircularProgressIndicator(),):order.setupItemmodel.length==0?Center(child: Text("No data"),): Center(child: ListView.builder(itemBuilder: (context,index){
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: colorCustom,
              title:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.setupItemmodel[index].title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                 Text('${LanguageTr.lg[authProvider.language]["Free"]}',
                   style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.grey),)
                ],
              ),

              value: _isChecked[index],

              onChanged: (val){
            setState(() {
             _isChecked[index]=val;
            });
            if(val==true){
              orderCater.setupItemModelId.add(order.setupItemmodel[index].id);
            }else{
              orderCater.setupItemModelId.removeWhere((element) => element==order.setupItemmodel[index].id);
            }
          });
        },itemCount: order.setupItemmodel.length,)),

        // SingleChildScrollView(
        //   child: PaginatedDataTable(
        //     header: const Text('Nutrition'),
        //     rowsPerPage: _rowsPerPage,
        //     availableRowsPerPage: const <int>[5, 10, 20],
        //     onRowsPerPageChanged: (int value) {
        //       print(value.toString());
        //       if (value != null) {
        //
        //         setState(() => _rowsPerPage = value);
        //       }
        //     },
        //     columns: kTableColumns,
        //     source: DessertDataSource(),
        //   ),
        // ),
      ),
    );
  }
}

////// Columns in table.
const kTableColumns = <DataColumn>[
  DataColumn(
    label: Text('All Package',style: TextStyle(color: Color(0xFFFBC02D), ),),
  ),


];

////// Data class.
class Dessert {
  Dessert(this.name,this.ar);

  final String name;
  final String ar;


  bool selected = false;
}

////// Data source class for obtaining row data for PaginatedDataTable.

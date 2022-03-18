import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';

// Adapted from the data table demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart
class SetupItems extends StatefulWidget {
  const SetupItems({Key key}) : super(key: key);

  @override
  _SetupItemsState createState() => _SetupItemsState();
}

class _SetupItemsState extends State<SetupItems> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          header: const Text('Nutrition'),
          rowsPerPage: _rowsPerPage,
          availableRowsPerPage: const <int>[5, 10, 20],
          onRowsPerPageChanged: (int value) {
            if (value != null) {
              setState(() => _rowsPerPage = value);
            }
          },
          columns: kTableColumns,
          source: DessertDataSource(),
        ),
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
class DessertDataSource extends DataTableSource {
  int _selectedCount = 0;
  final List<Dessert> _desserts = <Dessert>[
    Dessert('id','ar'),
    Dessert('Frozen yogurt', 'ar' ),
    Dessert('Ice cream sandwich', 'ar' ),
    Dessert('Eclair','ar'  ),
    Dessert('Cupcake', 'ar' ),
    Dessert('Gingerbread','ar' ),
    Dessert('Jelly bean','ar' ),
    Dessert('Lollipop','ar' ),
    Dessert('Honeycomb','ar' ),
    Dessert('Donut','ar' ),
    Dessert('KitKat','ar'  ),
    Dessert('Frozen yogurt with sugar',  'ar'),
    Dessert('Ice cream sandwich with sugar','ar' ),
    Dessert('Eclair with sugar','ar'),
    Dessert('Cupcake with sugar','ar' ),
    Dessert('Gingerbread with sugar','ar'),
    Dessert('Jelly bean with sugar', 'ar' ),
    Dessert('Lollipop with sugar', 'ar'),
  ];

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final Dessert dessert = _desserts[index];
    return DataRow.byIndex(
      index: index,
      selected: dessert.selected,

      onSelectChanged: (bool value) {
        if (value == null) return;
        if (dessert.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(Text(dessert.name)),


      ],
    );
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

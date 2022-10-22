// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_constructors_in_immutables

import 'package:attendance_app/functions/gsheet.dart';
import 'package:attendance_app/screens/fourth.dart';
import 'package:attendance_app/screens/second.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class subdate extends StatefulWidget {
  subdate({Key? key}) : super(key: key);

  @override
  State<subdate> createState() => _subdateState();
}

class _subdateState extends State<subdate> {
  var sub = "COMPUTER";

  var items = ["COMPUTER", "MATHEMATICS", "PHYSICS", "CHEMISTRY"];
  dynamic _date = "No date selected";
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF18978F), // <-- SEE HERE
              onPrimary: Color(0xffe9dac1), // <-- SEE HERE
              onSurface: Color(0xFF18978F), // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xFF18978F), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      List<String> months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      _date =
          "\"${selected!.year.toString()}-${months[selected.month - 1]}-${selected.day.toString().padLeft(2, '0')}\"";
    });
  }

// Future<DateTime?> selectDate() async {
// return  showDatePicker(
//   context: context,
//   initialDatePickerMode: DatePickerMode.day,
//   initialDate: DatePickerMode.day,
//   builder: (BuildContext context, Widget child) {
//     return Theme(
//       data: ThemeData.light().copyWith(
//           primaryColor: Colors.teal,
//           accentColor: Colors.teal,
//           colorScheme: ColorScheme.light(primary: Colors.teal),
//           buttonTheme: ButtonThemeData(
//             textTheme: ButtonTextTheme.primary
//           ),
//       ),
//       child: child,
//     );
//   },
//   firstDate: widget.initialDate ?? DateTime.now().subtract(Duration(days:
//   30)),
//   lastDate: widget.lastDate ?? DateTime.now().add(Duration(days: 30)),
//  );
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9dac1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: DropdownButton(
                dropdownColor: Color(0xFF18978F),
                focusColor: Color(0xFF18978F),
                borderRadius: BorderRadius.circular(10),
                value: sub,
                items: items.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    sub = newValue!;
                  });
                }),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF18978F)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 20))),
                  onPressed: () => _selectDate(context),
                  child: Text(
                    _date,
                    style: TextStyle(color: Color(0xffe9dac1)),
                  ),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 30, 50, 0),
                child: FloatingActionButton(
                  onPressed: (() async {
                    final prefs = await SharedPreferences.getInstance();
                    final success = await prefs.remove('sheetId');
                    print(success);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondPage()),
                    );
                  }),
                  child: Icon(Icons.delete_outline_rounded),
                  backgroundColor: Color(0xFF18978F),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 50, 0),
                child: FloatingActionButton(
                  onPressed: (() async {
                    await UserSheetApi.initSub(sub: sub);
                    await UserSheetApi.inserNewCol([_date]);
                    final date = await SharedPreferences.getInstance();
                    await date.setString('date', _date);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => fourth()),
                    );
                  }),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.keyboard_arrow_right),
                  backgroundColor: Color(0xFF18978F),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

//  DateTimePicker(
//                   initialValue: '',
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2100),
//                   dateLabelText: 'Date',
//                   decoration: InputDecoration.collapsed(hintText: "Date"),
//                   builder: (BuildContext context, Widget child) {
//                     return Theme(
//                       data: Theme.of(context).copyWith(
//                         colorScheme: ColorScheme.light(
//                           primary: Colors.amberAccent, // <-- SEE HERE
//                           onPrimary: Colors.redAccent, // <-- SEE HERE
//                           onSurface: Colors.blueAccent, // <-- SEE HERE
//                         ),
//                         textButtonTheme: TextButtonThemeData(
//                           style: TextButton.styleFrom(
//                             primary: Colors.red, // button text color
//                           ),
//                         ),
//                       ),
//                       child: child,
//                     );
//                   },
//                   onChanged: (val) => print(val),
//                   validator: (val) {
//                     print(val);
//                     return null;
//                   },
//                   onSaved: (val) => print(val),
//                 ),

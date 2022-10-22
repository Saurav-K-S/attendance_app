// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_final_fields, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:attendance_app/functions/gsheet.dart';
import 'package:attendance_app/screens/second.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/widgets/text_field_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class fourth extends StatefulWidget {
  const fourth({Key? key}) : super(key: key);

  @override
  State<fourth> createState() => _fourthState();
}

class _fourthState extends State<fourth> {
  TextEditingController _controller = TextEditingController();

  void _onpressed() async {
    final date = await SharedPreferences.getInstance();
    String? date1 = date.getString('date');

    String roll = _controller.text;
    List<String> rollnos = roll.split(",");
    print(rollnos);
    rollnos.forEach((element) async {
      print(element);
      await UserSheetApi.updateCell(int.parse(element), date1!, "Present");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9dac1),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: TextFieldInput(
              textEditingController: _controller,
              hintText: "Enter the Roll Numbers",
              textInputType: TextInputType.text),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
              padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
              child: FloatingActionButton(
                onPressed: _onpressed,
                backgroundColor: const Color(0xFF18978F),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ],
        )
      ]),
    );
  }
}

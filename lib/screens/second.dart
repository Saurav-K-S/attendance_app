// ignore_for_file: prefer_const_constructors_in_immutables, prefer_final_fields, avoid_print

import 'package:attendance_app/functions/gsheet.dart';
import 'package:attendance_app/screens/third.dart';
import 'package:attendance_app/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController _controller = TextEditingController();

  void _onPressed() async {
    final prefs = await SharedPreferences.getInstance();
    String url = _controller.text;

    List<String> s = url.split("/");
    print(s[5]);
    await UserSheetApi.init(id: s[5]);
    await prefs.setString('sheetId', s[5]);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => subdate()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xffe9dac1),
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(60, 0, 60, 10),
                child: SelectableText(
                  "Make sure the GSheet has access to gsheets@gsheets-352717.iam.gserviceaccount.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF18978F), fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextFieldInput(
                  textEditingController: _controller,
                  hintText: "Enter the url",
                  textInputType: TextInputType.text),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
              child: FloatingActionButton(
                onPressed: _onPressed,
                backgroundColor: const Color(0xFF18978F),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.keyboard_arrow_right),
              ),
            )
          ])),
    );
  }
}

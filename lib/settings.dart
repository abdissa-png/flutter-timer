import 'package:flutter/material.dart';

import 'widgets/settingButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({super.key});
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;
  TextStyle textStyle = TextStyle(fontSize: 24);
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  late SharedPreferences prefs;
  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingButton(
            color: Color(0xff455A64),
            text: "-",
            value: -1,
            size: 30,
            setting: WORKTIME,
            callback: updateSetting,
          ),
          TextField(
              controller: txtWork,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingButton(
            color: Color(0xff009688),
            text: "+",
            value: 1,
            size: 30,
            setting: WORKTIME,
            callback: updateSetting,
          ),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingButton(
            color: Color(0xff455A64),
            text: "-",
            value: -1,
            size: 30,
            setting: SHORTBREAK,
            callback: updateSetting,
          ),
          TextField(
              controller: txtShort,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingButton(
            color: Color(0xff009688),
            text: "+",
            value: 1,
            size: 30,
            setting: SHORTBREAK,
            callback: updateSetting,
          ),
          Text("Long", style: textStyle),
          Text(""),
          Text(""),
          SettingButton(
            color: Color(0xff455A64),
            text: "-",
            value: -1,
            size: 30,
            setting: LONGBREAK,
            callback: updateSetting,
          ),
          TextField(
              controller: txtLong,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingButton(
            color: Color(0xff009688),
            text: "+",
            value: 1,
            size: 30,
            setting: LONGBREAK,
            callback: updateSetting,
          ),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, 30);
      workTime = 30;
    }
    int? shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, 5);
      shortBreak = 5;
    }
    int? longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, 20);
      longBreak = 20;
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int work = prefs.getInt(WORKTIME)!;
          work += value;
          if (work >= 1 && work <= 180) {
            prefs.setInt(WORKTIME, work);
            setState(() {
              txtWork.text = work.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK)!;
          short += value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK)!;
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:timer_app/models/timermodel.dart';
import 'package:timer_app/settings.dart';
import 'package:timer_app/timer.dart';
import 'package:timer_app/widgets/productivityButton.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();
  final List<PopupMenuItem<String>> menuItems = [
    PopupMenuItem(value: 'Settings', child: Text("Settings"))
  ];
  TimerHomePage({super.key}) {
    timer.startWork();
  }
  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Work Timer"), actions: [
        PopupMenuButton<String>(
          itemBuilder: (context) {
            return menuItems.toList();
          },
          onSelected: (value) {
            if (value == 'Settings') {
              goToSettings(context);
            }
          },
        )
      ]),
      body: LayoutBuilder(builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;
        final double availableHeight = constraints.maxHeight;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                        color: Color(0xff009688),
                        text: "Work",
                        onPressed: () => timer.startWork()),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                        color: Color(0xff607D8B),
                        text: "Short Break",
                        onPressed: () => timer.startBreak(true)),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                    child: ProductivityButton(
                        color: Color(0xff455A64),
                        text: "Long Break",
                        onPressed: () => timer.startBreak(false)),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              ),
              StreamBuilder<Object>(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (context, snapshot) {
                    TimerModel timer = (snapshot.data == "00:00")
                        ? TimerModel(time: "00:00", percent: 1)
                        : snapshot.data as TimerModel;
                    return OrientationBuilder(builder: (context, orientaion) {
                      if (MediaQuery.of(context).orientation ==
                          Orientation.portrait) {
                        return Expanded(
                          child: CircularPercentIndicator(
                            radius: availableWidth / 2,
                            lineWidth: 10.0,
                            percent: timer.percent,
                            center: Text(timer.time,
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            progressColor: Color(0xff009688),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: CircularPercentIndicator(
                            radius: availableHeight / 3.2,
                            lineWidth: 10.0,
                            percent: timer.percent,
                            center: Text(timer.time,
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            progressColor: Color(0xff009688),
                          ),
                        );
                      }
                    });
                  }),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                          color: Color(0xff212121),
                          text: "Stop",
                          onPressed: () => timer.stopTimer())),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                  Expanded(
                      child: ProductivityButton(
                          color: Color(0xff009688),
                          text: "Restart",
                          onPressed: () => timer.startTimer())),
                  Padding(padding: EdgeInsets.all(defaultPadding)),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}

void emptyMethod() {}

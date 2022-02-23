import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';  // for measuring the time
import 'package:timer_app/alertBox/alert_noweDane.dart';  // for alert box "nowe dane"
import 'package:timer_app/classes/reference.dart';  //for "reference"
import 'package:timer_app/alertBox/alert_endOfTime.dart';

class TimeMeasure extends StatefulWidget {
  @override
  _TimeMeasure createState() => _TimeMeasure();
}

class _TimeMeasure extends State<TimeMeasure> {

  Map data = {};  //for transferring data between pages

  int testTimeInMinutes;
  int testTimeInSeconds;
  int numberOfExercises;
  int exNumber;  // number of current exercise
  int timePerEx; // in seconds
  int exTimeOverall;  // amount of time for exercises, changeable in time
  Timer _timer;   // object responsible for subtracting seconds from time
  String exTimeOverallText;
  bool startButtonVisibility;
  Color exTimeOverallColor;


  void changeTextTimePlus() {
    setState(() {
      exTimeOverallText = '${exTimeOverall~/60} min ${exTimeOverall%60} sec';
      exTimeOverallColor = Colors.greenAccent[700];
    });
  }

  void changeTextTimeMinus() {
    setState(() {
      exTimeOverallText = '$exTimeOverall sec';
      exTimeOverallColor = Colors.redAccent;
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        if(testTimeInSeconds > 0 && exNumber <= numberOfExercises) {
          testTimeInSeconds--;
          exTimeOverall--;
        }
        else {
          _timer.cancel();
          showAlertDialogEndOfTest(context, 'time');
        }

        if(exTimeOverall > 0)
          changeTextTimePlus();
        else
          changeTextTimeMinus();
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    // data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;  //receiving data
    // print(data);

    if(data.isEmpty) {
      data = ModalRoute.of(context).settings.arguments;  //receiving data

      // print(data['testTimeInMinutes']);
      //print(data['numberOfExercises']);

      testTimeInMinutes = int.parse(data['testTimeInMinutes']);
      // print('testTimeInMinutes: $testTimeInMinutes');
      testTimeInSeconds = testTimeInMinutes*60;
      //print(testTimeInSeconds);
      numberOfExercises = int.parse(data['numberOfExercises']);

      timePerEx = (testTimeInSeconds/numberOfExercises).round();
      exTimeOverall = timePerEx;

      exNumber = 1;

      exTimeOverallText = '${exTimeOverall~/60} min ${exTimeOverall%60} sec';

      startButtonVisibility = true;

      exTimeOverallColor = Colors.greenAccent[700];
    }


    return Scaffold(
      backgroundColor: Colors.black,
        body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  color: Colors.grey[800],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 3.0,
                          color: Colors.grey[400],
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Zadanie nr $exNumber',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                letterSpacing: 0.0,
                                fontSize: 28.0,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Czas testu',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.0,
                            fontSize: 24.0,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                        Text(
                          '${(testTimeInSeconds/60).floor()} min ${testTimeInSeconds%60} sec',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0.0,
                            fontSize: 24.0,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Czas zadania',
                          style: TextStyle(
                            color: exTimeOverallColor,
                            letterSpacing: 0.0,
                            fontSize: 24.0,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                        Text(
                          '$exTimeOverallText',
                          style: TextStyle(
                            color: exTimeOverallColor,
                            letterSpacing: 0.0,
                            fontSize: 24.0,
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 70.0,
                  color: Colors.grey[800],
                  thickness: 2.0,
                ),
                Center(
                  child: RaisedButton(  //"nastepne zadanie" button
                    onPressed: () {
                      setState(() {
                        if(!startButtonVisibility) {  //action only if the timer started
                          if (_timer.isActive) {  // not to press the button again after the timer ended
                            if (exNumber >= numberOfExercises) {
                              exTimeOverall = timePerEx;
                              _timer.cancel();
                              // print koniec testu
                              showAlertDialogEndOfTest(context, 'ex');
                            } else {
                              exNumber += 1;
                              exTimeOverall += timePerEx;
                            }
                          }
                        }
                      });
                    },
                    child: Text(
                      'Następne zadanie',
                      style: TextStyle(
                        fontFamily: 'ComfortaaRegular',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      )
                    ),
                    color: Colors.lightBlue[300],
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Visibility(
                    visible: startButtonVisibility,
                    child: RaisedButton(  // start button (rozpocznij test)
                      onPressed: () {
                        setState(() {
                          startButtonVisibility = false;
                          if(_timer == null || !_timer.isActive)  // with this we cannot start another timer
                            startTimer();
                        });
                      },
                      child: Text(
                          'Rozpocznij test',
                          style: TextStyle(
                            fontFamily: 'ComfortaaRegular',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )
                      ),
                      color: Colors.green[400],
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                    ),
                  ),
                ),
                //SizedBox(height: 30.0),
                // RaisedButton(  //reset button for dev testing
                //   onPressed: () {
                //     setState(() {
                //       _timer.cancel();
                //       // exTimeOverall = timePerEx;
                //       // testTimeInSeconds = testTimeInMinutes*60;
                //       // exTimeOverallText = 'Czas zadania: ${exTimeOverall~/60} min ${exTimeOverall%60} sec';
                //       // exNumber = 1;
                //     });
                //   },
                //   child: Text('Stop'),
                //   color: Colors.red[400],
                // ),
                SizedBox(height: 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton.icon(  //button "nowe dane" - coming back to /insert page
                      onPressed: () async {
                        // if test is active so time is measuring
                        if(!startButtonVisibility && _timer.isActive) {
                          var yes = PrimitiveWrapper(false);
                          showAlertDialogNoweDane(context, yes);
                          while (yes.value == false) {
                            await Future.delayed(Duration(milliseconds: 20));
                          }
                          print('Yes: ${yes.value}');
                          if (yes.value) {
                            Navigator.pushReplacementNamed(context, '/insert');

                            // resetting to primary state
                            data = {}; // reset the data
                            _timer.cancel(); //stop the timer
                            //startButtonVisibility = true;  // not necessary because of isData.empty func
                          }
                        }
                        else {  // if test is not active so has not begun yet
                          Navigator.pushReplacementNamed(context, '/insert');
                          // resetting to primary state
                          data = {}; // reset the data
                        }
                      },
                      icon: Icon(
                        Icons.west_rounded,
                      ),
                      label: Text(
                        'Nowe dane',
                          style: TextStyle(
                            fontFamily: 'ComfortaaRegular',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          )
                      ),
                      color: Colors.red[400],
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




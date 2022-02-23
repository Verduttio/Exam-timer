import 'package:flutter/material.dart';
import 'package:timer_app/classes/data.dart';
import 'package:flutter/services.dart'; // for entering only numbers to text fields
import 'package:timer_app/alertBox/wrong_inserted_data.dart'; // alert box for wrong inserted data


class Inserting extends StatefulWidget {

  @override
  _InsertingState createState() => _InsertingState();
}

class _InsertingState extends State<Inserting> {
  Data data = Data();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Dane',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.w800,
          )
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(  //first text field
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Czas trwania testu',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.grey[600],
                        thickness: 1.0,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                             // borderRadius: BorderRadius.circular(25.0),  // circled box
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2.0),
                             // borderRadius: BorderRadius.circular(25.0),  // circled box
                            ),
                            hintText: 'Czas w minutach',
                            // hintStyle: TextStyle(
                            //   fontFamily: 'Comfortaa',
                            //   fontSize: 13.0,
                            // ),
                        ),
                        keyboardType: TextInputType.number,  // keyboard display numbers

                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered

                        onChanged: (val) {
                          data.testTimeInMinutes = val;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Card(  //second text field
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Liczba zadań',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                      Divider(
                        height: 10.0,
                        color: Colors.grey[600],
                        thickness: 1.0,
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
                              // borderRadius: BorderRadius.circular(25.0),  //circled box
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 2.0),
                              // borderRadius: BorderRadius.circular(25.0),  //circled box
                            ),
                            // hintText: 'Ilość zadań', // not necessary here
                        ),
                        keyboardType: TextInputType.number,  // keyboard display numbers

                        inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                        ], // Only numbers can be entered

                        onChanged: (val) {
                          data.numberOfExercises = val;
                        }
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 70.0),
              Center(
                child: RaisedButton(
                  onPressed: () {
                      bool dataCorrect = true;

                      //checking if user entered 0 or nothing
                      if (data.numberOfExercises == null || data.testTimeInMinutes == null ||
                          data.numberOfExercises == "" || data.testTimeInMinutes == "") {
                        showAlertDialogWrongData(context, 0);
                        dataCorrect = false;
                      }


                      // checking field "liczba zadań"
                      if (dataCorrect) {
                        try {
                          int.parse(data.numberOfExercises);
                        }
                        catch (e) {
                          print(
                              'Blad przy wprowadzeniu liczby zadań. Błąd: $e');
                          dataCorrect = false;
                        }

                        // checking field "czas trwania testu"
                        try {
                          int.parse(data.testTimeInMinutes);
                        }
                        catch (e) {
                          print(
                              'Blad przy wprowadzaniu czasu trwania testu. Błąd: $e');
                          dataCorrect = false;
                        }

                        if (!dataCorrect)
                          showAlertDialogWrongData(context, 2);
                      }


                      // checking weather number are 0 or not
                      if (dataCorrect) {
                        if (int.parse(data.numberOfExercises) == 0 ||
                            int.parse(data.testTimeInMinutes) == 0) {
                            print('Jedna z liczb jest zerem. Błąd');
                            showAlertDialogWrongData(context, 1);  // display alert box
                            dataCorrect = false;
                        }
                      }


                      if (dataCorrect) {
                        if (int.parse(data.numberOfExercises) > 10000 ||
                            int.parse(data.testTimeInMinutes) > 10000) {
                          showAlertDialogWrongData(context, 3);  // display alert box
                          dataCorrect = false;
                        }
                      }

                      if (dataCorrect) {
                        if (int.parse(data.numberOfExercises) < 0 ||
                            int.parse(data.testTimeInMinutes) < 0) {
                          showAlertDialogWrongData(context, 4);  // display alert box
                          dataCorrect = false;
                        }
                      }


                      if(dataCorrect) {
                        print('Data: ${data.numberOfExercises}');
                        print('Time: ${data.testTimeInMinutes}');
                        Navigator.pushReplacementNamed(
                            context, '/timer', arguments: {
                          'numberOfExercises': data.numberOfExercises,
                          'testTimeInMinutes': data.testTimeInMinutes,
                        });
                      } else
                        dataCorrect = true; //for a new attempt
                  },
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                  child: Text(
                      'Zatwierdź',
                    style: TextStyle(
                      fontFamily: 'ComfortaaRegular',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  color: Colors.greenAccent[700],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

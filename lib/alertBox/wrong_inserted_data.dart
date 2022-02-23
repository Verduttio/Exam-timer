import 'package:flutter/material.dart';

showAlertDialogWrongData(BuildContext context, int errorCode) {
  // error code legend
  // 0 - user hasn't entered data
  // 1 - user entered 0
  // 2 - user entered unspecified symbols
  // 3 - user entered too high numbers > 10 000 <-- obviously no sense to run the timer
  // 4 - user entered negative number < 0
  String error0Alert = 'Nie wprowadzono wszystkich danych.';
  String error1Alert = 'Wprowadzono liczbę 0. Proszę wprowadzić sensowną wartość.';
  String error2Alert = 'Wprowadzono znak niebędący liczbą. Proszę wprowadzić liczbę.';
  String error3Alert = 'Wprowadzono liczbę większą od 10 000. Proszę wprowadzić sensowną wartość.';
  String error4Alert = 'Wprowadzono liczbę ujemną. Proszę wprowadzić sensowną wartość będącą liczbą dodatnią.';

  String errorAlert;
  if (errorCode == 0)
    errorAlert = error0Alert;
  else if (errorCode == 1)
    errorAlert = error1Alert;
  else if (errorCode == 2)
    errorAlert = error2Alert;
  else if (errorCode == 3)
    errorAlert = error3Alert;
  else if (errorCode == 4)
    errorAlert = error4Alert;
  else
    errorAlert = 'Wystąpił niezidentyfikowany błąd. Prosimy o kontakt z twórcą aplikacji.';

  // set up the buttons
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed:  () {Navigator.pop(context);},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Błąd"),
    content: Text('$errorAlert'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
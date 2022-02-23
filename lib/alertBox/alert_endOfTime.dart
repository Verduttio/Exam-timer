import 'package:flutter/material.dart';

showAlertDialogEndOfTest(BuildContext context, String endType) {
  // endType legend
  // 'time' - means that the test ended because of running out of time
  // 'ex' - means that user went through all exercises

  // set up the buttons
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed:  () {Navigator.pop(context);},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Koniec testu"),
    content: endType == 'ex' ? Text("Przeszedłeś przez wszystkie zadania. By rozpocząć nowy test kliknij przycisk 'nowe dane'.")
                              : Text("Skończył się czas. By rozpocząć nowy test kliknij przycisk 'nowe dane'."),
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
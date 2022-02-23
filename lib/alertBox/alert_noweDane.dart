import 'package:flutter/material.dart';
import 'package:timer_app/classes/reference.dart';

showAlertDialogNoweDane(BuildContext context, PrimitiveWrapper yes) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Nie"),
    onPressed:  () {Navigator.pop(context); yes.value = false;},
  );
  Widget continueButton = FlatButton(
    child: Text("Tak"),
    onPressed:  () {Navigator.pop(context); yes.value = true;},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Nowe dane"),
    content: Text("Czy na pewno chcesz przerwać test i wprowadzić nowe dane?"),
    actions: [
      continueButton,
      cancelButton,
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
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController inputController;
  final String inputError;
  InputField({this.inputController, this.inputError});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: new Theme(
            data: new ThemeData(
                primaryColor: Theme.of(context).primaryColor,
                textSelectionColor: Theme.of(context).primaryColor
            ),
            child: new TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: inputController,
                decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                  errorText: inputError,
                )
            )
        )
    );
  }

}
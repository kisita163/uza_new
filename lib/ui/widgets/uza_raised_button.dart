import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;

  CustomRaisedButton(
      {this.title,
      this.textColor,
      this.onPressed,
      this.color,
      this.splashColor,
      this.borderColor,
      this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 322.0,
        height: 36.0,
        child: RaisedButton(
          onPressed: onPressed,
          color: color,
          splashColor: splashColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              title,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                decoration: TextDecoration.none,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ));
  }
}

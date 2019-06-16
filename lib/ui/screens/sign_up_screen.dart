// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:onboarding_flow/ui/widgets/uza_raised_button.dart';
import 'package:onboarding_flow/ui/widgets/uza_password_field.dart';
import 'package:onboarding_flow/models/user.dart';
import 'package:onboarding_flow/business/auth.dart';
import 'package:onboarding_flow/ui/widgets/uza_alert_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key key }) : super(key: key);

  static const String routeName = '/material/text-form-field';

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class PersonData {
  String name = '';
  String email = '';
  String password = '';
}


class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PersonData person = PersonData();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }

  bool _autovalidate = false;
  bool _formWasEdited = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  void _signUp(
      { PersonData person,
        BuildContext context}) async {

      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');

        await Auth.signUp(person.email, person.password).then((uID) {
          Auth.addUser(new User(
              userID: uID,
              email: person.email,
              firstName: person.name,
              profilePictureURL: ''));
          Navigator.of(context).pop();
        });
      } catch (e) {
        print("Error in sign up: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Signup failed",
          content: exception,
        );
      }

  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar('${person.name}\'s email is ${person.email}');
      _signUp(person: person);
    }
  }

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  String _validatePassword(String value) {
    _formWasEdited = true;
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return 'Please enter a password.';
    if (passwordField.value != value)
      return 'The passwords don\'t match';
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited || form.validate())
      return true;

    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('This form has errors'),
          content: const Text('Really leave this form?'),
          actions: <Widget> [
            FlatButton(
              child: const Text('YES'),
              onPressed: () { Navigator.of(context).pop(true); },
            ),
            FlatButton(
              child: const Text('NO'),
              onPressed: () { Navigator.of(context).pop(false); },
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(''),
        elevation:  0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: _autovalidate,
          onWillPop: _warnUserAboutInvalidData,
          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 24.0),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                    fillColor: Colors.transparent,
                  ),
                  onSaved: (String value) { person.name = value; },
                  validator: _validateName,
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.email),
                    hintText: 'Your email address',
                    labelText: 'E-mail *',
                    fillColor: Colors.transparent
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) { person.email = value; },
                ),
                const SizedBox(height: 24.0),
                PasswordField(
                  fieldKey: _passwordFieldKey,
                  helperText: 'No more than 8 characters.',
                  labelText: 'Password *',
                  onFieldSubmitted: (String value) {
                    setState(() {
                      person.password = value;
                    });
                  },
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  enabled: person.password != null && person.password.isNotEmpty,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    fillColor: Colors.transparent,
                    labelText: 'Re-type password',
                  ),
                  maxLength: 8,
                  obscureText: true,
                  validator: _validatePassword,
                ),
                const SizedBox(height: 24.0),

                CustomRaisedButton(
                  title: "Submit",
                  textColor: Colors.white,
                  onPressed:_handleSubmitted,
                  splashColor: Colors.black12,
                  borderColor: Colors.white,
                  borderWidth: 0,
                  color: Color(0xFF2979FF), //Color.fromRGBO(212, 20, 15, 1.0),
                ),

                const SizedBox(height: 24.0),
                Text(
                    '* indicates required field',
                    style: Theme.of(context).textTheme.caption
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setnis/model/appstate.dart';
import 'package:setnis/services/loginservice.dart';

class LoginRoute extends StatefulWidget {
  LoginRoute({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginRoute> {
  bool _isLoading = false;
  LoginService loginService = getLoginService();
  TextEditingController loginCodeController = TextEditingController();

  void setLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    loginCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kirjaudu sisään'),
        ),
        body: Builder(builder: (BuildContext bcontext) {
          return Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Käyttäjätunnus'),
                controller: loginCodeController,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed:
                          _isLoading ? null : () => doUserLogin(bcontext),
                      child: Text(_isLoading
                          ? 'Kirjaudutaan sisään...'
                          : 'Kirjaudu sisään'),
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
  }

  void doUserLogin(BuildContext bcontext) {
    this.setLoadingState(true);
    var loginCodeStr = loginCodeController.text;
    var loginCode = int.tryParse(loginCodeStr);
    loginService.login(loginCode).then((loginSuccess) {
      this.setLoadingState(false);
      Provider.of<AppStateModel>(context).setIsloggedIn(loginSuccess);
      if (loginSuccess) {
        Provider.of<AppStateModel>(context).getCurrentEvents();
        Scaffold.of(bcontext)
            .showSnackBar(SnackBar(content: Text('Kirjautuminen onnistui!')));
        Timer(Duration(milliseconds: 1000), () {
          loginCodeController.clear();
          Navigator.popUntil(context, ModalRoute.withName('/'));
        });
      } else {
        loginCodeController.clear();
        Scaffold.of(bcontext)
            .showSnackBar(SnackBar(content: Text('Kirjautuminen epäonnistui')));
      }
    });
  }
}

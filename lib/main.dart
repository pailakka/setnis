import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setnis/additemdetails.dart';
import 'package:setnis/availableevents.dart';
import 'package:setnis/login.dart';
import 'package:setnis/model/appstate.dart';
import 'package:setnis/model/positionmodel.dart';
import 'package:setnis/read.dart';
import 'package:setnis/additem.dart';
import 'package:setnis/services/loginservice.dart';

void main() {
  return runApp(SETNISApp());
}

class SETNISApp extends StatelessWidget {
  LoginService loginService = getLoginService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => AppStateModel()),
          ChangeNotifierProvider(builder: (_) => PositionModel()),
        ],
        child: MaterialApp(
            title: 'SET NIS',
            theme: ThemeData(primarySwatch: Colors.grey),
            initialRoute: '/',
            routes: {
              '/': (context) => SETNISHomePage(title: 'SET verkkotiedot'),
              '/login': (context) => LoginRoute(),
              '/read': (context) => ReadRoute(),
              '/additem': (context) => AddItemRoute(),
              '/additem/details': (context) => AddItemDetailsRoute(),
              '/logout': (context) {
                var appState = Provider.of<AppStateModel>(context);
                var navi = Navigator.of(context);
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  await loginService.logout();
                  appState.setIsloggedIn(false);
                  await navi.popUntil(ModalRoute.withName('/'));
                });

                return Container(
                  child: Text("Kirjaudutaan ulos..."),
                );
              }
            }));
  }
}

class SETNISHomePage extends StatefulWidget {
  SETNISHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SETNISHomePageState createState() => _SETNISHomePageState();
}

class _SETNISHomePageState extends State<SETNISHomePage> {
  bool userIsLoggedIn = false;
  bool loaded = false;

  void setUserLoggedIn(bool isLoggedIn) {
    setState(() {
      userIsLoggedIn = isLoggedIn;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!loaded) {
      Provider.of<AppStateModel>(context).getCurrentEvents();
      loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          appBarLoginAction(context),
          appBarViewAction(context),
          appBardEditAction(context),
        ],
      ),
      body: Container(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            constraints: constraints,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: loginButton(context),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AvailableEventsWidget(
                        events: Provider.of<AppStateModel>(context).events),
                  ],
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: viewButton(context),
                      ),
                      Expanded(
                        child: writeButton(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  RaisedButton writeButton(BuildContext context) {
    return RaisedButton(
      child: Text('Lisää kohde'),
      onPressed: Provider.of<AppStateModel>(context).isLoggedIn &&
              Provider.of<AppStateModel>(context).currentEvent != null
          ? () {
              Navigator.pushNamed(context, '/additem');
            }
          : null,
    );
  }

  RaisedButton viewButton(BuildContext context) {
    return RaisedButton(
      child: Text(
        'Katselu',
      ),
      onPressed: Provider.of<AppStateModel>(context).currentEvent != null
          ? () {
              Navigator.pushNamed(context, '/read');
            }
          : null,
    );
  }

  Consumer<AppStateModel> loginButton(BuildContext context) {
    return Consumer<AppStateModel>(
        builder: (_, appState, __) => RaisedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, appState.isLoggedIn ? '/logout' : '/login');
              },
              child: Text(
                appState.isLoggedIn ? 'Kirjaudu ulos' : 'Kirjaudu sisään',
              ),
            ));
  }

  GestureDetector appBarViewAction(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/read');
      },
      child: Icon(
        Icons.remove_red_eye,
        color: Colors.white,
        size: 24.0,
        semanticLabel: 'Katsele tietoja',
      ),
    );
  }

  GestureDetector appBardEditAction(BuildContext context) {
    return GestureDetector(
      onTap: this.userIsLoggedIn
          ? () {
              Navigator.pushNamed(context, '/additem');
            }
          : null,
      child: Icon(
        Icons.add,
        color: Provider.of<AppStateModel>(context).isLoggedIn
            ? Colors.blue
            : Colors.grey,
        size: 24.0,
        semanticLabel: 'Lisää tietoja',
      ),
    );
  }

  Consumer<AppStateModel> appBarLoginAction(BuildContext context) {
    return Consumer<AppStateModel>(
        builder: (_, appState, __) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, appState.isLoggedIn ? '/logout' : '/login');
            },
            child: Icon(
              appState.isLoggedIn ? Icons.lock : Icons.lock_open,
              color: Colors.white,
              size: 24.0,
              semanticLabel:
                  appState.isLoggedIn ? 'Kirjaudu ulos' : 'Kirjaudu sisään',
            )));
  }
}

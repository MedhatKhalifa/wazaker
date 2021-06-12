import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wazaker/db/dbhelper.dart';
import 'package:wazaker/models/tables.dart';
import 'package:bouncing_widget/bouncing_widget.dart';

import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:wazaker/pages/common/theappbar.dart';
import 'package:wazaker/pages/zekr/appbar_zekr.dart';

import 'package:wazaker/redux/state/app_state.dart';
import 'package:wazaker/size_config.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Zekr2 extends StatefulWidget {
  final void Function() onInit;
  Zekr2({this.onInit});
  @override
  _Zekr2State createState() => _Zekr2State();
}

class _Zekr2State extends State<Zekr2> {
  DbHelper helper;
  List<Azkar> _listofazkar = [];
  bool _loading;
  double _fontsize;

  @override
  initState() {
    _loading = true;
    super.initState();
    helper = DbHelper();

    _fontsize = 22;
  }

  bool selected = false;

  Widget _buttonG(index) {
    return BouncingWidget(
      duration: Duration(microseconds: 1),
      scaleFactor: 2,
      onPressed: () {
        setState(() {
          if (_listofazkar[index].totalCount > 0) {
            _listofazkar[index].totaltotal = _listofazkar[index].totalCount - 1;
          }
        });
      },
      child: Center(
        child: Container(
          color: _listofazkar[index].totalCount == 0
              ? Colors.blueGrey[700]
              : Colors.blue[900],
          height: h(7),
          alignment: Alignment.center,
          child: Text(
            '${_listofazkar[index].totalCount.toString()}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _verticalListView() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        //height: h(90),
        child: ListView.builder(
          // shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _listofazkar.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.0,
              child: Container(
                  decoration: BoxDecoration(
                    color: _listofazkar[index].totalCount == 0
                        ? Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey
                            : Colors.grey[300]
                        : Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text('${_listofazkar[index].pre}'),
                      Text(
                        '${_listofazkar[index].content}',
                        style: TextStyle(
                            fontSize: sp(_fontsize),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                      ),
                      Text('${_listofazkar[index].after}'),
                      Text('${_listofazkar[index].fadl}'),
                      _buttonG(index),
                    ],
                  )),
            );
          },
        ),
      ),
    );
  }

  _incrementCounter() async {
    if (_fontsize < 40) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var x = prefs.getDouble('counter');
      print(x);
      if (x != null) {
        double counter = (prefs.getDouble('counter')) + 1;
        await prefs.setDouble('counter', counter);
        setState(() {
          _fontsize = counter;
        });
      } else {
        double counter = 23.0;
        await prefs.setDouble('counter', counter);
        setState(() {
          _fontsize = counter;
        });
      }
    }
  }

  _decrementCounter() async {
    if (_fontsize > 15) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var x = prefs.getDouble('counter');
      if (x != null) {
        double counter = (prefs.getDouble('counter') ?? 0) - 1;
        print('Pressed $counter times.');
        await prefs.setDouble('counter', counter);
        setState(() {
          _fontsize = counter;
        });
      } else {
        double counter = 21;
        await prefs.setDouble('counter', counter);
        setState(() {
          _fontsize = counter;
        });
      }
    }
  }

  void filldata(snapshot, state) {
    if (_listofazkar.length == 0) {
      for (var _data in snapshot.data) {
        Azkar zekr = Azkar.fromMap(_data);
        _listofazkar.add(zekr);
        if (_listofazkar.length > 1) {
          state.inloading.user = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              // to increase appbar size
              preferredSize: Size.fromHeight(60.0),
              child: StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    return AppBar(
                      //leading: Icon(Icons.menu),
                      centerTitle: true,
                      leading: IconButton(
                        icon: Theme.of(context).brightness == Brightness.dark
                            ? Icon(Icons.light_mode)
                            : Icon(Icons.dark_mode),
                        tooltip: 'Show Snackbar',
                        onPressed: () {
                          if (Theme.of(context).brightness == Brightness.dark) {
                            print(Theme.of(context).brightness);
                            EasyDynamicTheme.of(context).changeTheme();
                            print(Theme.of(context).brightness);
                            if (Theme.of(context).brightness ==
                                Brightness.dark) {
                              EasyDynamicTheme.of(context).changeTheme();
                            }
                          } else {
                            EasyDynamicTheme.of(context).changeTheme();
                          }
                        },
                      ),
                      actions: [
                        IconButton(
                            icon: Icon(Icons.zoom_in),
                            onPressed: () {
                              _incrementCounter();
                            }),
                        IconButton(
                            icon: Icon(Icons.zoom_out),
                            onPressed: () {
                              _decrementCounter();
                            })
                      ],

                      title: Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                {Navigator.pushNamed(context, '/home')},
                            child: SvgPicture.asset(
                              "assets/images/logosvg.svg",
                              width: 50,
                              height: 50,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      backgroundColor: Theme.of(context).primaryColor,
                    );
                  })),
          backgroundColor: Colors.blueGrey[300],
          // appBar: theappBar(context),
          // drawer: Thedrawer(),
          body: FutureBuilder(
              future: helper.allCourses(arguments['categoryy']),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && _listofazkar.length == 0) {
                  filldata(snapshot, state);
                }

                return !(snapshot.hasData) ||
                        (_listofazkar.length == 0) ||
                        (_listofazkar == null) ||
                        state.inloading.user
                    ? Container(
                        child: Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).accentColor)),
                      ))
                    : _verticalListView();
              }),
        );
      },
    ));
  }
}

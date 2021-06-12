import 'package:wazaker/db/dbhelper.dart';
import 'package:wazaker/models/tables.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wazaker/pages/common/theappbar.dart';
import 'package:wazaker/pages/common/thedrawer.dart';

import 'package:wazaker/redux/state/app_state.dart';
import 'package:wazaker/size_config.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Sebha extends StatefulWidget {
  final void Function() onInit;
  Sebha({this.onInit});
  @override
  _SebhaState createState() => _SebhaState();
}

class _SebhaState extends State<Sebha> {
  DbHelper helper;
  Azkar thezekr;
  int _selected_item, _currentcount, _historyCount;
  String _showtext, _selectedzekr;
  Azkar _targetZekr;
  List<int> _shape = [];
  List<String> _zekrcontent = [];

  @override
  void initState() {
    _selected_item = 0;
    _currentcount = 0;
    _showtext = '';
    _historyCount = 0;

    super.initState();
    helper = DbHelper();
  }

  showAlertDialog(BuildContext context, _zekr) {
    // set up the buttons
    Widget okButton = FlatButton(
      child: Text(
        "نعم",
        style: (TextStyle(color: Colors.red)),
      ),
      onPressed: () {
        setState(() {
          _currentcount = 0;
        });
        _zekr.currenttotal = _currentcount;
        helper.updateZekr(_zekr);
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // Widget launchButton = FlatButton(
    //   child: Text("Launch missile"),
    //   onPressed: () {},
    // );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تأكيد"),
      content: Text("هل أنت متأكد من تصفير العدد الحالى"),
      actions: [
        okButton,
        cancelButton,
        // launchButton,
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

  Widget _sebha_form() {
    // Azkar _zekr = Azkar.fromMap(_data[_selected_item]);
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        if (_showtext != '')
          FittedBox(
            child: Text(_showtext,
                style: TextStyle(fontFamily: 'sebhafont', fontSize: 40)),
          ),
        _historyCount > 0 ? Text('العدد التراكمى ${_historyCount}') : Text(''),
        Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('العدد الحالى ', style: TextStyle(fontSize: 25)),
          _header('${_currentcount}')
        ]),
        Align(
          alignment: Alignment.centerRight,
          child: RawMaterialButton(
            onPressed: () {
              showAlertDialog(context, thezekr);
              // setState(() {
              //   _currentcount = 0;
              // });
              // _zekr.currenttotal = _currentcount;
              // helper.updateZekr(_zekr);
            },
            elevation: 2.0,
            fillColor: Colors.green,
            child: Text('تصفير العدد'),
            padding: EdgeInsets.all(15.0),
            //shape: CircleBorder(),
          ),
        ),
        BouncingWidget(
          duration: Duration(microseconds: 1),
          scaleFactor: 2,
          onPressed: () {
            setState(() {
              _currentcount = _currentcount + 1;
              _historyCount = _historyCount + 1;
              thezekr.currenttotal = _currentcount;
              thezekr.totaltotal = _historyCount;
              print(thezekr.content);
              print(thezekr.currentCount);
              print(thezekr.totalCount);
              helper.updateZekr(thezekr);
            });
          },
          child: Image(
            image: AssetImage('assets/images/moon.png'),
            height: h(50),
            width: h(50),
          ),
        )
      ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          //backgroundColor: Colors.white,
          appBar: theappBar(context),
          //drawer: Thedrawer(),
          body: FutureBuilder(
              future: helper.allsebhazekr(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData &&
                    _zekrcontent != [] &&
                    _zekrcontent.length == 0) {
                  snapshot.data.forEach((element) {
                    Azkar _zekr = Azkar.fromMap(element);
                    _zekrcontent.add(_zekr.content);
                  });
                }

                return !snapshot.hasData
                    ? Container(
                        child: Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).accentColor)),
                      ))
                    : Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: h(100),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.dstATop),
                                image: AssetImage("assets/images/sky.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: <Widget>[
                                new SizedBox(height: 20.0),
                                new Container(
                                  child: new ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return new Column(
                                        children: <Widget>[
                                          //Text('${zekr.content}'),
                                          // _horizontalListView(
                                          //     snapshot.data, 'service'),

                                          //_maincategory(context),
                                          // Divider(),
                                          //

                                          InputDecorator(
                                            decoration: InputDecoration(
                                              labelText: 'أختار الذكر',
                                              labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              border:
                                                  const OutlineInputBorder(),
                                            ),
                                            child: DropdownSearch<String>(
                                              mode: Mode.MENU,
                                              //showSelectedItem: false,
                                              //popupBarrierColor: Colors.red,
                                              items: _zekrcontent == []
                                                  ? [""]
                                                  : _zekrcontent,
                                              //label: "اختار الذكر",

                                              //hint: "country in menu mode",
                                              onChanged: (String data) {
                                                setState(() {
                                                  _selected_item = _zekrcontent
                                                      .indexWhere((note) =>
                                                          note.startsWith(
                                                              data)); // 1

                                                  thezekr = Azkar.fromMap(
                                                      snapshot.data[
                                                          _selected_item]);

                                                  print(thezekr.content);
                                                  _showtext = thezekr.content;
                                                  if (thezekr.currentCount !=
                                                      null)
                                                    _currentcount =
                                                        thezekr.currentCount;
                                                  if (thezekr.totalCount !=
                                                      null)
                                                    _historyCount =
                                                        thezekr.totalCount;
                                                });
                                              },

                                              //selectedItem: "Brazil"
                                            ),
                                          ),
                                          _sebha_form(),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              }),
        );
      },
    ));
  }
}

Widget _header(str) {
  return Container(
      child: Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(str,
          style: new TextStyle(
              fontSize: 30.0, color: Colors.red, fontWeight: FontWeight.bold)),
    ),
  ));
}

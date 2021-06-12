import 'package:wazaker/db/dbhelper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:wazaker/models/tables.dart';

import 'package:wazaker/pages/common/theappbar.dart';

import 'package:wazaker/redux/state/app_state.dart';
import 'package:wazaker/size_config.dart';

class AzkarSelection extends StatefulWidget {
  final void Function() onInit;
  AzkarSelection({this.onInit});
  @override
  _AzkarSelectionState createState() => _AzkarSelectionState();
}

class _AzkarSelectionState extends State<AzkarSelection> {
  DbHelper helper;
  List<dynamic> _listofazkar = [];
  bool _loading;
  @override
  initState() {
    _loading = true;
    super.initState();
    helper = DbHelper();
  }

  List<String> categories = [
    'السبحه',
    'أذكار المسلم',
    'أهم التطبيقات الإسلامية',
  ];

  void filldata(snapshot, state) {
    if (_listofazkar.length == 0) {
      for (var _data in snapshot.data) {
        if (Azkar.fromMap(_data).category != 'السبحه')
          _listofazkar.add(Azkar.fromMap(_data).category);
        if (_listofazkar.length > 1) {
          state.inloading.user = false;
        }
      }
    }
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
                future: helper.allcategory(),
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
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(snapshot.data);

                            for (var _data in snapshot.data) {
                              print(Azkar.fromMap(_data).category);
                            }
                            return Column(
                              children: <Widget>[
                                // _header('أذكارى'),

                                _mygrid(_listofazkar),
                                //Text('${zekr.category}'),
                                //_maincategory(context),
                                Divider(),
                                //_header('Service'),
                                // _horizontalListView(
                                //     state.serviceProducts, 'service'),
                                //new SizedBox(height: h(1)),
                                //Divider(),
                              ],
                            );
                          },
                        );
                }),
          );
        }));
  }
}

Widget _mygrid(data) {
  return Container(
    height: h(90),
    child: GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: w(1),
          mainAxisSpacing: h(1),
          childAspectRatio: ((w(100) / 2)) / (h(100) / 4)),
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            if (data[i] == "السبحه") {
              Navigator.pushNamed(context, '/sebha');
            } else {
              Navigator.pushNamed(context, '/zekr',
                  arguments: {'categoryy': data[i], 'index': 1000});
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue[200], width: 5.0)),
              child: Center(
                  child: Text('${data[i]}',
                      style: TextStyle(fontFamily: 'myarabic')))),
        );
      },
    ),
  );
}

Widget _header(str) {
  return Container(
      child: Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Center(
        child: Text(str,
            style: new TextStyle(
                fontSize: 18.0,
                color: Colors.red,
                fontWeight: FontWeight.bold)),
      ),
    ),
  ));
}

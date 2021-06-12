import 'package:flutter_svg/svg.dart';
import 'package:wazaker/db/dbhelper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:wazaker/pages/common/theappbar.dart';

import 'package:wazaker/redux/state/app_state.dart';
import 'package:wazaker/size_config.dart';

class HomePage extends StatefulWidget {
  final void Function() onInit;
  HomePage({this.onInit});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [
    // 'أذكارالصباح',
    // 'أذكار المساء',
    'السبحه',
    'أذكار المسلم',
    // 'أهم التطبيقات الإسلامية',
  ];

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            //backgroundColor: Colors.white,
            appBar: theappBar(context),
            //drawer: Thedrawer(),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: h(2)),
                    Text(
                      'فَاذْكُرُونِي أَذْكُرْكُمْ',
                      style: TextStyle(
                        fontFamily: 'sebhafont',
                        fontWeight: FontWeight.bold,
                        height: h(0.4),
                        fontSize: sp(30.0),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(10.0, 10.0),
                              blurRadius: 3.0,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Theme.of(context).primaryColor
                                  : Colors.blueGrey[50]),
                        ],
                      ),
                    ),
                    // _header('فَاذْكُرُونِي أَذْكُرْكُمْ'),
                    SizedBox(height: h(2)),

                    _mygrid2(categories, context),
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
            ),
          );
        }));
  }
}

Widget _mygrid2(data, context) {
  return ListView(
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
                // Divider(),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/praying.svg",
                    width: 38,
                    height: 38,
                    //color: Colors.blueGrey,
                  ),
                  title: _header(data[1], context),
                  onTap: () {
                    if (data[1] == "السبحه") {
                      Navigator.pushNamed(context, '/sebha');
                    } else {
                      Navigator.pushNamed(context, '/azkarselection');
                      // Navigator.pushNamed(context, '/zekr',
                      //     arguments: {'categoryy': data[i], 'index': 1000});
                    }
                  },
                ),
                Divider(),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/icons/rosary.svg",
                    width: 38,
                    height: 38,
                    //color: Colors.white,
                  ),
                  title: _header(data[0], context),
                  onTap: () {
                    if (data[0] == "السبحه") {
                      Navigator.pushNamed(context, '/sebha');
                    } else {
                      Navigator.pushNamed(context, '/azkarselection');
                      // Navigator.pushNamed(context, '/zekr',
                      //     arguments: {'categoryy': data[i], 'index': 1000});
                    }
                  },
                ),

                new SizedBox(height: h(1)),
              ],
            );
          },
        ),
      ),
    ],
  );
}

Widget _mygrid(data, context) {
  return Container(
    height: h(90),
    child: GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: w(1),
          mainAxisSpacing: h(1),
          childAspectRatio: ((w(100) / 2)) / (h(100) / 8)),
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            if (data[i] == "السبحه") {
              Navigator.pushNamed(context, '/sebha');
            } else {
              Navigator.pushNamed(context, '/azkarselection');
              // Navigator.pushNamed(context, '/zekr',
              //     arguments: {'categoryy': data[i], 'index': 1000});
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue, width: 5.0)),
              child: Column(children: [
                Center(
                    child: Text('${data[i]}',
                        style: TextStyle(fontFamily: 'myarabic'))),
              ])),
        );
      },
    ),
  );
}

Widget _header(str, context) {
  return Container(
      child: Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Center(
        child: Text(str,
            style: new TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.greenAccent
                    : Colors.blueGrey[400],
                fontWeight: FontWeight.bold)),
      ),
    ),
  ));
}

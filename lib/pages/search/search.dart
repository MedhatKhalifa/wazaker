import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:http/http.dart' as http;
import 'package:wazaker/db/dbhelper.dart';
import 'package:wazaker/models/tables.dart';

import 'package:wazaker/redux/state/app_state.dart';
import 'package:wazaker/size_config.dart';

class SearchPage extends StatefulWidget {
  final String senttext;
  SearchPage({this.senttext});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _filter = new TextEditingController();
  bool isSearching = false;
  String _search_text;
  DbHelper helper;
  List<Azkar> _listofazkar = [];
  bool _loading;
  @override
  initState() {
    _listofazkar = [];
    _loading = true;
    super.initState();
    helper = DbHelper();
  }

  // Future<void> _filterProducts(value) async {
  //   http.Response response =
  //       await http.post(product_url, body: {'key_word': value});
  //   final List<dynamic> responseData = json.decode(response.body);
  //   List<Product> products = [];

  //   responseData.forEach((productData) {
  //     final Product product = Product.fromJson(productData);
  //     products.add(product);
  //   });

  //   filteredproducts = products;
  // }

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
                    border: Border.all(color: Colors.blue, width: 5.0)),
                child: Center(
                    child: Text('${data[i]}',
                        style: TextStyle(fontFamily: 'myarabic')))),
          );
        },
      ),
    );
  }

  void filldata(snapshot, state) async {
    if (_listofazkar.length == 0) {
      for (var _data in snapshot) {
        _listofazkar.add(Azkar.fromMap(_data));

        if (_listofazkar.length > 1) {
          state.inloading.user = false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          final Map arguments =
              ModalRoute.of(context).settings.arguments as Map;
          if (arguments != null) {
            _search_text = arguments['senttext'];
            // _listofazkar = searchproduct(state.products, _search_text);

            if (_search_text != "" && _search_text != null) {
              print(helper.searchcontent(_search_text));
              filldata(helper.searchcontent(_search_text), state);
            }
          }

          return Scaffold(
            appBar: AppBar(
              // iconTheme: IconThemeData(
              //   color: Colors.black, //change your color here
              // ),
              // backgroundColor: Colors.white,
              title: Container(
                height: h(7),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: _filter,
                  onSubmitted: (value) {
                    _search_text = value;
                    Navigator.popAndPushNamed(context, '/search',
                        arguments: {'senttext': value});
                  },
                  // style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.search),
                      // fillColor: Colors.grey[300],
                      filled: true,
                      hintText: _search_text != null && _search_text != ''
                          ? _search_text
                          : "......ادخل جزء من الذكر ......",
                      // hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      )),
                ),
              ),
            ),
            body: arguments == null
                ? Container(
                    child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor)),
                  ))
                : _search_text == ''
                    ? Center(child: Text('من فضلك ادخل جزء من الحديث المطلوب'))
                    : _listofazkar.length == 0 && arguments != null
                        ? Container(
                            child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Center(
                                    child: RichText(
                                        text: TextSpan(
                                  text:
                                      "للأسف لا يوجد نتائج , من فضلك اعد البحث بكلمة أخرى عن    ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).errorColor),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '$_search_text',
                                        style: TextStyle(
                                            color: Color(0xffe83636))),
                                  ],
                                )))))
                        : _mygrid(_listofazkar),
          );
        });
  }
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

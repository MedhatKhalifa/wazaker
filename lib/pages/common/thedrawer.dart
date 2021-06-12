import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';

import 'package:wazaker/redux/state/app_state.dart';

class Thedrawer extends StatefulWidget {
  @override
  _ThedrawerState createState() => _ThedrawerState();
}

class _ThedrawerState extends State<Thedrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                      child: Text('Welcome ',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/pet-grooming.svg",
                      width: 38,
                      height: 38,
                    ),
                    title: Text('Serivce'),
                    onTap: () {
                      Navigator.pushNamed(context, '/products',
                          arguments: {'thetarget': 'service'});
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/pet-hotel-signal.svg",
                      width: 38,
                      height: 38,
                    ), // Image.asset('assets/icons/dog.svg'),
                    title: Text('Dog'),
                    onTap: () {
                      Navigator.pushNamed(context, '/products',
                          arguments: {'thetarget': 'dog'});
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/cat (1).svg",
                      width: 38,
                      height: 38,
                    ), // Image.asset('assets/icons/dog.svg'),
                    title: Text('cat'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pushNamed(context, '/products',
                          arguments: {'thetarget': 'cat'});
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/like.svg",
                      width: 30,
                      height: 30,
                    ), // Image.asset('assets/icons/dog.svg'),
                    title: Text('Best Selling'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pushNamed(context, '/products',
                          arguments: {'thetarget': 'bestsell'});
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/contacts.svg",
                      width: 30,
                      height: 30,
                    ), // Image.asset('assets/icons/dog.svg'),
                    title: Text('Contact us'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pushNamed(
                        context,
                        '/contactus',
                      );
                    },
                  )
                ],
              ),
            );
          }),
    );
  }
}

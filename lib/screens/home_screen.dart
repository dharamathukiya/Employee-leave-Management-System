import 'dart:ui';

import 'package:elms/screens/add_leave.dart';
import 'package:elms/screens/all_leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_navbar/flutter_side_navbar.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('abc'),
            accountEmail: Text('abc@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/logo.png",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.time_to_leave),
              title: Text("Add Leave"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddLeave()));
              }),
          ListTile(
            leading: Icon(Icons.time_to_leave),
            title: Text("All Leave"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AllLeave()));
            },
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "HomeScreen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

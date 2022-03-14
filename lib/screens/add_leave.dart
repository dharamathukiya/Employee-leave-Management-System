import 'dart:ffi';

import 'package:elms/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('items');

class AddLeave extends StatefulWidget {
  @override
  _AddLeaveState createState() => _AddLeaveState();
}

class _AddLeaveState extends State<AddLeave> {
  final TextEditingController reasonController = new TextEditingController();
  DateTime? date;
  DateTime? date1;

  String getText() {
    if (date == null) {
      return 'From Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  String getText1() {
    if (date1 == null) {
      return 'Until Date';
    } else {
      return DateFormat('MM/dd/yyyy').format(date1!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  Usermodel loggedInUser = Usermodel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = Usermodel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Leave"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "From Date:",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      child: ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RaisedButton(
                              child: Text(getText()),
                              onPressed: () => pickDate(context))
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Text(
                        "Until Date:",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      child: RaisedButton(
                          onPressed: () => pickDate1(context),
                          child: Text(getText1())),
                    ),
                    //SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Reason",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
                SizedBox(height: 10),
                Container(
                    child: TextFormField(
                  maxLines: 3,
                  controller: reasonController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )),
                SizedBox(height: 15),
                Container(
                  child: RaisedButton(
                    onPressed: () async {
                      DocumentReference documentReference =
                          _mainCollection.doc();
                      Map<String, dynamic> data = <String, dynamic>{
                        "FromDate": date.toString(),
                        "UntilDate": date1.toString(),
                        "Reason": reasonController.text,
                        "Status": "Pandding",
                        "uid": user!.uid,
                      };
                      await documentReference
                          .set(data)
                          .whenComplete(
                              () => print("Notes Item added to the database"))
                          .then((value) => Navigator.of(context).pop())
                          .catchError((e) => print(e));
                    },
                    child: Text("Add Leave"),
                  ),
                ),
                SizedBox(height: 10),
                Text("${loggedInUser.firstName} ",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    )),
                Text("${loggedInUser.email}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
        ),
      ),
    );

    // ignore: dead_code
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;

    setState(() => date = newDate);
  }

  Future pickDate1(BuildContext context) async {
    final initialDate1 = DateTime.now();
    final newDate1 = await showDatePicker(
      context: context,
      initialDate: date1 ?? initialDate1,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate1 == null) return;

    setState(() => date1 = newDate1);
  }
}

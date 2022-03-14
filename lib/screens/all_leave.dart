import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllLeave extends StatelessWidget {
   AllLeave({Key? key}) : super(key: key);
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Leave"),
        centerTitle: true,
      ),

       body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('Leave').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data.docs.map((doc) {
                var s = 'UntilDate';
                return Card(
                  child: ListTile(
                    title: Text(doc.data().['title']),
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}

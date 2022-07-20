import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todosapp/getx/myhomepage.dart';



class MyAlertPage extends StatefulWidget {
  const MyAlertPage({
    Key? key,
    this.id,
  }) : super(key: key);
  final String? id;

  @override
  State<MyAlertPage> createState() => _MyAlertPageState();
}

class _MyAlertPageState extends State<MyAlertPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(
            width: double.infinity,
            child: Text(
              'Are You sure you want to delete?',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: '',
                          )));
              FirebaseFirestore.instance
                  .collection('task')
                  .doc(widget.id)
                  .delete();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.black),
            )),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: '',
                          )));
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }
}

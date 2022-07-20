import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:todosapp/getx/myalertpage.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('task').snapshots(),
            builder: (context, snapshort) {
              if (snapshort.connectionState == ConnectionState.waiting) {
                return  const Center(child: CircularProgressIndicator());
              }
              if (snapshort.hasData) {
                return ListView.builder(
                    itemCount: snapshort.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = snapshort.data!.docs[index];
                      return ListTile(
                        title: Text(doc['food']),
                        trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    child: const Text('Edit'),
                                    
                                    onTap: () {
                                      // var res = showDialog(context: context, builder: (context) => MyAlertPage1(id: doc.id));
                                      FirebaseFirestore.instance
                                          .collection('task')
                                          .doc(doc.id)
                                          .update({'food': faker.food.dish()});
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: TextButton(
                                        onPressed: () {
                                          
                                          var res = showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  MyAlertPage(id: doc.id));
                                        },
                                        child:const Text(
                                          'Delete',
                                          style: TextStyle(fontSize: 15,color: Colors.black),
                                        )),
                                  )
                                ]),
                      );
                    });
              }
              return const SizedBox();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('task')
              .add({'food': faker.food.dish()});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

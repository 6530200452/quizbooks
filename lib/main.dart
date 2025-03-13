import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import './addForm.dart';
import './updateForm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int screenIndex = 0;

  final mobileScreens = [home(), search()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(200, 230, 201, 1),
        title: Center(
          child: Text(
            'Example Firestore',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: mobileScreens[screenIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            screenIndex = 1;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addForm()),
          ).then((_) {
            setState(() {
              screenIndex = 0;
            });
          });
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.green[700],
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromRGBO(99, 136, 137, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  screenIndex = 0;
                });
              },
              icon: Icon(
                Icons.home,
                color: screenIndex == 0 ? Colors.green[900] : Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  screenIndex = 1;
                });
              },
              icon: Icon(
                Icons.search,
                color: screenIndex == 1 ? Colors.green[900] : Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.widgets, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green[50],
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  CollectionReference postCollection = FirebaseFirestore.instance.collection(
    'Books',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: postCollection.snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                var postIndex = snapshot.data!.docs[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {},
                          backgroundColor: Colors.blue,
                          icon: Icons.share,
                          label: 'แชร์',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => updateForm(),
                                settings: RouteSettings(arguments: postIndex),
                              ),
                            );
                          },
                          backgroundColor: Colors.green,
                          icon: Icons.edit,
                          label: 'แก้ไข',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            postCollection.doc(postIndex.id).delete();
                          },
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: 'ลบ',
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        postIndex['Name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
                      ),
                      subtitle: Text(postIndex['Author']),
                    ),
                  ),
                );
              }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}

class search extends StatelessWidget {
  const search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Search',
          style: TextStyle(fontSize: 20, color: Colors.green[900]),
        ),
      ),
      backgroundColor: Colors.green[50],
    );
  }
}

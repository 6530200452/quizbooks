import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addForm extends StatefulWidget {
  @override
  State<addForm> createState() => _addFormState();
}

class _addFormState extends State<addForm> {
  final nameController = TextEditingController();
  final authorController = TextEditingController();
  final typeController = TextEditingController();

  CollectionReference postCollection =
      FirebaseFirestore.instance.collection('Books');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(200, 230, 201, 1), // เขียวอ่อน
        title: Center(
          child: Text(
            'Example',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                Text(
                  'New Post',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green[700]),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Add Name',
                          icon: Icon(Icons.book, color: Colors.green[800]),
                          border: InputBorder.none,
                        ),
                      ),
                      Divider(color: Colors.green[300]),
                      TextFormField(
                        controller: authorController,
                        decoration: InputDecoration(
                          hintText: 'Add Author',
                          icon: Icon(Icons.person, color: Colors.green[800]),
                          border: InputBorder.none,
                        ),
                      ),
                      Divider(color: Colors.green[300]),
                      TextFormField(
                        controller: typeController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Add Type',
                          icon: Icon(Icons.description, color: Colors.green[800]),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    postCollection.add({
                      'Name': nameController.text,
                      'Author': authorController.text,
                      'Type': typeController.text
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Post', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.green[50], // เขียวอ่อนแบบพาสเทล
    );
  }
}
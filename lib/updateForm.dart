import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class updateForm extends StatefulWidget {
  @override
  State<updateForm> createState() => _updateFormState();
}

class _updateFormState extends State<updateForm> {
  CollectionReference postCollection = FirebaseFirestore.instance.collection(
    'Books',
  );

  @override
  Widget build(BuildContext context) {
    final postData = ModalRoute.of(context)!.settings.arguments as dynamic;

    final nameController = TextEditingController(text: postData['Name']);
    final authorController = TextEditingController(text: postData['Author']);
    final typeController = TextEditingController(text: postData['Type']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(99, 136, 137, 1),
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
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    postCollection.doc(postData.id).update({
                      'Name': nameController.text,
                      'Author': authorController.text,
                      'Type': typeController.text,
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

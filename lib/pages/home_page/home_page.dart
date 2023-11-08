import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_auth_crud/auth_pages/login_page.dart';
import 'package:my_firebase_auth_crud/services/firebase_services/firebase_auth_services/firbase_auth_service.dart';

import '../../services/toast_services/show_toast.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();



  void createData(){
    String studentName = _nameController.text;
    String studentEmail = _emailController.text;
    String studentAddress = _addressController.text;

    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
    Map<String,dynamic> students = {
      "studentName":studentName,
      "studentEmail":studentEmail,
      "studentAddress":studentAddress,
    };
    documentReference.set(students).whenComplete((){
      print('$studentName created');
    });
  }
  void readData(){
    String studentName = _nameController.text;
    String studentEmail = _emailController.text;
    String studentAddress = _addressController.text;

   DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
   documentReference.get().then((datasnapshot) {
     print(datasnapshot.get('studentName'));
     print(datasnapshot.get('studentEmail'));
     print(datasnapshot.get('studentAddress'));
   });
  }

  void updateData(){
    String studentName = _nameController.text;
    String studentEmail = _emailController.text;
    String studentAddress = _addressController.text;

    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    Map<String,dynamic> students = {
      "studentName":studentName,
      "studentEmail":studentEmail,
      "studentAddress":studentAddress,
    };

    documentReference.set(students).whenComplete((){
      print('$studentName updated');
    });
  }

  void deleteData(){
    String studentName = _nameController.text;
    DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);

    documentReference.delete().whenComplete(() {
      print('$studentName deleted');
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Home'),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInPage()), (route) => false);
            showToast(message: "User is successfully log out!!");
          }, icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Firebase CRUD',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),
            SizedBox(height: 30,),
           TextFormField(
             controller: _nameController,
             decoration: InputDecoration(
               labelText: 'Name',
               border: OutlineInputBorder()
             ),
           ),
            SizedBox(height: 30,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  createData();
                },
                    child: Text('Create',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    primary: Colors.green
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: (){
                  readData();
                },
                  child: Text('Read',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      primary: Colors.amber
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: (){
                  updateData();
                },
                  child: Text('Update',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      primary: Colors.lightGreen
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: (){
                  deleteData();
                },
                  child: Text('Delete',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      primary: Colors.redAccent
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("MyStudents")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                        DocumentSnapshot  documentSnapshot = snapshot.data!.docs[index];
                          return Row(
                            children: [
                              Expanded(
                                  child:
                                  Text(documentSnapshot.get('studentName'))),
                              Expanded(
                                  child:
                                  Text(documentSnapshot.get('studentEmail'))),
                              Expanded(
                                  child: Text(
                                      documentSnapshot.get('studentAddress'))),
                            ],
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),

          ],
        ),
      ),
    );
  }
}

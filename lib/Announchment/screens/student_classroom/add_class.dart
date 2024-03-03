import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/data/announcements.dart';
import 'package:student_management_system/Announchment/data/custom_user.dart';
import 'package:student_management_system/Announchment/services/classes_db.dart';
import 'package:student_management_system/Announchment/services/submissions_db.dart';
import 'package:student_management_system/Announchment/services/updatealldata.dart';
import 'package:student_management_system/constants.dart';
import 'package:student_management_system/screens/student_login_screen/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../animated_route_page.dart';
import '../loading.dart';

class JoinClass extends StatefulWidget {
  const JoinClass({super.key});

  @override
  _JoinClassState createState() => _JoinClassState();
}

class _JoinClassState extends State<JoinClass> {
  String className = "";

  // for form validation
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // build func
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    return loading ? Loading() : Scaffold(
      // appbar part
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.5,
        title: const Text(
          "Join Class",
          style: TextStyle(
              color: Colors.white, fontFamily: "Roboto", fontSize: 22),
        ),
      ),

      // body part
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Class Code",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    hintText: "Enter class Code",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (val) =>
                  val!.isEmpty ? 'Enter a class Code' : null,
                  onChanged: (val) {
                    setState(() {
                      className = val;
                    });
                  },
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await ClassesDB(user: user)
                          .updateStudentClasses(className);

                      // Store student UID and name in Firebase
                      final currentUser = FirebaseAuth.instance.currentUser;
                      if(currentUser != null) {
                        FirebaseFirestore.instance.collection('students').doc(currentUser.uid).set({
                          'uid': currentUser.uid,
                          'fulNname': currentUser.displayName ?? '',
                        });
                      }

                      for (int i = 0; i < announcementList.length; i++) {
                        if (announcementList[i].classroom.className ==
                            className &&
                            announcementList[i].type == "Assignment") {
                          await SubmissionDB().addSubmissions(user!.uid,
                              className, announcementList[i].title);
                        }
                      }
                      setState(() => loading = true);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              Icons.notifications_active_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Successfully Added",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 5), // Adjust the duration as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 6,
                        margin: EdgeInsets.all(20),
                      ));
                      await updateAllData();
                      loading = false;
                      Navigator.of(context).push(UniquePageRoute(builder: (_) => StudentHomeScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text("Join",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 22,
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

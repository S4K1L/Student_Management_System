import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/data/announcements.dart';
import 'package:student_management_system/Announchment/data/custom_user.dart';
import 'package:student_management_system/Announchment/services/classes_db.dart';
import 'package:student_management_system/Announchment/services/submissions_db.dart';
import 'package:student_management_system/Announchment/services/updatealldata.dart';
import 'package:student_management_system/screens/student_login_screen/home_screen/home_screen.dart';

class JoinClass extends StatefulWidget {
  const JoinClass({super.key});

  @override
  _JoinClassState createState() => _JoinClassState();
}

class _JoinClassState extends State<JoinClass> {
  String className = "";

  // for form validation
  final _formKey = GlobalKey<FormState>();

  // build func
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    return Scaffold(
        // appbar part
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, StudentHomeScreen.routeName);
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
                      decoration: const InputDecoration(
                          labelText: "Class Name",
                          border: OutlineInputBorder()),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a class name' : null,
                      onChanged: (val) {
                        setState(() {
                          className = val;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await ClassesDB(user: user)
                              .updateStudentClasses(className);

                          for (int i = 0; i < announcementList.length; i++) {
                            if (announcementList[i].classroom.className ==
                                    className &&
                                announcementList[i].type == "Assignment") {
                              await SubmissionDB().addSubmissions(user!.uid,
                                  className, announcementList[i].title);
                            }
                          }

                          await updateAllData();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const StudentHomeScreen(),
                            ),
                          );
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
                ))
          ],
        ));
  }
}

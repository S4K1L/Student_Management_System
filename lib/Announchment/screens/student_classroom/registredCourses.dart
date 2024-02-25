import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/data/accounts.dart';
import 'package:student_management_system/Announchment/data/classrooms.dart';
import 'package:student_management_system/Announchment/data/custom_user.dart';
import 'package:student_management_system/Announchment/screens/student_classroom/class_room_page.dart';
import 'package:student_management_system/constants.dart';

import '../../../screens/student_login_screen/home_screen/home_screen.dart';

class RegisteredCourses extends StatefulWidget {
  const RegisteredCourses({Key? key}) : super(key: key);

  @override
  _RegisteredCoursesState createState() => _RegisteredCoursesState();
}

class _RegisteredCoursesState extends State<RegisteredCourses> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    List _classRoomList =
    classRoomList.where((i) => i.students.contains(account)).toList();

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  const HomeScreen(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text('Registered Courses',style: TextStyle(color: kTextWhiteColor),),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemCount: _classRoomList.length,
        itemBuilder: (context, int index) {
          return Stack(
            children: [
              Container(
                height: 100,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(8.0)),
                  color: _classRoomList[index].uiColor,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 30),
                width: 220,
                child: Text(
                  _classRoomList[index].className,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 58, left: 30),
                child: Text(
                  _classRoomList[index].description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 80, left: 30),
                child: Text(
                  _classRoomList[index].creator.fullName! +
                      " " +
                      _classRoomList[index].className,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                    letterSpacing: 1,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

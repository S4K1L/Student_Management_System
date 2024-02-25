import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/data/custom_user.dart';
import 'package:student_management_system/Announchment/services/classes_db.dart';

import '../../screens/admin_login_screen/admin_home_screen/admin_home_screen.dart';

class AssignedCoursesPage extends StatelessWidget {
  const AssignedCoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  const FacultyHomeScreen(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text('Assigned Courses'),
      ),
      body: FutureBuilder<List?>(
        future: ClassesDB(user: user).createClassesDataList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError || snapshot.data == null) {
              return Center(child: Text('Error: Failed to fetch data'));
            } else {
              return _buildCoursesList(snapshot.data!);
            }
          }
        },
      ),
    );
  }

  Widget _buildCoursesList(List courses) {
    return Container(
      color: Colors.white, // Set body background color to white
      child: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          final uiColor = Color(int.parse(course['uiColor']));
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: uiColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Text(
                course['className'],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                course['description'],
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}

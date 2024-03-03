import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'attendance_page.dart';

class SelectCoursesPage extends StatefulWidget {
  const SelectCoursesPage({super.key});

  @override
  _SelectCoursesPageState createState() => _SelectCoursesPageState();
}

class _SelectCoursesPageState extends State<SelectCoursesPage> {
  String? selectedCourses;
  List<String> coursesList = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('courses').get();

      List<String> courses = [];

      querySnapshot.docs.forEach((doc) {
        String courseName = doc['className'];
        courses.add(courseName);
      });

      setState(() {
        coursesList = courses;
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Courses'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedCourses,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCourses = newValue;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentAttendancePage(
                      selectedCourses: newValue!
                    ),
                  ),
                );
              },
              items: coursesList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

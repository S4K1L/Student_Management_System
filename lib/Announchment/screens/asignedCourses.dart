import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../screens/admin_login_screen/admin_home_screen/admin_home_screen.dart';
import '../data/custom_user.dart';
import '../services/classes_db.dart';

class AssignedCoursesPage extends StatelessWidget {
  const AssignedCoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const FacultyHomeScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Assigned Courses',
          style: TextStyle(color: kTextWhiteColor),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: ClassesDB(user: user).getFacultyCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError || snapshot.data == null) {
              return Center(child: Text('Error: Failed to fetch data'));
            } else {
              return _buildCoursesList(context, snapshot.data!);
            }
          }
        },
      ),
    );
  }

  Widget _buildCoursesList(BuildContext context, List<Map<String, dynamic>> courses) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        final uiColor = Color(int.parse(course['uiColor']));
        final studentsJoined = course['studentsJoined'] ?? 0;

        return Card(
          color: uiColor, // Set the background color of the Card
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['className'],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  "Courses: ${course['description']}",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  'Students Joined: $studentsJoined',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            onTap: () {
              // Add any functionality you want when the ListTile is tapped
            },
          ),
        );
      },
    );
  }

}

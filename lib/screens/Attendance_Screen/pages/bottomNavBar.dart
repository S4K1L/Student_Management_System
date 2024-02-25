import 'package:flutter/material.dart';
import 'package:student_management_system/screens/Attendance_Screen/pages/profilepages/adminPage.dart';
import 'package:student_management_system/screens/Attendance_Screen/pages/reportpages/adminreport.dart';
import 'package:student_management_system/screens/Attendance_Screen/pages/reportpages/reportGenration.dart';

import '../../../constants.dart';
import 'attendencepages/attendencedropdown1.dart';
import 'detailspages/facultyScreen.dart';

final List<Widget> facultynavbar = [
  AttendenceDropdownPage1(),
  ReportGeneration(),
];

final List<Widget> adminnavbar = [
  AdminPage(),
  AdminReport(),
  FacultyPage(),
];

class LoginNavScreen extends StatefulWidget {
  const LoginNavScreen({ Key? key }) : super(key: key);

  @override
  _LoginNavScreenState createState() => _LoginNavScreenState();
}

class _LoginNavScreenState extends State<LoginNavScreen> {
  int currentfaculty = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: facultynavbar[currentfaculty],
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryColor,
        currentIndex: currentfaculty,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) => setState(() => currentfaculty = index),
        items: [
          BottomNavigationBarItem(
            // icon: Icon(Icons.support_agent),
            icon: Icon(Icons.assignment_outlined),
            label: 'Attendence',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log Out',
          ),
        ],
      ),
    );
  }
}


BottomNavigationBar BuildFacultyBottomNavBar(int currentindex) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: kPrimaryColor,
    currentIndex: currentindex,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
    onTap: (index) => {currentindex = index},
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.assignment_outlined),
        label: 'Attendence',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.description_outlined),
        label: 'Report',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        label: 'Profile',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.logout),
        label: 'Log Out',
      ),
    ],
  );
}

BottomNavigationBar BuildAdminBottomNavBar(int currentindex) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: kPrimaryColor,
    currentIndex: currentindex,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
    onTap: (index) => {currentindex = index},
    items: [
      BottomNavigationBarItem(
        // icon: Icon(Icons.support_agent),
        icon: Icon(Icons.local_police),
        label: 'Admin',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.description),
        label: 'Report',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.badge),
        label: 'Faculty',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.logout),
        label: 'Log Out',
      ),
    ],
  );
}

class AdminNavScreen extends StatefulWidget {
  const AdminNavScreen({ Key? key }) : super(key: key);

  @override
  _AdminNavScreenState createState() => _AdminNavScreenState();
}

class _AdminNavScreenState extends State<AdminNavScreen> {
int currentadmin = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: adminnavbar[currentadmin],
      bottomNavigationBar:BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: kPrimaryColor,
    currentIndex: currentadmin,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
    onTap: (index) => setState(() => currentadmin = index),
    items: [
      BottomNavigationBarItem(
        // icon: Icon(Icons.support_agent),
        icon: Icon(Icons.local_police),
        label: 'Admin',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.description),
        label: 'Report',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.badge),
        label: 'Faculty',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.logout),
        label: 'Log Out',
      ),
    ],
    )
  );
  }
}

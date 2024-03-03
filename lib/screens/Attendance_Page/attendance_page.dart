import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Announchment/services/accounts_db.dart';
import '../../constants.dart';

class StudentAttendancePage extends StatefulWidget {
  final String selectedCourses;

  const StudentAttendancePage({Key? key,required this.selectedCourses}) : super(key: key);

  @override
  _StudentAttendancePageState createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  AccountsDB _accountsDB = AccountsDB(); // Initialize AccountsDB
  List<DocumentSnapshot>? _students = []; // List of students from Firestore
  Map<String, bool> _attendance = {}; // Map to store attendance status

  @override
  void initState() {
    super.initState();
    _fetchStudents(); // Fetch student data when the page initializes
  }

  Future<void> _fetchStudents() async {
    try {
      // Retrieve list of student accounts from Firestore based on selected course
      List<DocumentSnapshot>? students = await _accountsDB.getStudentsByCourse(widget.selectedCourses);
      if (students != null) {
        setState(() {
          _students = students;
          // Initialize attendance map with default values (false for absent)
          _attendance = Map.fromIterable(
            _students!,
            key: (student) => student.id,
            value: (_) => false,
          );
        });
      } else {
        // Handle error or display appropriate message
      }
    } catch (e) {
      print('Error fetching students: $e');
      // Handle error or display appropriate message
    }
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text('Student Attendance'),
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: _students != null
          ? ListView.builder(
        itemCount: _students!.length,
        itemBuilder: (context, index) {
          String fullName = _students![index]['fullName'] ?? '';
          String email = _students![index]['email'] ?? '';
          String studentId = _students![index]['id'] ?? '';
          bool isPresent = _attendance[studentId] ?? false;
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                fullName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kTextWhiteColor,
                ),
              ),
              subtitle: Text(
                'ID: $studentId\nEmail: $email',
                style: TextStyle(
                    fontSize: 14,
                    color: kTextWhiteColor
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      _toggleAttendance(studentId, true);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isPresent ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Present',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      _toggleAttendance(studentId, false);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: !isPresent ? Colors.red : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Absent',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitAttendance,
        label: Text('Submit Attendance'),
        icon: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _toggleAttendance(String studentId, bool present) {
    setState(() {
      _attendance[studentId] = present;
    });
  }

  Future<void> _submitAttendance() async {
    try {
      // Example: Upload attendance data to a collection named 'attendance'
      CollectionReference attendanceRef =
      FirebaseFirestore.instance.collection('attendance');
      _attendance.forEach((studentId, present) async {
        await attendanceRef.doc(studentId).set({
          'date': DateTime.now(),
          'present': present,
          // You can add more details like 'class', 'subject', etc.
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Attendance submitted successfully'),
        ),
      );
    } catch (e) {
      print('Error submitting attendance: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit attendance. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
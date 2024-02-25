import 'package:flutter/material.dart';

import '../../../admin_login_screen/admin_home_screen/add_student/add_student.dart';
import '../../utils/names.dart';
import '../../utils/userPrefrences.dart';
import '../editpages/edit_student.dart';
import '../profilepages/adminPage.dart';

class StudentDetailsPage extends StatefulWidget {
  const StudentDetailsPage({Key? key}) : super(key: key);

  @override
  _StudentDetailsPageState createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
    final studentvar = UserPrefrences.studentlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>
                    AdminPage()),
          );
        },
            child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        title: Text("Student Details",style: TextStyle(color: Colors.white),),
      ),
      body:
          //Expanded(
          // child:
          Padding(
        padding: const EdgeInsets.all(8.0),
        child: new ListView.builder(
            itemCount:
            // 150, 
            studentvar.length,
            itemBuilder: (BuildContext context, int index) =>
                buildStudentDetailsCard(context, index)),
      ),
      // ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 150),
        child: FloatingActionButton.extended(
          onPressed: () {
   Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddStudent()),);
                },
          elevation: 15,
          label: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          // icon: const Icon(Icons.thumb_up),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  buildStudentDetailsCard(BuildContext context, int index) {
    var index2 = index+1;
    List<bool> isActive = StudentisActive;
    return Card(
      elevation: 5,
      shadowColor: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(index2.toString()),
                // SizedBox(
                //   width: 10,
                // ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                      studentvar[index].studentEnrollmentNo,
                      // Enrollment[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Text(
                        studentvar[index].studentName,
                        // Students[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0,color: Colors.black),
                      ),
                      Text(
                        studentvar[index].studentemail,
                        // StudentEmail[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13.0,color: Colors.black),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text("Remove"),
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.white,
                //     onPrimary: Colors.grey[600],
                //   ),
                // ),
                Column(
                  children: [
                    Text("Status",style: TextStyle(
                      color: Colors.black,
                    ),),
                    Switch(
                value: isActive[index],
                onChanged: (bool newValue) {
                  setState(() {
                    isActive[index] = !isActive[index];
                  });
                },
              ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Program : " + studentvar[index].program,style: TextStyle(fontSize: 13,color: Colors.black),),
                      Text("Batch : " + studentvar[index].batch,style: TextStyle(fontSize: 13,color: Colors.black),)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Branch : " + studentvar[index].department,style: TextStyle(fontSize: 13,color: Colors.black),),
                      Text("Semester : " + studentvar[index].semester,style: TextStyle(fontSize: 13,color: Colors.black),)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Year : " + studentvar[index].studingInYear,style: TextStyle(fontSize: 13,color: Colors.black),),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                   Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditStud()),
                   );
              },
              child: Text("Edit"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.grey[600],
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  fixedSize: Size(200, 40),
                  elevation: 5,
                  textStyle: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500)),
            )
          ],
        ),
      ),
    );
  }

 
}

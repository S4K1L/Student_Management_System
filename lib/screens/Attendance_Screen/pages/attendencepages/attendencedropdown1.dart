import 'package:flutter/material.dart';

import '../../../admin_login_screen/admin_home_screen/admin_home_screen.dart';
import '../../utils/names.dart';
import '../../widgets/dropDownWidget.dart';
import 'attendencedropdownpage2.dart';


class AttendenceDropdownPage1 extends StatefulWidget {
  static String routeName = 'AttendenceDropdownPage1';

  const AttendenceDropdownPage1({Key? key}) : super(key: key);

  @override
  _AttendenceDropdownPage1State createState() =>
      _AttendenceDropdownPage1State();
}

class _AttendenceDropdownPage1State extends State<AttendenceDropdownPage1> {
  @override
  Widget build(BuildContext context) {
    // String programdropdownValue = Program[0];
    // String branchdropdownValue = Branch[0];
    // String schooldropdownValue = School[0];
    // String semdropdownValue = Semester[0];
    // String yeardropdownValue = CollegeYear[0];

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) =>
                        const FacultyHomeScreen()),
              );
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          "Attendance",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                dropdown(
                  DropdownValue: programdropdownValue,
                  Hint: "Program",
                  sTring: Programe,
                ),
                SizedBox(
                  height: 20,
                ),
                dropdown(
                    DropdownValue: departmentdropdownValue,
                    Hint: "Department",
                    sTring: Department),
                SizedBox(
                  height: 20,
                ),
                dropdown(
                    DropdownValue: yeardropdownValue,
                    sTring: CollegeYear,
                    Hint: "Year"),
                SizedBox(
                  height: 20,
                ),
                // dropdownButton(batchdropdownValue,Batch,"Batch"),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => AttendenceDropdownpage2()),
                    );
                  },
                  child: Text("Next"),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 60),
                      primary: Colors.grey[100],
                      onPrimary: Colors.black,
                      elevation: 10,
                      textStyle: TextStyle(fontSize: 20)),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

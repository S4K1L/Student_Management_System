import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/screens/admin_login_screen/admin_home_screen/admin_home_screen.dart';

import '../../data/custom_user.dart';
import '../../services/classes_db.dart';
import '../../services/updatealldata.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});


  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {

  String className = "";
  String description = "";
  Color uiColor = Colors.blue;
  Color _tempShadeColor = Colors.blue;

  // for form validation
  final _formKey = GlobalKey<FormState>();

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: Navigator.of(context).pop,
            ),
            TextButton(
              child: Text('Select'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => uiColor = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker() async {
    _openDialog(
      "Color picker",
      MaterialColorPicker(
        selectedColor: uiColor,
        onColorChange: (color) => setState(() => _tempShadeColor = color)
      ),
    );
  }

  // build func
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

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
          backgroundColor: Colors.blue,
          elevation: 0.5,
          title: Text(
            "New semester Courses",
            style: TextStyle(
                color: Colors.white, fontFamily: "Roboto", fontSize: 22),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration: InputDecoration(labelText: "Courses Name with Code", border: OutlineInputBorder()),
                      validator: (val) => val!.isEmpty ? 'Enter Courses Name with Code' : null,
                      onChanged: (val) {
                        setState(() {
                          className = val;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),

                    TextFormField(
                      decoration: InputDecoration(labelText: "Description", border: OutlineInputBorder()),
                      maxLines: 5,
                      onChanged: (val) {
                        setState(() {
                          description = val;
                        });
                      },
                    ),

                    SizedBox(height: 20.0),
                    OutlinedButton(
                      onPressed: () {
                        _openColorPicker();
                        setState(() => {});
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Select Color",
                                style: TextStyle(color: Colors.white, fontSize: 14)),
                            CircleColor(
                              color: uiColor,
                              circleSize: 30,
                              onColorChoose: (color) {
                                setState(() => {uiColor = color});
                              },
                            ),
                          ]
                        )
                      )
                    ),

                    SizedBox(height: 20.0),

                    // Login  button
                    ElevatedButton(
                      child: Text("Add",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Roboto",
                              fontSize: 22)
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate())  {
                          await ClassesDB(user: user).updateClasses(className, description, uiColor);
                          await updateAllData();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const FacultyHomeScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(150, 50),
                      ),
                    )
                  ],
                ))],
        ));
  }
}
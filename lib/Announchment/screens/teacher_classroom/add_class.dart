import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/constants.dart';
import 'package:student_management_system/screens/admin_login_screen/admin_home_screen/admin_home_screen.dart';

import '../../data/custom_user.dart';
import '../../services/classes_db.dart';
import '../../services/updatealldata.dart';

class AddClass extends StatefulWidget {
  const AddClass({Key? key}) : super(key: key);

  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  String className = "";
  String description = "";
  Color uiColor = Colors.blue;
  Color _tempShadeColor = Colors.blue;

  final _formKey = GlobalKey<FormState>();

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text('Select Color'),
          content: MaterialColorPicker(
            selectedColor: uiColor,
            onColorChange: (color) {
              setState(() {
                _tempShadeColor = color;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  uiColor = _tempShadeColor;
                });
                Navigator.of(context).pop();
              },
              child: Text('Select'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.5,
        title: Text(
          "New Semester Courses",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontSize: 22,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "New Courses Created",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 5), // Adjust the duration as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 6,
                margin: EdgeInsets.all(20),
              ),);

              await ClassesDB(user: user).updateClasses(className, description, uiColor);
              await updateAllData();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const FacultyHomeScreen(),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Create Courses",
              style: TextStyle(
                fontSize: 20,
                color: kTextWhiteColor,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Courses Name with Code",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter Course Name with Code' : null,
                  onChanged: (val) {
                    setState(() {
                      className = val;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  maxLines: 5,
                  onChanged: (val) {
                    setState(() {
                      description = val;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              OutlinedButton(
                onPressed: _openColorPicker,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Color",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: uiColor,
                      radius: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

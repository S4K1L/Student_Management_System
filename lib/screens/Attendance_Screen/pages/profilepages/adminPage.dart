import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/screens/admin_login_screen/admin_home_screen/Users/faculty_list.dart';
import 'package:student_management_system/screens/admin_login_screen/admin_home_screen/Users/student_list.dart';
import 'package:student_management_system/screens/student_login_screen/login_screen.dart';
import '../../../../Announchment/data/accounts.dart';
import '../../../../Announchment/data/custom_user.dart';
import '../../../../Announchment/services/auth.dart';
import '../../../../components/profile_image_picker.dart';
import '../../../../constants.dart';
import '../../../admin_login_screen/admin_home_screen/Total_users/tota_users.dart';
import '../../../admin_login_screen/admin_home_screen/add_faculty/add_faculty.dart';
import '../../../admin_login_screen/admin_home_screen/add_student/add_student.dart';
import '../../../admin_login_screen/admin_home_screen/widgets/admin_data.dart';
import '../detailspages/facultyScreen.dart';
import '../detailspages/studentDetailspage.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  static String routeName = 'AdminPage';

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FacultyName(),
                          kHalfSizeBox,
                          FacultyDepartment(),
                          kHalfSizeBox,
                          FacultyPost(),
                          kHalfSizeBox,
                          FacultyYear(),
                        ],
                      ),
                      kHalfSizeBox,
                      ProfileImagePicker(
                        onPress: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: kOtherColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultPadding * 3),
                      topRight: Radius.circular(kDefaultPadding * 3),
                    ),
                  ),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FacultyListPage()),
                              );
                            },
                            icon: 'assets/icons/quiz.svg',
                            title: 'Faculty Report',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StudentListPage()),
                              );
                            },
                            icon: 'assets/icons/event.svg',
                            title: 'Student Report',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.pushNamed(context, AddFaculty.routeName);
                            },
                            icon: 'assets/icons/resume.svg',
                            title: 'Add Faculty',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.pushNamed(context, AddStudent.routeName);
                            },
                            icon: 'assets/icons/assignment.svg',
                            title: 'Add Student',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserListPage()),
                              );
                            },
                            icon: 'assets/icons/event.svg',
                            title: 'Total\nUsers',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginScreen()),
                              );
                            },
                            icon: 'assets/icons/logout.svg',
                            title: 'Logout',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.onPress,
    required this.icon,
    required this.title,
  });

  final VoidCallback onPress;
  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding / 2),
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 40.0,
              width: 40.0,
              color: kOtherColor,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: kDefaultPadding / 3),
          ],
        ),
      ),
    );
  }
}

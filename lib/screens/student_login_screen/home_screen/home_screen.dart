import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/screens/student_homepage.dart';
import '../../../Announchment/data/accounts.dart';
import '../../../Announchment/data/custom_user.dart';
import '../../../Announchment/screens/student_classroom/add_class.dart';
import '../../../Announchment/screens/student_classroom/StudentClasses_tab.dart';
import '../../../Announchment/screens/student_classroom/registredCourses.dart';
import '../../../Announchment/screens/student_classroom/timeline_tab.dart';
import '../../../Announchment/screens/student_classroom/wall_tab.dart';
import '../../../Announchment/services/auth.dart';
import '../../../animated_route_page.dart';
import '../../../components/profile_image_picker.dart';
import '../../../constants.dart';
import '../../Rating/teacher_rating.dart';
import '../fee_screen/fee_screen.dart';
import '../login_screen.dart';
import '../my_profile/my_profile.dart';
import 'Credit_screen/credit_screen.dart';
import 'Exam_Screen/exam_routine.dart';
import 'widgets/student_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
              height: MediaQuery.of(context).size.height / 3,
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
                          StudentName(),
                          kHalfSizeBox,
                          StudentClass(),
                          kHalfSizeBox,
                          StudentYear(),
                        ],
                      ),
                      kHalfSizeBox,
                      ProfileImagePicker(
                        onPress: () {
                          Navigator.pushNamed(context, MyProfileScreen.routeName);
                        },
                      ),
                    ],
                  ),
                  sizeBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StudentDataCard(
                        title: 'Attendance',
                        value: '92.06%',
                        onPress: () {
                          //goto Attendance Screen
                        },
                      ),
                      StudentDataCard(
                        title: 'Fees Due',
                        value: '600\$',
                        onPress: () {
                          //goto fees screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const FeeScreen(),
                            ),
                          );
                        },
                      ),
                      StudentDataCard(
                        title: 'Credit',
                        value: '15.5',
                        onPress: () {
                          //goto fees screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const CreditScreen(),
                            ),
                          );
                        },
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  const WallTab(),
                                ),
                              );
                            },
                            icon: 'assets/icons/quiz.svg',
                            title: 'Notice',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>   const JoinClass(),
                                ),
                              );
                            },
                            icon: 'assets/icons/assignment.svg',
                            title: 'Add Courses',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>   RegisteredCourses(),
                                ),
                              );
                            },
                            icon: 'assets/icons/result.svg',
                            title: 'Registered\nCourses',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>   StudentClassesTab(),
                                ),
                              );
                            },
                            icon: 'assets/icons/timetable.svg',
                            title: 'Courses Work',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  const ExamScreen(),
                                ),
                              );
                            },
                            icon: 'assets/icons/resume.svg',
                            title: 'Exam\nNotice',
                          ),
                          HomeCard(
                            onPress: () {
                              Navigator.of(context).push(UniquePageRoute(builder: (_) => FacultyListPage()));
                            },
                            icon: 'assets/icons/event.svg',
                            title: 'Faculty\nRecemmendation',
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HomeCard(
                            onPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  const LoginScreen(),
                                ),
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

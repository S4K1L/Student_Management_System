import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:student_management_system/Announchment/data/custom_user.dart';
import 'package:student_management_system/Announchment/screens/teacher_classroom/add_class.dart';
import '../../../Announchment/data/accounts.dart';
import '../../../Announchment/screens/asignedCourses.dart';
import '../../../Announchment/screens/teacher_classroom/TeacherClasses.dart';
import '../../../animated_route_page.dart';
import '../../../components/profile_image_picker.dart';
import '../../../constants.dart';
import '../../Attendance_Page/attendance_page.dart';
import '../../Attendance_Screen/pages/reportpages/reportGenration.dart';
import '../../admin_Profile/admin_Profile.dart';
import '../../student_login_screen/login_screen.dart';
import 'widgets/admin_data.dart';

class FacultyHomeScreen extends StatefulWidget {
  const FacultyHomeScreen({Key? key}) : super(key: key);

  @override
  _FacultyHomeScreenState createState() => _FacultyHomeScreenState();
}

class _FacultyHomeScreenState extends State<FacultyHomeScreen> {
  double behaviourRating = 0.0;
  double skillRating = 0.0;
  double lectureRating = 0.0;
  double markingRating = 0.0;

  @override
  void initState() {
    super.initState();
    // Fetch ratings from Firestore
    fetchRatings();
  }

  void fetchRatings() async {
    try {
      final user = Provider.of<CustomUser?>(context);
      // Use the faculty UID as the document ID
      DocumentSnapshot ratingSnapshot = await FirebaseFirestore.instance
          .collection('faculty_ratings')
          .doc(user!.uid) // Assuming user.uid is the faculty UID
          .get();
      setState(() {
        // Update the state variables with the fetched ratings
        behaviourRating = ratingSnapshot['behaviourRating'] ?? 0.0;
        skillRating = ratingSnapshot['skillRating'] ?? 0.0;
        lectureRating = ratingSnapshot['lectureRating'] ?? 0.0;
        markingRating = ratingSnapshot['markingRating'] ?? 0.0;
      });
    } catch (error) {
      print('Failed to fetch ratings: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildProfileSection(user),
            _buildRatingsSection(),
            _buildExpandedSection(account),
          ],
        ),
      ),
    );
  }
  Widget _buildProfileSection(CustomUser user) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.5,
      padding: EdgeInsets.all(kDefaultPadding),
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
                onPress: () {
                  Navigator.of(context).push(
                    UniquePageRoute(builder: (_) => AdminProfileScreen(user: user)),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingsSection() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildRatingColumn("Behaviour", behaviourRating),
          SizedBox(width: 10),
          _buildRatingColumn("Skill", skillRating),
          SizedBox(width: 10),
          _buildRatingColumn("Lecture", lectureRating),
          SizedBox(width: 10),
          _buildRatingColumn("Marking", markingRating),
        ],
      ),
    );
  }

  Widget _buildRatingColumn(String title, double rating) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 30.0,
          lineWidth: 5.0,
          percent: rating,
          center: Text(
            "${(rating * 100).toInt()}%",
            style: TextStyle(fontSize: 20),
          ),
          progressColor: Colors.red,
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildExpandedSection(var account) {
    return Expanded(
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
              _buildRow(
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => ReportGeneration()));
                  },
                  icon: 'assets/icons/quiz.svg',
                  title: 'Faculty Report',
                ),
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => AddClass()));
                  },
                  icon: 'assets/icons/assignment.svg',
                  title: 'Create Semester\nCourses',
                ),
              ),
              _buildRow(
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => StudentAttendancePage()));
                  },
                  icon: 'assets/icons/holiday.svg',
                  title: 'Attendance',
                ),
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => TeacherClassesTab(account: account)));
                  },
                  icon: 'assets/icons/datasheet.svg',
                  title: 'Make an\nAnnouncement',
                ),
              ),
              _buildRow(
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => AssignedCoursesPage()));
                  },
                  icon: 'assets/icons/resume.svg',
                  title: 'Assigned\nCourses',
                ),
                HomeCard(
                  onPress: () {},
                  icon: 'assets/icons/datasheet.svg',
                  title: 'Make an\nAnnouncement',
                ),
              ),
              _buildRow(
                HomeCard(
                  onPress: () {},
                  icon: 'assets/icons/lock.svg',
                  title: 'Upload Results',
                ),
                HomeCard(
                  onPress: () {
                    Navigator.of(context).push(UniquePageRoute(builder: (_) => LoginScreen()));
                  },
                  icon: 'assets/icons/logout.svg',
                  title: 'Logout',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(Widget leftCard, Widget rightCard) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        leftCard,
        rightCard,
      ],
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key? key,
    required this.onPress,
    required this.icon,
    required this.title,
  }) : super(key: key);

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

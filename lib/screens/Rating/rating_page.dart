import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_system/constants.dart';

class RatingPage extends StatefulWidget {
  final String facultyId;

  const RatingPage({Key? key, required this.facultyId}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double behaviourRating = 0.0;
  double skillRating = 0.0;
  double lectureRating = 0.0;
  double markingRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextWhiteColor,
        title: Text('Make your Rating',style: TextStyle(fontSize: 25,color: kPrimaryColor),),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          margin: EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
          ),
          padding: EdgeInsets.only(right: kDefaultPadding),
          width: double.infinity,
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding),
          ),
          child: ElevatedButton(
            onPressed: () {
              saveRatingsToFirestore();
            },
            child: const Text("Submit Ratings",style: TextStyle(fontSize: 20),),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingOption(
              title: 'Behaviour',
              rating: behaviourRating,
              onChanged: (value) {
                setState(() {
                  behaviourRating = value;
                });
              }),
          RatingOption(
              title: 'Skill',
              rating: skillRating,
              onChanged: (value) {
                setState(() {
                  skillRating = value;
                });
              }),
          RatingOption(
              title: 'Lecture',
              rating: lectureRating,
              onChanged: (value) {
                setState(() {
                  lectureRating = value;
                });
              }),
          RatingOption(
              title: 'Marking',
              rating: markingRating,
              onChanged: (value) {
                setState(() {
                  markingRating = value;
                });
              }),
        ],
      ),
    );
  }

  void saveRatingsToFirestore() {
    FirebaseFirestore.instance
        .collection('faculty_ratings')
        .doc(widget.facultyId)
        .set({
      'behaviourRating': behaviourRating,
      'skillRating': skillRating,
      'lectureRating': lectureRating,
      'markingRating': markingRating,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ratings submitted successfully',style: TextStyle(fontSize: 20),)),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit ratings: $error')),
      );
    });
  }
}

class RatingOption extends StatelessWidget {
  final String title;
  final double rating;
  final ValueChanged<double> onChanged;

  const RatingOption({
    Key? key,
    required this.title,
    required this.rating,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent, // Change the color as needed
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Slider(
                  value: rating,
                  onChanged: onChanged,
                  activeColor: Colors.indigo,
                  inactiveColor: Colors.indigo.withOpacity(0.5),
                ),
                SizedBox(height: 8),
                Text(
                  'Rating: ${(rating * 100).toInt()}%',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

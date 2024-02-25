import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'rating_page.dart'; // Import the rating page

class FacultyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').where('type', isEqualTo: 'faculty').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> facultyDocuments = snapshot.data!.docs;
          return ListView.builder(
            itemCount: facultyDocuments.length,
            itemBuilder: (context, index) {
              var facultyData = facultyDocuments[index].data() as Map<String, dynamic>;
              return FacultyTile(
                facultyId: facultyDocuments[index].id,
                facultyName: facultyData['fullName'],
                onTap: () {
                  // Navigate to the rating page when faculty tile is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RatingPage(facultyId: facultyDocuments[index].id)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class FacultyTile extends StatelessWidget {
  final String facultyId;
  final String facultyName;
  final VoidCallback onTap;

  const FacultyTile({
    Key? key,
    required this.facultyId,
    required this.facultyName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.blue, // You can change the color as needed
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              facultyName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "ID: $facultyId",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


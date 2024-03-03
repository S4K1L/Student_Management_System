import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:printing/printing.dart';

class StudentAttendanceReportPage extends StatefulWidget {
  const StudentAttendanceReportPage({Key? key}) : super(key: key);

  @override
  _StudentAttendanceReportPageState createState() =>
      _StudentAttendanceReportPageState();
}

class _StudentAttendanceReportPageState
    extends State<StudentAttendanceReportPage> {
  List<Map<String, dynamic>> _attendanceData = [];

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    try {
      QuerySnapshot attendanceSnapshot =
      await FirebaseFirestore.instance.collection('attendance').get();
      setState(() {
        _attendanceData = attendanceSnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return {
            'studentId': data['studentId'] ?? '',
            'date': data['date'] != null
                ? (data['date'] as Timestamp).toDate().toString()
                : '',
            'present': data['present'] != null ? data['present'].toString() : '',
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
  }

  Future<void> _generatePdfAndView() async {
    final pdf = pdfLib.Document();
    pdf.addPage(
      pdfLib.MultiPage(
        build: (context) => [
          pdfLib.Table.fromTextArray(
            headers: ['Student ID', 'Date', 'Present'],
            data: _attendanceData
                .map((attendance) => [
              attendance['studentId'],
              attendance['date'],
              attendance['present'],
            ])
                .toList(),
          ),
        ],
      ),
    );

    // Print the PDF
    await Printing.sharePdf(bytes: await pdf.save(), filename: 'attendance.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance Report'),
      ),
      body: _attendanceData.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _generatePdfAndView,
                child: Text('Download Attendance Report PDF'),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Student ID')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Present')),
              ],
              rows: _attendanceData
                  .map(
                    (attendance) => DataRow(cells: [
                  DataCell(Text(attendance['studentId'])),
                  DataCell(Text(attendance['date'])),
                  DataCell(Text(attendance['present'])),
                ]),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

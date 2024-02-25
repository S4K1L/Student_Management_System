import 'package:flutter/material.dart';
import 'package:student_management_system/screens/Attendance_Screen/pages/reportpages/reportPdfDownload.dart';

import '../../utils/names.dart';
import '../../widgets/dropDownWidget.dart';

class AdminReport extends StatefulWidget {
  const AdminReport({ Key? key }) : super(key: key);

  @override
  _AdminReportState createState() => _AdminReportState();
}

class _AdminReportState extends State<AdminReport> {
  Widget build(BuildContext context) {
        String programdropdownValue = Programe[0];
        String subjectdropdownValue = Subject[0];
        String batchdropdownValue = Batch[0];
        String schooldropdownValue = Department[0];
        String semdropdownValue = Semester[0];
        String yeardropdownValue = CollegeYear[0];
           
    return Scaffold(
      appBar: AppBar(title: Text("Report"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: new ListView(
          physics: BouncingScrollPhysics(),
          children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [SizedBox(height: 20,),
                          dropdown(DropdownValue:programdropdownValue,sTring:Programe,Hint:"Program"),SizedBox(height: 20,),
                          dropdown(DropdownValue:schooldropdownValue,sTring:Department,Hint:"School"),SizedBox(height: 20,),
                          dropdown(DropdownValue:yeardropdownValue,sTring:CollegeYear,Hint:"Year"),SizedBox(height: 20,),
                          dropdown(DropdownValue:semdropdownValue,sTring:Semester,Hint:"Semester"),SizedBox(height: 20,),
                          dropdown(DropdownValue:subjectdropdownValue,sTring:Subject,Hint:"Subject"),SizedBox(height: 20,),
                          dropdown(DropdownValue:batchdropdownValue,sTring:Batch,Hint: "Batch"),SizedBox(height: 20,),
                           
                           ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ReportPdfDownloadPage()),
      
                );}, child: Text("Genrate Report"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 40)
              ),
            ),
                        ],
                      ),
              ),
                ]
            ),
        ),
      
    );
  }
}
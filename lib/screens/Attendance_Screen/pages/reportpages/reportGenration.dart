import 'package:flutter/material.dart';
import 'package:student_management_system/constants.dart';
import 'package:student_management_system/screens/Attendance_Screen/pages/reportpages/reportPdfDownload.dart';
import '../../utils/names.dart';
import '../../widgets/dropDownWidget.dart';

class ReportGeneration extends StatefulWidget {
  const ReportGeneration({Key? key}) : super(key: key);

  @override
  _ReportGenerationState createState() => _ReportGenerationState();
}

class _ReportGenerationState extends State<ReportGeneration> {
  late DateTime selectedFromDate;
  late DateTime selectedToDate;

  @override
  void initState() {
    super.initState();
    selectedFromDate = DateTime.now();
    selectedToDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? selectedFromDate : selectedToDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.blue, // button text color
              ),
            ),
          ),
          child: child ?? Container(),
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          selectedFromDate = picked;
        } else {
          selectedToDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: Center(
          child: Text(
            "Report",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
              dropdown(
                  DropdownValue: semesterdropdownValue,
                  sTring: Semester,
                  Hint: "Semester"),
              SizedBox(
                height: 20,
              ),
              dropdown(
                  DropdownValue: batchdropdownValue,
                  sTring: Batch,
                  Hint: "Batch"),
              SizedBox(
                height: 20,
              ),
              dropdown(
                  DropdownValue: subjectdropdownValue,
                  sTring: Subject,
                  Hint: "Subject"),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: <Widget>[
                      Text("From :",style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10),
                      Text("${selectedFromDate.toLocal()}".split(' ')[0],style: TextStyle(fontSize: 20),),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, true),
                        child: const Text(
                          'Select date',
                          style: TextStyle(color: kTextBlackColor),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("To :",style: TextStyle(fontSize: 20),),
                      SizedBox(height: 10),
                      Text("${selectedToDate.toLocal()}".split(' ')[0],style: TextStyle(fontSize: 20),),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, false),
                        child: const Text(
                          'Select date',
                          style: TextStyle(color: kTextBlackColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReportPdfDownloadPage(),
                    ),
                  );
                },
                child: Text("Generate Report"),
                style: ElevatedButton.styleFrom(fixedSize: Size(300, 40)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

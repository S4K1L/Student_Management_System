

import '../model/userDetailModel.dart';
import 'names.dart';

class UserPrefrences{
   static List<Faculty> FacultyList=[
     
     Faculty(
    imagePath: 
    "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"
    // "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    //"https://source.unsplash.com/featured/?profile"
    ,
    facultyName: "Faculty Name",
    email:"faculty.email@suas.ac.in", 
    DOB: '12/12/12', 
    phoneNo: '9876987697',
    facultyId: "123",
    subject: "Subject Name",
   
   ),
   Faculty(
    imagePath: 
    "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    // "https://source.unsplash.com/featured/?profile"
    ,
    facultyName: Faculties[0],
    email:FacultiesEmailID[0], 
    DOB: FacultyDOB[0], 
    phoneNo: PhoneNo[0],
    facultyId: FacultiesID[0],
    subject: Subject[0],
   ),
   Faculty(
    imagePath: 
    "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    // "https://source.unsplash.com/featured/?profile"
    ,
    facultyName: Faculties[1],
    email:FacultiesEmailID[0], 
    DOB: FacultyDOB[0], 
    phoneNo: PhoneNo[0],
    facultyId: FacultiesID[0],
    subject: Subject[0],
   ),
   Faculty(
    imagePath: 
    "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    // "https://source.unsplash.com/featured/?profile"
    ,
    facultyName: Faculties[2],
    email:FacultiesEmailID[0], 
    DOB: FacultyDOB[0], 
    phoneNo: PhoneNo[0],
    facultyId: FacultiesID[0],
    subject: Subject[0],
   ),
   Faculty(
    imagePath: 
    "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    // "https://source.unsplash.com/featured/?profile"
    ,
    facultyName: Faculties[3],
    email:FacultiesEmailID[0], 
    DOB: FacultyDOB[0], 
    phoneNo: PhoneNo[0],
    facultyId: FacultiesID[0],
    subject: Subject[0],
   ),
   Faculty(
    imagePath: 
    "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    // "https://source.unsplash.com/featured/?profile"
    ,
    facultyName: Faculties[4],
    email:FacultiesEmailID[0], 
    DOB: FacultyDOB[0], 
    phoneNo: PhoneNo[0],
    facultyId: FacultiesID[0],
    subject: Subject[0],
   ),
   Faculty(
    imagePath: 
    "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    // "https://source.unsplash.com/featured/?profile"
    ,
    facultyName: Faculties[5],
    email:FacultiesEmailID[0], 
    DOB: FacultyDOB[0], 
    phoneNo: PhoneNo[0],
    facultyId: FacultiesID[0],
    subject: Subject[0],
   ),
   Faculty(
    imagePath: 
    "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    // "https://source.unsplash.com/featured/?profile"
    ,
    facultyName: Faculties[6],
    email:FacultiesEmailID[0], 
    DOB: FacultyDOB[0], 
    phoneNo: PhoneNo[0],
    facultyId: FacultiesID[0],
    subject: Subject[0],
   ),
   Faculty(
    imagePath: 
    "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    // "https://source.unsplash.com/featured/?profile"
    ,
    facultyName: Faculties[7],
    email:FacultiesEmailID[0], 
    DOB: FacultyDOB[0], 
    phoneNo: PhoneNo[0],
    facultyId: FacultiesID[0],
    subject: Subject[0],
   ),
   
   ]
   ;
  
  // UserPrefrences(){

  // for (int i=0 ; i<Faculties.length;i++) {
    
  // sample = Faculty(
  //   imagePath: 
  //   "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg",
  //   //"https://source.unsplash.com/featured/?profile",
  //   facultyName: Faculties[i],
  //   email:"faculty.email@suas.ac.in", 
  //   DOB: '12/12/12', 
  //   phoneNo: '9876987697',
  //   facultyId: "123",
  //   subject: "Subject Name",
  // ) as List<Faculty>;  
  // }
  // }
  static var myUser = Faculty(
    imagePath: 
    "https://www.pavilionweb.com/wp-content/uploads/2017/03/man.png"
    ,
    facultyName: "Faculty Name",
    email:"faculty.email@gmail.com",
    DOB: '12/12/12', 
    phoneNo: '018********',
    facultyId: "1001",
    subject: "Subject Name",
  );  
  static var student = Student(
    studentEnrollmentNo: "2018to2024",
    studentName: "Md Shahriar Mazumder Sabbir",
    studentemail: "201071039@gmail.com",
    semester: "3",
    batch: "23",
    department: "CSE",
    studingInYear: "4th",
    program: "Bcs in CSE"
    );  
  static List<Student> studentlist = [
    Student(
    studentEnrollmentNo: "2018to2024",
    studentName: "Md Shahriar Mazumder Sabbir",
    studentemail: "201071039@gmail.com",
    semester: "3",
    batch: "23",
    department: "CSE",
    studingInYear: "4th",
    program: "Bcs in CSE"
    ),
    Student(
    studentEnrollmentNo: Enrollment[0],
    studentName: Students[0],
    studentemail: StudentEmail[0],
    semester: Semester[4], 
    batch: Batch[0], 
    department: Branch[0],
    studingInYear: CollegeYear[0], 
    program: Programe[0]
    ),
    Student(
    studentEnrollmentNo: Enrollment[1], 
    studentName: Students[1], 
    studentemail: StudentEmail[1], 
    semester: Semester[4], 
    batch: Batch[0], 
    department: Branch[0],
    studingInYear: CollegeYear[0], 
    program: Programe[0]
    ),
    Student(
    studentEnrollmentNo: Enrollment[2], 
    studentName: Students[2], 
    studentemail: StudentEmail[2], 
    semester: Semester[4], 
    batch: Batch[0], 
    department: Branch[0],
    studingInYear: CollegeYear[0], 
    program: Programe[0]
    ),
    Student(
    studentEnrollmentNo: Enrollment[3], 
    studentName: Students[3], 
    studentemail: StudentEmail[3], 
    semester: Semester[4], 
    batch: Batch[0], 
    department: Branch[0],
    studingInYear: CollegeYear[0], 
    program: Programe[0]
    ),
    Student(
    studentEnrollmentNo: Enrollment[4], 
    studentName: Students[4], 
    studentemail: StudentEmail[4], 
    semester: Semester[4], 
    batch: Batch[0], 
    department: Branch[0],
    studingInYear: CollegeYear[0], 
    program: Programe[0]
    ),
    Student(
    studentEnrollmentNo: Enrollment[5], 
    studentName: Students[5], 
    studentemail: StudentEmail[5], 
    semester: Semester[4], 
    batch: Batch[0], 
    department: Branch[0],
    studingInYear: CollegeYear[0], 
    program: Programe[0]
    ),
  ];
}
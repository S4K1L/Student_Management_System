import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/custom_user.dart';

class AccountsDB {
  // Object to get instance of Accounts table
  CollectionReference accountReference =
  FirebaseFirestore.instance.collection("users");

  // UID used to reference the auth user
  CustomUser? user;

  AccountsDB({this.user});

  // Function to update in database
  Future<void> updateAccounts(
      String fullName,
      String type,
      String reg,
      String id,
      String fName,
      String mName,
      String dob,
      String phone,
      String pass,
      String post,
      String degree,
      String dept,
      String join,
      ) async {
    return await accountReference.doc(user!.uid).set({
      'uid': user!.uid,
      'fullName': fullName,
      'type': type,
      'email': user!.email,
      "reg": reg,
      "id": id,
      "fName": fName,
      "mName": mName,
      "dob": dob,
      "phone": phone,
      "pass": pass,
      "post": post,
      "degree": degree,
      "dept": dept,
      "join": join,
    });
  }

  // Function to make list of accounts from DB
  Future<List?> createAccountDataList() async {
    var listOfAccount = [];

    await accountReference.get().then((ss) {
      if (ss != null) {
        listOfAccount = ss.docs.toList();
      } else {
        print("got no accounts");
        return [];
      }
    });

    return listOfAccount;
  }

  // Function to reset user password
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      print('Error resetting password: $error');
      throw error;
    }
  }
}

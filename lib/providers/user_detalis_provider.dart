import 'package:amazon_app/model/user_details_model.dart';
import 'package:amazon_app/resources/cloundfirestore_method.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: "Loading", address: "Loading");

  Future getData() async {
    userDetails = await CloundFirestoreMethod().getNameAndAddress();
    notifyListeners();
  }
}

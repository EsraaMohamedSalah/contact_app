import 'dart:io';
import 'dart:typed_data';

import 'package:contacts_service/contacts_service.dart';

class ContactModel {
  String fname;
  String phoneNumber;
  String lname;
  String email;
  String website;
  final dynamic  image;



  ContactModel({required this.fname, required this.phoneNumber,required this.lname,required this.email,required this.website,required this.image});


}

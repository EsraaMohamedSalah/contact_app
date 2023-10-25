import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/contact.dart';

class ContactAddScreen extends StatefulWidget {
  final Function(ContactModel) onContactAdded;
  final ContactModel? contactToEdit; // Add contactToEdit property

  ContactAddScreen({required this.onContactAdded, this.contactToEdit});

  @override
  _ContactAddScreenState createState() => _ContactAddScreenState();
}

class _ContactAddScreenState extends State<ContactAddScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  final picker = ImagePicker();
  String? image;


  @override

  void initState() {
    super.initState();
    if (widget.contactToEdit != null) {
      // Pre-fill the text fields when editing a contact
      final contact = widget.contactToEdit!;
      firstnameController.text = contact.fname;
      lastnameController.text = contact.lname;
      phoneController.text = contact.phoneNumber;
      emailController.text = contact.email;
      websiteController.text = contact.website;
      image = contact.image;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _getImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                  image: DecorationImage(
                    image: image != null ? FileImage(File(image!)) as ImageProvider<Object>  : AssetImage('assets/default_image.jpg'), // Use AssetImage for default image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            TextField(
              controller: firstnameController,
              decoration: InputDecoration(
                  labelText: ' First Name', icon: Icon(Icons.person)),
            ),
            TextField(
              controller: lastnameController,
              decoration: InputDecoration(
                  labelText: ' Last Name',
                  icon: Icon(Icons.person_add_alt_1_rounded)),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  labelText: 'Phone Number', icon: Icon(Icons.phone)),
            ),
            TextField(
              controller: emailController,
              decoration:
                  InputDecoration(labelText: ' Email', icon: Icon(Icons.email)),
            ),
            TextField(
              controller: websiteController,
              decoration: InputDecoration(
                  labelText: ' Website', icon: Icon(Icons.date_range_outlined)),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if(firstnameController.text !="" && phoneController.text!="")
                  {
                    _addContact();
                    Navigator.of(context).pop(); // Return to the contact list

                  }
                else
                  {
                    Fluttertoast.showToast(
                      msg: 'First Name and Phone Number are required.',
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb:2 ,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.transparent, // Set background color to transparent
                      webBgColor: 'linear-gradient(to right, #FF6B6B, #FF6B6B)',
                      textColor: Colors.white,
                    );

                  }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: ImageSource.gallery); // You can use ImageSource.camera for capturing photos
    if (pickedFile != null) {
      setState(() {
        image = pickedFile.path;
      });
    }
  }

  void _addContact() async {
    final newContact = ContactModel(
      fname: firstnameController.text,
      lname: lastnameController.text,
      email: emailController.text,
      website: websiteController.text,
      phoneNumber: phoneController.text,//[Item(label: 'mobile', value: phoneController.text)],
      image: image , //!= null ? await imageFile.readAsBytes() : null,

    );
    widget.onContactAdded(newContact);
  }
}

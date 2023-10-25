import 'package:flutter/material.dart';

import '../models/contact.dart';

class ContactListItem extends StatelessWidget {
  final ContactModel contact;
  final Function(ContactModel) onDelete;
  final Function(ContactModel) onEdit;

  ContactListItem({required this.contact, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // ... (unchanged)
      leading: CircleAvatar(
        radius: 30, // Adjust the size of the circle avatar as needed
        backgroundColor: Colors.blue, // Customize the circle color
        child: Text(
          contact.fname[0], // Display the first character of the first name
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Text('${contact.fname} ${contact.lname}'),
      subtitle: Text(contact.phoneNumber),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              onEdit(contact); // Call the onEdit callback function
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 8), // Add spacing between buttons
          TextButton(
            onPressed: () {
              onDelete(contact); // Call the onDelete callback function
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

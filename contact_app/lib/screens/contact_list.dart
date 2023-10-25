import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/contact_list_item.dart';
import '../models/contact.dart';
import 'contact_add.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<ContactModel> contacts = []; // List to store contacts

  Future<void> onDeleteContact(ContactModel contact) async {
    await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this contact?'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the confirmation dialog
              contacts.remove(contact);
              Fluttertoast.showToast(
                msg: 'Contact deleted',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            },
          ),
        ],
      );
    },
    );

    setState(() {
     // contacts.remove(contact);
    });
  }
  void onEditContact(ContactModel contact) {
    // Navigate to the ContactAddScreen and pass the contact for editing
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactAddScreen(
          onContactAdded: (editedContact) {
            // Update the edited contact in the list
            final index = contacts.indexWhere((c) => c == contact);
            if (index != -1) {
              setState(() {
                contacts[index] = editedContact;
              });
            }
          },
          contactToEdit: contact, // Pass the contact for editing
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: contacts.isEmpty == false
          ? AppBar(title: Text('Contact App'), actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ])
          : AppBar(
              title: Text('Contact App'),
            ),
      body: contacts.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically center content
          children: [
            Icon(
              Icons.list,
              size: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text('List of Contacts will go here'),
          ],
        ),
      )

        : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ContactListItem(
            contact: contact,
            onDelete: onDeleteContact,
            onEdit: onEditContact, // Pass the onDelete function
          );
        },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactAddScreen(
                onContactAdded: (newContact) {
                  setState(() {
                    contacts.add(newContact); // Add the new contact to the list
                  });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }


}

// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _userEdited = false;

  Contact _editingContact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editingContact = Contact();
    } else {
      _editingContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editingContact.name;
      _emailController.text = _editingContact.email;
      _phoneController.text = _editingContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 228, 34, 20),
        title: Text(_editingContact.name ?? 'Novo Contato'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
        backgroundColor: Color.fromARGB(255, 228, 34, 20),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editingContact.img != null
                        ? FileImage(File(_editingContact.img))
                        : AssetImage(
                            'images/182-1828676_person-icons-person-icon.png'),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editingContact.name = text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              onChanged: (text) {
                _editingContact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
              onChanged: (text) {
                _editingContact.phone = text;
              },
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
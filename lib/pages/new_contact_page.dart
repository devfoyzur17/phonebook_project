// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:phonebook_project/models/contact_model.dart';
import 'package:phonebook_project/provider/contact_provider.dart';
import 'package:provider/provider.dart';

class NewContactPage extends StatefulWidget {
  static const routeName = "new-contact-page";
  const NewContactPage({Key? key}) : super(key: key);

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  String groupValue = "";
  String? dateOfBirth;
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  String? imagePatch;
  ImageSource source = ImageSource.camera;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact"),
        actions: [
          IconButton(onPressed: _saveContact, icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Stack(
                children: [
                  Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: imagePatch == null
                            ? Image.asset(
                                "assets/images/male.png",
                                height: 100,
                                width: 100,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(
                                  imagePatch!,
                                ),
                                height: 100,
                                width: 100,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              )),
                  ),
                  Positioned(
                      bottom: 0,
                      right: (MediaQuery.of(context).size.width / 2) - 70,
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      elevation: 10,
                                      actions: [
                                        ListTile(
                                          onTap: () {
                                            source = ImageSource.camera;
                                            _getImage();
                                            Navigator.of(context).pop();
                                          },
                                          title: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.deepOrange,
                                          ),
                                          subtitle: Text(
                                            "Capture from camera",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Divider(),
                                        ListTile(
                                          onTap: () {
                                            source = ImageSource.gallery;
                                            _getImage();
                                            Navigator.of(context).pop();
                                          },
                                          title: Icon(
                                            Icons.photo_library_outlined,
                                            color: Colors.deepOrange,
                                          ),
                                          subtitle: Text(
                                            "Capture from Gallery",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                          )))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: nameController,
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffffe6e6),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.deepOrange,
                    ),
                    hintText: "Enter your full name",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  if (value.length > 20) {
                    return 'name must be in 20 character';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: mobileController,
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffffe6e6),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.deepOrange,
                    ),
                    hintText: "Enter your mobile number",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  if (value.length > 11) {
                    return 'number must be in 11 character';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: emailController,
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffffe6e6),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.deepOrange,
                    ),
                    hintText: "Enter your email",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: addressController,
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffffe6e6),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.deepOrange,
                    ),
                    hintText: "Enter your address",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 20,
              ),
              
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Color(0xffffe6e6),
                shadowColor: Color(0xffffe6e6),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender:",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                "Male",
                                style: TextStyle(
                                    color: groupValue == "Male"
                                        ? Colors.red
                                        : Colors.grey),
                              ),
                              leading: Radio<String>(
                                  value: "Male",
                                  groupValue: groupValue,
                                  fillColor: MaterialStateColor.resolveWith(
                                      (states) => groupValue == "Male"
                                          ? Colors.red
                                          : Colors.grey),
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value as String;
                                    });
                                  }),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                "Female",
                                style: TextStyle(
                                    color: groupValue == "Female"
                                        ? Colors.red
                                        : Colors.grey),
                              ),
                              leading: Radio<String>(
                                value: "Female",
                                groupValue: groupValue,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => groupValue == "Female"
                                        ? Colors.red
                                        : Colors.grey),
                                onChanged: (value) {
                                  setState(() {
                                    groupValue = value as String;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Date of birth",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            dateOfBirth == null
                                ? "No date choisen!"
                                : dateOfBirth.toString(),
                            style: TextStyle(
                                color: dateOfBirth == null
                                    ? Colors.grey
                                    : Colors.deepOrange),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          OutlinedButton(
                              onPressed: _showDatePickerDialog,
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.deepOrange),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: Text("Select date of birth"))
                        ],
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        imagePatch = pickedImage.path;
      });
    }
  }

  void _showDatePickerDialog() async {
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1971),
        lastDate: DateTime.now());

    if (selectedDate != null) {
      setState(() {
        dateOfBirth = DateFormat.yMMMEd().format(selectedDate);
      });
    }
  }

  void _saveContact() async {
    if (formKey.currentState!.validate()) {
      final contact = ContactModel(
        name: nameController.text,
        number: mobileController.text,
        email: emailController.text,
        address: addressController.text,
        dob: dateOfBirth,
        gender: groupValue,
        image: imagePatch
        
      );
      print(contact);
      final status = await Provider.of<ContactProvider>(context, listen: false).addNewContact(contact);
      if(status){
        Navigator.pop(context);
      }
    }
  }
}

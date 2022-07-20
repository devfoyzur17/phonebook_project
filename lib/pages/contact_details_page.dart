// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phonebook_project/models/contact_model.dart';
import 'package:phonebook_project/provider/contact_provider.dart';
import 'package:provider/provider.dart';

class ContactDetailsPage extends StatefulWidget {
  static const routeName = "contact-details-page";
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  Size? size;
  int? id;

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Text("Contact Details"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
      ),
      body: Consumer<ContactProvider>(
          builder: (contex, provider, _) => FutureBuilder<ContactModel>(
              future: provider.getContactById(id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final contact = snapshot.data;
                  return ListView(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: size!.width,
                            height: 280,
                            decoration: BoxDecoration(color: Colors.deepOrange),
                          ),
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: contact!.image == null
                                    ? (contact.gender == "Female"
                                        ? Image.asset(
                                            "assets/images/female.png",
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover)
                                        : Image.asset("assets/images/male.png",
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover))
                                    : Image.file(File(contact.image.toString()),
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                contact.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1,
                                    wordSpacing: 1),
                              )
                            ],
                          ),
                        ],
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 2,
                        color: Color(0xffffebe6),
                        shadowColor: Colors.black,
                        child: ListTile(
                          title: Text(
                            contact.number,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: 1),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.black87,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.message,
                                    color: Colors.black87,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 2,
                        color: Color(0xffffebe6),
                        shadowColor: Colors.black,
                        child: ListTile(
                          title: Text(
                            contact.email == null || contact.email!.isEmpty
                                ? "No email added!"
                                : contact.email.toString(),
                            style:
                                contact.email == null || contact.email!.isEmpty
                                    ? TextStyle(color: Colors.grey)
                                    : TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: 1),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.black87,
                              )),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 2,
                        color: Color(0xffffebe6),
                        shadowColor: Colors.black,
                        child: ListTile(
                          title: Text(
                            contact.address == null || contact.address!.isEmpty
                                ? "No location added!"
                                : contact.address.toString(),
                            style: contact.address == null ||
                                    contact.address!.isEmpty
                                ? TextStyle(color: Colors.grey)
                                : TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: 1),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.black87,
                              )),
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Failed to fatch data"),
                  );
                }
                return CircularProgressIndicator();
              })),
    );
  }
}

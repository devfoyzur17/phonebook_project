// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phonebook_project/pages/contact_details_page.dart'; 
import 'package:phonebook_project/pages/new_contact_page.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class ContactListPage extends StatefulWidget {
  static const routeName = "/";

  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  int _selectIndex=0;
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact List"),
      ),
      
      body: Consumer<ContactProvider>(
        builder: (context, provider,_)=>  ListView.builder(
          itemCount: provider.contactList.length,
            itemBuilder: (context,index){
            final contact = provider.contactList[index];
            return Dismissible(
              direction: DismissDirection.endToStart,

              confirmDismiss: _showConformationDialog,
              onDismissed: (direction){
                provider.deleteContact(contact.id!);
              },
              
              key: ValueKey(contact.id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete, color: Colors.white,),
              ),
               child:  
              Card(
                elevation: 1,
                child: ListTile(
                   
                   leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: contact.image == null
                                ? (contact.gender == "Female"
                                    ? Image.asset("assets/images/female.png",
                                        height: 50, width: 50, fit: BoxFit.cover)
                                    : Image.asset("assets/images/male.png",
                                        height: 50, width: 50, fit: BoxFit.cover))
                                : Image.file(
                                    File(contact.image.toString()),
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover),
                          ),
                  
              
                  onTap: (){
                    Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: contact.id);
                  },
              
                  title: Text(contact.name),
                  subtitle: Text(contact.number),
                  trailing: IconButton(
                      onPressed: (){
                        final value = contact.favourite?0:1;
                          provider.updateFavorite(contact.id!, value, index);
                  }, icon: Icon(contact.favourite ? Icons.favorite : Icons.favorite_border,color: Colors.red,)),
                ),
              ),
            );
            }),
      ),

    
  bottomNavigationBar: BottomAppBar(
    clipBehavior: Clip.antiAlias,
    notchMargin: 5,
    shape: CircularNotchedRectangle(),
    child: Consumer<ContactProvider>(
      builder: (context, provider, _) => BottomNavigationBar(
        currentIndex: _selectIndex,
        backgroundColor: Colors.deepOrange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        onTap: (value){
           
            
          _selectIndex = value;
          provider.loadContent(_selectIndex);
          
        },
      
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: "All Contact"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
      ]),
    ),
  ),

 

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewContactPage.routeName);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,

    


    );
  }
   Future<bool?> _showConformationDialog(DismissDirection direction) {

    return showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text("Delete Contact"),
      content: Text("Are you sure delete this contact"),
      actions: [
        TextButton(onPressed: ()=> Navigator.pop(context, false), child: Text("No")),
        TextButton(onPressed: ()=> Navigator.pop(context, true), child: Text("Yes")),
      ],
    ));


  }
}

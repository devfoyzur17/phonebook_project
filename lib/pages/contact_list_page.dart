// ignore_for_file: prefer_const_constructors

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
                //provider.deleteContact(contact.id!);
              },
              
              key: ValueKey(contact.id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete, color: Colors.white,),
              ),
              child: ListTile(

                onTap: (){
                  Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: contact.id);
                },

                title: Text(contact.name),
                subtitle: Text(contact.number),
                trailing: IconButton(
                    onPressed: (){
                      final value = contact.favourite?0:1;
                      //  provider.updateFavorite(contact.id!, value, index);
                }, icon: Icon(contact.favourite ? Icons.favorite : Icons.favorite_border,color: Colors.red,)),
              ),
            );
            }),
      ),

    
  

 

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewContactPage.routeName);
        },
        child: Icon(Icons.add),
      ),
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

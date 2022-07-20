import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:phonebook_project/pages/contact_details_page.dart';
import 'package:phonebook_project/pages/contact_list_page.dart';
import 'package:phonebook_project/pages/new_contact_page.dart';
import 'package:phonebook_project/provider/contact_provider.dart';
import 'package:provider/provider.dart';

void main() { 
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> ContactProvider() .. getAllContact())
    ],
  child: const MyApp())); 
}

class MyApp extends StatelessWidget { 
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: ContactListPage.routeName,
      routes: {
        ContactListPage.routeName :(context) => const ContactListPage(),
        NewContactPage.routeName :(context) => const NewContactPage(),
        ContactDetailsPage.routeName :(context) => const ContactDetailsPage()
      },
       
    );
  }
}

 
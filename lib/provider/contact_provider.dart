import 'package:flutter/cupertino.dart';

import '../db/database.dart';
import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{

  
  List<ContactModel> contactList =[]; 



  Future<bool> addNewContact(ContactModel contactModel) async{
    final rowID =  await DBHelper.insertContact(contactModel);
    if(rowID>0){
      contactModel.id = rowID;
      contactList.add(contactModel);
      notifyListeners();
      return true;
    }
    return false;
  }

  getAllContact(){
    DBHelper.getAllContact().then((value) {
      contactList = value;
      notifyListeners();
      
    });
  }
  getAllFavoriteContact(){
    DBHelper.getAllFavoriteContact().then((value) {
      contactList = value;
      notifyListeners();
      
    });
  }

  Future<ContactModel> getContactById(int id) => DBHelper.getContactById(id);


  updateFavorite(int id, int value, int index){
    DBHelper.updateFavorite(id, value).then((value) {
      contactList[index].favourite = ! contactList[index].favourite;
      notifyListeners();
    });

  }

  deleteContact(int id) async{
    final rowID = await DBHelper.delete(id);
    if(rowID > 0){
      contactList.removeWhere((element) => element.id==id);
      notifyListeners();
    }
  }

  loadContent(int index){
    switch(index){
      case 0:
        getAllContact();
        break;
      case 1:
          getAllFavoriteContact();
        break;
    }
  }
  
}
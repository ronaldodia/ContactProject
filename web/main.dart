// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:ContactProject/nav_menu.dart';

import 'package:route_hierarchical/client.dart';
import 'package:ContactProject/ContactLibrairies.dart';

import 'dart:convert';


class ContactForm{
  
  
  TableElement contactTable;
  InputElement nom=new InputElement();
  InputElement search_input=new InputElement();
  InputElement email=new InputElement();
  InputElement telephone=new InputElement();
 
  UListElement listContact=new UListElement();
  ButtonElement addButton=new ButtonElement();
  ButtonElement loadButton=new ButtonElement();
  ButtonElement updateButton=new ButtonElement();
  ButtonElement deleteButton=new ButtonElement();
ContactForm(Contacts contacts){
  
  ContactTable table= new ContactTable();
  
  contacts.fromJson(JSON.decode(window.localStorage['contacts']));
  contacts.forEach((f)=>table.addRowData(f.name, f.email, f.phone));
        
   deleteButton=document.querySelector('#delete');
   nom=querySelector('#name-input');
   search_input=querySelector('#name');
   email=querySelector('#email-input');
   telephone=querySelector('#phone-input');
   listContact=querySelector('#list-contact');
   addButton=querySelector('#add-button');
 loadButton=querySelector('#load-button');
 

 
 //table
  
   
 
 //fin table
 
 
search_input.onChange.listen((e){
  var rows = '${tableBegin}';
      Contacts lst=new Contacts();
      lst=contacts.select((f)=>f.onName(search_input.value));
     
         rows = '${rows}${trBegin}';
         lst.forEach((f){rows = '${rows}${td(f.name)}';
         rows = '${rows}${td(f.email)}';
         rows = '${rows}${td(f.phone)}';
         rows='${rows}${trEnd}';}
         );
         rows = '${rows}${trEnd}';
       
       
       rows = '${rows}${tableEnd}';
       document.querySelector('#table').innerHtml =rows;
       document.querySelector('#table').innerHtml = tableString(lst);
  
});


/*loadButton.onClick.listen((e) {
print("load");
contacts.clear();
    contacts.fromJson(JSON.decode(window.localStorage['contacts']));
    contacts.forEach((note) => note.name);
   print(contacts.length);
   document.querySelector('#table').innerHtml = table(contacts);
  
});*/

addButton.onClick.listen((e){
  
  
  Contact c =new Contact();
     c.name=nom.value;
       c.email=email.value;
       c.phone=telephone.value;
  contacts.add(c);
  
  
  window.localStorage['contacts'] = JSON.encode(contacts.toJson());
 
  //querySelector("#out").text="contact number"+contacts.length.toString();
 // document.querySelector('#table').innerHtml = table(contacts);
});






}



















}
String description() {
  return '''
    <p>
      The following links are learning resources.
    </p>
  ''';
}


var tableBegin = '''
  <table border=1>
    <caption>Title</caption>
    <tr>
      <th>Nom</th>
      <th>Email</th>
      <th>Telephone</th>

    </tr>
''';

var tableEnd = '''
  </table>
''';

var trBegin = '''
    <tr>
''';

var trEnd = '''
  </tr>
''';

String td(String attribut) {
  
  return '''
      <td>${attribut}</td>
  ''';
}


String tableString(Contacts contacts) {
   var rows = '${tableBegin}';
  String updatechaine="";
  int i=0;
     rows = '${rows}${trBegin}';
     contacts.forEach((f){rows = '${rows}${td(f.name)}';
     
     rows = '${rows}${td(f.email)}';
     rows = '${rows}${td(f.phone)}';
     
     rows='${rows}${trEnd}';
     
     i++;}
     );
    
     rows = '${rows}${trEnd}';
   
   
   rows = '${rows}${tableEnd}';
   print(rows);
   return rows;
 }


void main() {
  ContactModel contactModel = new ContactModel();
     Contacts contacts = contactModel.contacts;
     
  initNavMenu();


  // Webapps need routing to listen for changes to the URL.
  var router = new Router();
  router.root
    ..addRoute(name: 'ajout', path: '/ajout', enter: showAbout)
    ..addRoute(name: 'home', defaultRoute: true, path: '/', enter: showHome);
  router.listen();
  
  
  
  //contacts.clear();
  //initialiser la classe
// Contact c =new Contact();
//   c.name="las";
//     c.email="dia";
//     c.phone="587878";
//    Contact c2=new Contact();
//         c2.name="libarjrjrj2";
//         c2.email="dia@hh";
//         c2.phone="65564456";
//         //contacts.add(c);
//         //
//         contacts.add(c2);
//         Contact c3=new  Contact();
//         c3.name="alassane dia  ";
//                 c3.email="dia@yahoo.fr";
//                 c3.phone="000000";
//                // contacts.add(c3);
//  //debut du table
 
  new ContactForm(contacts);
  
  contacts.clear();
  contacts.fromJson(JSON.decode(window.localStorage['contacts']));
     
//  document.querySelector('#table').innerHtml = table(contacts); 
 
}

void showAbout(RouteEvent e) {
  // Extremely simple and non-scalable way to show different views.
  querySelector('#home').style.display = 'none';
  querySelector('#ajout').style.display = '';
}

void showHome(RouteEvent e) {
  querySelector('#home').style.display = '';
  querySelector('#ajout').style.display = 'none';
}











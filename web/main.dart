// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:ContactProject/nav_menu.dart';

import 'package:route_hierarchical/client.dart';
import 'package:ContactProject/ContactLibrairies.dart';

import 'dart:convert';


class ContactForm {


  TableElement contactTable;
  InputElement nom = new InputElement();
  InputElement search_input = new InputElement();
  InputElement email = new InputElement();
  InputElement telephone = new InputElement();

  UListElement listContact = new UListElement();
  ButtonElement addButton = new ButtonElement();
  ButtonElement loadButton = new ButtonElement();
  ButtonElement updateButton = new ButtonElement();
  ButtonElement clearButton = new ButtonElement();
  
  //debut du constructeur
  ContactForm(Contacts contacts) {

    ContactTable table = new ContactTable();

    table.loadContacts(contacts);
    contacts.forEach((f) => table.addRowData(f.name, f.email, f.phone));


    nom = querySelector('#name-input');
    search_input = querySelector('#name');
    email = querySelector('#email-input');
    telephone = querySelector('#phone-input');
    clearButton = querySelector('#clear');
    addButton = querySelector('#add-button');
    updateButton = querySelector('#update');



    //evenement pour la recherche
    search_input.onChange.listen((e) {
      var rows = '${table.tableBegin}';
      Contacts lst = new Contacts();
      lst = contacts.select((f) => f.onName(search_input.value));

      rows = '${rows}${table.trBegin}';
      lst.forEach((f) {
        rows = '${rows}${table.td(f.name)}';
        rows = '${rows}${table.td(f.email)}';
        rows = '${rows}${table.td(f.phone)}';
        rows = '${rows}${table.trEnd}';
      });
      rows = '${rows}${table.trEnd}';
      rows = '${rows}${table.tableEnd}';
      document.querySelector('#table').innerHtml = rows;
      document.querySelector('#table').innerHtml = table.tableString(lst);

    });

    //evenement bouton clearAll
    clearButton.onClick.listen((e) {
      table.clearContacts(contacts);
      table.loadContacts(contacts);
    });

    //evenement bouton add new Contact
    addButton.onClick.listen((e) {
      Contact c = new Contact()
                ..name = nom.value
                ..email = email.value
                ..phone = telephone.value;
      //verifier si l'email existe
      if (contacts.find(c.email) != null) {
        var msg = querySelector('#out').text = "This email exist!";

      } else {
        contacts.add(c);
        table.saveContacts(contacts);
        table.loadContacts(contacts);
        table.addRowData(c.name, c.email, c.phone);
      }

    });
    
    //evenement update contact
    updateButton.onClick.listen((e) {


      var row = table.findRow(email.value);
      try {
        row.children[0].text = nom.value;
        //  row.children[1].text = email.value;
        row.children[2].text = telephone.value;
        Contact c = new Contact()
        ..name = nom.value
        ..email = email.value
        ..phone = telephone.value;
        table.updateContact(contacts, c);
      } catch (exception, stackTrace) {
        var msg = querySelector('#out').text = "Please select a row";
      }
    });

  }

}
//fin de la classe






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



  if (window.localStorage['contacts'].isEmpty) {
    Contact c = new Contact()
    ..name = "las"
    ..email = "dia"
    ..phone = "587878";
    contacts.add(c);
    window.localStorage['contacts'] = JSON.encode(contacts.toJson());


  }


  contacts.clear();
  new ContactForm(contacts);

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










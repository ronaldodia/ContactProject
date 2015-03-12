part of ContactLibrairies;

class ContactTable {
  ContactModel contactModel = new ContactModel();
  Contacts contacts;
  TableElement contactTable;
  InputElement nom = new InputElement();

  InputElement email = new InputElement();
  InputElement telephone = new InputElement();




  ContactTable() {

    contacts = new ContactModel().contacts;


    nom = querySelector('#name-input');
    email = querySelector('#email-input');
    telephone = querySelector('#phone-input');
    contactTable = document.querySelector('#contact-table');
    addTableCaption('contacts');
    addColumnTitles();
  }

  addTableCaption(String title) {
    var contactTableCaption = contactTable.createCaption();
    contactTableCaption.text = title;
    contactTable.caption = contactTableCaption;
  }

  addColumnTitles() {
    var row = new Element.tr();
    contactTable.children.add(row);
    addColumnTitle(row, 'Email', 24);
    addColumnTitle(row, 'Name', 70);
    addColumnTitle(row, 'Phone', 70);
    addColumnTitle(row, 'delete', 70);
  }

  addColumnTitle(row, String title, num width) {
    var columnHeader = new Element.th();
    columnHeader.text = title;
    columnHeader.style.width = '${width}%';
    row.children.add(columnHeader);
  }

  addRowData(String nameString, String emailString, String phoneString) {
    var contactRow = new Element.tr();
    var nameCell = new Element.td();
    var emailCell = new Element.td();
    var phoneCell = new Element.td();
    var deleteCell = new Element.td();
    nameCell.style.width = '24%';
    emailCell.style.width = '70%';
    phoneCell.style.width = '60%';
    nameCell.text = nameString;
    emailCell.text = emailString;
    phoneCell.text = phoneString;
    deleteCell.text = "X";
    contactTable.children.add(contactRow);
    contactRow.children.add(nameCell);
    contactRow.children.add(emailCell);
    contactRow.children.add(phoneCell);
    contactRow.children.add(deleteCell);
    emailCell.onClick.listen((e) {
      nom.value = nameCell.text;
      email.value = emailCell.text;
      telephone.value = phoneCell.text;

    });
    deleteCell.onClick.listen((e) {
      Contact c = new Contact();
      Contacts contacts = new Contacts();

      var row = findRow(emailCell.text);
      c.email = emailCell.text;
      c.name = nameCell.text;
      c.phone = phoneCell.text;

      row.remove();
      this.loadContacts(contacts);
      this.deleteContact(contacts, c);
      this.saveContacts(contacts);
      var msg = querySelector('#out').text = "contact deleted";
    });

  }

  TableRowElement findRow(String note) {
    var r = 0;
    for (var row in contactTable.children) {
      if (row is TableRowElement && r++ > 0) {
        if (row.children[1].text == note) {
          return row;
        }
      }
    }
    return null;
  }
  //methode save
  void saveContacts(Contacts contacts) {

    window.localStorage['contacts'] = JSON.encode(contacts.toJson());
    var msg = querySelector('#out').text = "contacts added";
  }
  //methode load
  void loadContacts(Contacts contacts) {
    contacts.clear();
    contacts.fromJson(JSON.decode(window.localStorage['contacts']));


  }
  //methode delete
  void deleteContact(Contacts contacts, Contact contact) {

    contact = contacts.find(contact.email);
    contacts.remove(contact);

  }
  //methode update
  void updateContact(Contacts contacts, Contact oldcontact) {


    Contact c = new Contact();
    c = contacts.find(oldcontact.email);
    c = oldcontact;

    this.deleteContact(contacts, oldcontact);
    contacts.add(oldcontact);
    this.saveContacts(contacts);
    var msg = querySelector('#out').text = "contact updated";
  }
  //methode clear
  void clearContacts(Contacts contacts) {

    contacts.clear();
    this.saveContacts(contacts);
    contactTable.children.clear();
    addTableCaption('Contacts');
    addColumnTitles();
    var msg = querySelector('#out').text = "all contacts are deleted";
  }



//debut du table de chaine, utilisé pour juste pour afficher les resultats de recherche...
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
    String updatechaine = "";
    int i = 0;
    rows = '${rows}${trBegin}';
    contacts.forEach((f) {
      rows = '${rows}${td(f.name)}';

      rows = '${rows}${td(f.email)}';
      rows = '${rows}${td(f.phone)}';

      rows = '${rows}${trEnd}';

      i++;
    });

    rows = '${rows}${trEnd}';


    rows = '${rows}${tableEnd}';

    return rows;
  }
}



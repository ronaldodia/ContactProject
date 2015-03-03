part of ContactLibrairies;

class ContactTable {
  ContactModel contactModel=new ContactModel();
  Contacts contacts;
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
ContactTable() {
  
  contacts=new ContactModel().contacts;
  updateButton=document.querySelector('#update');
        
  nom=querySelector('#name-input');
  email=querySelector('#email-input');
  telephone=querySelector('#phone-input');
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
    var deleteCell=new Element.td();
    nameCell.style.width = '24%';
    emailCell.style.width = '70%';
    phoneCell.style.width = '60%';
    nameCell.text = nameString;
    emailCell.text = emailString;
    phoneCell.text = phoneString;
    deleteCell.text="X";
    contactTable.children.add(contactRow);
    contactRow.children.add(nameCell);
    contactRow.children.add(emailCell);
    contactRow.children.add(phoneCell);
    contactRow.children.add(deleteCell);
    emailCell.onClick.listen((e){
nom.value=nameCell.text;
email.value=emailCell.text;
telephone.value=phoneCell.text;

    });
    deleteCell.onClick.listen((e){
  
   var row = findRow(emailCell.text);
                     row.remove();
       });
    updateButton.onClick.listen((e) {    
     print('update');
        var row = findRow(emailCell.text);
        row.children[0].text = nameCell.text;
        row.children[1].text = emailCell.text;
        row.children[2].text = phoneCell.text;
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
}




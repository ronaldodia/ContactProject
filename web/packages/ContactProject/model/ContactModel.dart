
part of ContactLibrairies;

class ContactModel extends ConceptModel {

  static final String contact = 'Contact';

  Map<String, ConceptEntities> newEntries() {
    var contacts = new Contacts();
    var map = new Map<String, ConceptEntities>();
    map[contact] = contacts;
    return map;
  }

  Contacts get contacts => getEntry(contact);
void set contacts(Contacts contacts){
  contacts=contacts;
}

}
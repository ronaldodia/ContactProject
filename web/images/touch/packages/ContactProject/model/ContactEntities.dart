part of ContactLibrairies;

class Contact extends ConceptEntity<Contact> {

 // String _email;
  String _email; 
  String _name;
  String _phone;

  String get email => _email;
  String get name => _name;
  String get phone => _phone;
  set email(String email) {
     _email = email;
     if (code == null) {
       code = email;
     }}
     set name(String name) {
        _name = name;
     }
     set phone(String phone) {
             _phone = phone;
          }
  Contact newEntity() => new Contact();
 /* String get email => _email;
  set email(String email) {
    _email = email;
    if (code == null) {
      code = email;
    }
  }*/

  String toString() {
      return '  {\n '
             
             '    firstname: ${name}, \n '
             '    email: ${email}\n'
             '  }';
    }
  //search by name
  bool onName(searchName){
       return name.contains(searchName) ? true : false;
        }
  fromJson(Map<String, Object> entityMap) {
        super.fromJson(entityMap);
        name = entityMap['name'];
        
        phone = entityMap['phone'];
        email=entityMap['email'];
      }
  Map<String, Object> toJson() {
      Map<String, Object> entityMap = super.toJson();
      entityMap['name'] = name;
      entityMap['email'] = email;
      entityMap['phone'] = phone;
      return entityMap;
    }

 
}
class Contacts extends ConceptEntities<Contact> {

  Contacts newEntities() => new Contacts();
  Contact newEntity() => new Contact();

}

class UserFields{
  static const String rollNo="Roll No";
  static final String name="Name";

  static List<String> getFields()=>[rollNo,name];
}


class UserDemoFields{
   String? rollNo;
   String? name;
  UserDemoFields({this.rollNo,this.name});
  List<String?> getFields()=>[rollNo,name];
}
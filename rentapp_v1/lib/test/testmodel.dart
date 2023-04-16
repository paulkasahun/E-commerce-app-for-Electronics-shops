import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Test {
  final String name;
  final String email;
  Test({
    this.name = '',
    this.email = '',
  });

 

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) => Test.fromMap(json.decode(source) as Map<String, dynamic>);
}

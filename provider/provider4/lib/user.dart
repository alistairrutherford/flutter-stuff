import 'dart:convert';

class User {
  final String first_name;
  final String last_name;
  final String website;
  User({
    this.first_name,
    this.last_name,
    this.website,
  });

  get firstName => first_name;

  get lastName => last_name;

  User copyWith({
    String first_name,
    String last_name,
    String website,
  }) {
    return User(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      website: website ?? this.website,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'website': website,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      first_name: map['first_name'],
      last_name: map['last_name'],
      website: map['website'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'User first_name: $first_name, last_name: $last_name, website: $website';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.first_name == first_name &&
      o.last_name == last_name &&
      o.website == website;
  }

  @override
  int get hashCode => first_name.hashCode ^ last_name.hashCode ^ website.hashCode;
}
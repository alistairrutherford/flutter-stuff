import 'dart:convert';

import 'user.dart';

class Users {
  final List<User> users;
  Users({
    this.users,
  });

  Users copyWith({
    List<User> users,
  }) {
    return Users(
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'users': List<dynamic>.from(users.map((x) => x.toMap())),
    };
  }

  static Users fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Users(
      users: List<User>.from(map['users']?.map((x) => User.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static Users fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Users users: $users';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Users &&
      o.users == users;
  }

  @override
  int get hashCode => users.hashCode;
}
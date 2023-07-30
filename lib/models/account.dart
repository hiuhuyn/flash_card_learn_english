
class Account {
  String? id;
  String? name;
  String? email;
  String? country;
  Account({
    this.id,
    this.name,
    this.email,
    this.country,
  });
 
  Account copyWith({
    String? id,
    String? name,
    String? email,
    String? country,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'country': country,
    };
  }

  factory Account.fromMap({required String id, required Map<String, dynamic> map}) {
    return Account(
      id: id,
      name: map['name'],
      email: map['email'],
      country: map['country'],
    );
  }
  @override
  String toString() {
    return 'Account(id: $id, name: $name, email: $email, country: $country)';
  }

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.country == country;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      country.hashCode;
  }
}

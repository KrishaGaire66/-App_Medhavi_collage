class Welcome {
  String accessToken;
  User user;
  int status;

  Welcome({
    required this.accessToken,
    required this.user,
    required this.status,
  });
  


  // Ensure you handle the deserialization properly
  factory Welcome.fromJson(Map<String, dynamic> json) {
    return Welcome(
      accessToken: json['access_token'] ?? '',
      user: User.fromJson(json['user']),
      status: json['status'] ?? 0,
    );
  }
}

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  dynamic avatarUrl;
  dynamic displayName;
  dynamic needUpdatePw;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarUrl,
    required this.displayName,
    required this.needUpdatePw,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: json['avatar_url'],
      displayName: json['display_name'],
      needUpdatePw: json['need_update_pw'],
    );
  }
}

class UserModel {
  String userName;
  String phone;
  String password;
  String id;
  String userPhoto;
  String city;
  String name;
  int followersCount;
  int followingCount;

  UserModel({
    required this.userName,
    required this.phone,
    required this.password,
    this.id = '',
    this.userPhoto = '',
    this.city = '',
    this.name = '',
    this.followersCount = 0,
    this.followingCount = 0,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        userName: json['user_name'] ?? '',
        phone: json['phone'] ?? '',
        password: json['password'] ?? '',
        userPhoto: json['user_photo'] ?? '',
        city: json['city'] ?? '',
        name: json['name'] ?? '',
        followersCount: json['followers_count'] ?? 0,
        followingCount: json['following_count'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'user_name': userName,
        'phone': phone,
        'password': password,
        'user_photo': userPhoto,
        'city': city,
        'name': name,
        'followers_count': followersCount,
        'following_count': followingCount,
      };
}

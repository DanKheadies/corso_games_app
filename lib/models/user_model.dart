import 'package:equatable/equatable.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class User extends Equatable {
  final String? id;
  final String fullName;
  final String email;
  final String phone;
  final String city;
  final String country;
  final String createdOn;
  final String lastLogin;
  final String deviceOS;
  final String deviceType;
  final String notificationToken;
  final bool isSubscribedToNotifications;

  const User({
    this.id,
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.city = '',
    this.country = '',
    this.createdOn = '',
    this.lastLogin = '',
    this.deviceOS = '',
    this.deviceType = '',
    this.notificationToken = '',
    this.isSubscribedToNotifications = false,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? city,
    String? country,
    String? createdOn,
    String? lastLogin,
    String? deviceOS,
    String? deviceType,
    String? notificationToken,
    bool? isSubscribedToNotifications,
  }) {
    print('user copyWith');
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      country: country ?? this.country,
      createdOn: createdOn ?? this.createdOn,
      lastLogin: lastLogin ?? this.lastLogin,
      deviceOS: deviceOS ?? this.deviceOS,
      deviceType: deviceType ?? this.deviceType,
      notificationToken: notificationToken ?? this.notificationToken,
      isSubscribedToNotifications:
          isSubscribedToNotifications ?? this.isSubscribedToNotifications,
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, [
    String? id,
  ]) {
    print('user fromJson');
    // Timestamp fbStamp = json['createdOn'] ??
    //     Timestamp.fromDate(DateTime.utc(1900, 1, 1, 0, 0, 0, 0, 0));
    // DateTime createdOn = fbStamp.toDate();

    return User(
      id: id ?? json['id'],
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      createdOn: json['createdOn'] ?? '', // createdOn,
      lastLogin: json['lastLogin'] ?? '',
      deviceOS: json['deviceOS'] ?? '',
      deviceType: json['deviceType'] ?? '',
      notificationToken: json['notificationToken'] ?? '',
      isSubscribedToNotifications: json['isSubscribedToNotifications'] ?? false,
    );
  }

  Map<String, Object> toJson() {
    print('user toJson');
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'city': city,
      'country': country,
      'createdOn': createdOn,
      'lastLogin': lastLogin,
      'deviceOS': deviceOS,
      'deviceType': deviceType,
      'notificationToken': notificationToken,
      'isSubscribedToNotifications': isSubscribedToNotifications,
    };
  }

  static const empty = User(
    id: '',
    // fullName = '',
    // email = '',
    // phone = '',
    // city = '',
    // country = '',
    // createdOn = '',
    // lastLogin = '',
    // deviceOS = '',
    // deviceType = '',
    // notificationToken = '',
    // isSubscribedToNotifications = false,
  );

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phone,
        city,
        country,
        createdOn,
        lastLogin,
        deviceOS,
        deviceType,
        notificationToken,
        isSubscribedToNotifications,
      ];
}

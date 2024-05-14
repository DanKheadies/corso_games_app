import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String deviceOS;
  final String deviceType;
  final String email;
  final String id;
  final String name;

  const User({
    required this.deviceOS,
    required this.deviceType,
    required this.email,
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        createdAt,
        deviceOS,
        deviceType,
        email,
        id,
        name,
        updatedAt,
      ];

  User copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deviceOS,
    String? deviceType,
    String? email,
    String? id,
    String? name,
  }) {
    return User(
      createdAt: createdAt ?? this.createdAt,
      deviceOS: deviceOS ?? this.deviceOS,
      deviceType: deviceType ?? this.deviceType,
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    // If an Id is present, we're using Firebase's fromSnapshot, so it's a timestamp.
    // If there's no Id and a json value is present, it's in a DateTime format.
    DateTime? createdTime = id != null
        ? (json['createdAt'] as Timestamp).toDate()
        : json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null;

    DateTime? updatedTime = id != null
        ? (json['updatedAt'] as Timestamp).toDate()
        : json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null;

    return User(
      createdAt: createdTime,
      deviceOS: json['deviceOS'] ?? '',
      deviceType: json['deviceType'] ?? '',
      email: json['email'] ?? '',
      id: id ?? json['id'] ?? '',
      name: json['name'] ?? '',
      updatedAt: updatedTime,
    );
  }

  Map<String, dynamic> toJson({
    bool? isFirebase,
  }) {
    DateTime createdDT = createdAt ?? DateTime.now();
    DateTime updatedDT = updatedAt ?? DateTime.now();

    return {
      'createdAt':
          isFirebase != null ? createdDT.toUtc() : createdDT.toIso8601String(),
      'deviceOS': deviceOS,
      'deviceType': deviceType,
      'email': email,
      'id': id,
      'name': name,
      'updatedAt':
          isFirebase != null ? updatedDT.toUtc() : updatedDT.toIso8601String(),
    };
  }

  static const emptyUser = User(
    deviceOS: '',
    deviceType: '',
    email: '',
    id: '',
    name: '',
  );
}

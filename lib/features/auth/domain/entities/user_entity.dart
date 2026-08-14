import 'package:equatable/equatable.dart';

enum UserRole {
  user,
  tienda,
  evento,
  admin,
}

enum UserStatus {
  active,
  incomplete,
  suspended,
}

//Representa un usuario dentro del dominio de Skate.feed
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? username;
  final String displayName;
  final DateTime? birthDate;
  final String? photoUrl;   //'?' means that the photoUrl could be null. Porque el usuario podría no poner una foto de perfil
  final UserRole role;
  final DateTime createdAt;
  final UserStatus status;

  const UserEntity({  //El constructor 
    required this.id,
    required this.email,
    this.username,
    required this.displayName,
    this.birthDate,
    this.photoUrl,
    required this.role,
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [   //Object? means that the object could be null. Porque el photoUrl podría ser null
        id,
        email,
        username,
        displayName,
        birthDate,
        photoUrl,
        role,
        createdAt,
        status,
      ];
}
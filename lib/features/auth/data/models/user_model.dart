//Esta clase es la que se encarga de traducir los datos que nos llegan de firestore a un objeto de tipo UserEntity, y viceversa. 

//Es decir, es la que se encarga de adaptar los datos que nos llegan de firestore para que nuestro UserEntity pueda entenderlos 
//y convertirlos en un objeto de tipo UserEntity, y de aquí los mandamos a UserEntity ya traducidos.

import '../../domain/entities/user_entity.dart';



class UserModel extends UserEntity {  //Heredamos de UserEntity
  const UserModel({
    required super.id,  //El super es para utilizar el constructor de la clase padre (UserEntity) 
    required super.email, 
    super.username,
    required super.displayName,
    super.birthDate,
    super.photoUrl,
    required super.role,
    required super.createdAt,
    required super.status,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {  //Adaptamos los datos que nos llegan de firestore para que nuestro UserModel pueda entenderlos y convertirlos en un objeto de tipo UserModel, y de aquí los mandamos a UserEntity ya traducidos.
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String?,
      displayName: map['displayName'] as String,
      birthDate: map['birthDate'] != null 
                ? DateTime.parse(map['birthDate'] as String) 
                : null,                 //Si el birthDate es null, entonces lo dejamos como null. Si no, lo convertimos de String → DateTime
      photoUrl: map['photoUrl'] as String?,
      role: UserRole.values.firstWhere(
        (role) => role.name == map['role'],
      ),
      createdAt: DateTime.parse(map['createdAt'] as String),
      status: UserStatus.values.firstWhere(
        (status) => status.name == map['status'],
      ),
    );
  }
  
    Map<String, dynamic> toMap() {  //Adaptamos los datos de nuestro domain para enviarlos a Firestore, --------------------es decir, convertimos nuestro UserEntity en un Map<String, dynamic> para que Firestore pueda entenderlo y guardarlo en la base de datos.
    return {
      'id': id,
      'email': email,
      'username': username,
      'displayName': displayName,
      'birthDate': birthDate?.toIso8601String(),  //Esa madre loca convierte DateTime → String
      'photoUrl': photoUrl,
      'role': role.name,  //Convierte UserRole.admin → "admin"
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,  
    };
  }
}
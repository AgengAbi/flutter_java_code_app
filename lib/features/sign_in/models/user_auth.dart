import 'package:hive/hive.dart';

part 'user_auth.g.dart';

@HiveType(typeId: 0)
class UserAuth extends HiveObject {
  @HiveField(0)
  final int idUser;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String nama;

  @HiveField(3)
  final String pin;

  @HiveField(4)
  final String foto;

  @HiveField(5)
  final int mRolesId;

  @HiveField(6)
  final bool isGoogle;

  @HiveField(7)
  final bool isCustomer;

  @HiveField(8)
  final String roles;

  @HiveField(9)
  final Map<String, bool> akses;

  UserAuth({
    required this.idUser,
    required this.email,
    required this.nama,
    required this.pin,
    required this.foto,
    required this.mRolesId,
    required this.isGoogle,
    required this.isCustomer,
    required this.roles,
    required this.akses,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      idUser: json['id_user'],
      email: json['email'],
      nama: json['nama'],
      pin: json['pin'],
      foto: json['foto'],
      mRolesId: json['m_roles_id'],
      isGoogle: json['is_google'] == 1,
      isCustomer: json['is_customer'] == 1,
      roles: json['roles'],
      akses: Map<String, bool>.from(json['akses']),
    );
  }
}

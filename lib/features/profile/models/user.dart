import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final int idUser;

  @HiveField(1)
  final String nama;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String tglLahir;

  @HiveField(4)
  final String? alamat;

  @HiveField(5)
  final String telepon;

  @HiveField(6)
  final String foto;

  @HiveField(7)
  final String ktp;

  @HiveField(8)
  final String pin;

  @HiveField(9)
  final int status;

  @HiveField(10)
  final int isCustomer;

  @HiveField(11)
  final int rolesId;

  @HiveField(12)
  final String roles;

  User({
    required this.idUser,
    required this.nama,
    required this.email,
    required this.tglLahir,
    this.alamat,
    required this.telepon,
    required this.foto,
    required this.ktp,
    required this.pin,
    required this.status,
    required this.isCustomer,
    required this.rolesId,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['id_user'],
      nama: json['nama'],
      email: json['email'],
      tglLahir: json['tgl_lahir'],
      alamat: json['alamat'],
      telepon: json['telepon'],
      foto: json['foto'],
      ktp: json['ktp'],
      pin: json['pin'],
      status: json['status'],
      isCustomer: json['is_customer'],
      rolesId: json['roles_id'],
      roles: json['roles'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'nama': nama,
      'email': email,
      'tgl_lahir': tglLahir,
      'alamat': alamat,
      'telepon': telepon,
      'foto': foto,
      'ktp': ktp,
      'pin': pin,
      'status': status,
      'is_customer': isCustomer,
      'roles_id': rolesId,
      'roles': roles,
    };
  }

  User copyWith({
    int? idUser,
    String? nama,
    String? email,
    String? tglLahir,
    String? alamat,
    String? telepon,
    String? foto,
    String? ktp,
    String? pin,
    int? status,
    int? isCustomer,
    int? rolesId,
    String? roles,
  }) {
    return User(
      idUser: idUser ?? this.idUser,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      tglLahir: tglLahir ?? this.tglLahir,
      alamat: alamat ?? this.alamat,
      telepon: telepon ?? this.telepon,
      foto: foto ?? this.foto,
      ktp: ktp ?? this.ktp,
      pin: pin ?? this.pin,
      status: status ?? this.status,
      isCustomer: isCustomer ?? this.isCustomer,
      rolesId: rolesId ?? this.rolesId,
      roles: roles ?? this.roles,
    );
  }
}

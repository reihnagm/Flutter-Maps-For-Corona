class HospitalModel {
  String id;
  String namaRsu;
  String jenisRsu;
  String alamat;
  String kodeProvinsi;
  String telepon;
  String website;
  String email;
  String latitude;
  String longitude;

  HospitalModel({
    this.id,
    this.namaRsu,
    this.jenisRsu,
    this.alamat,
    this.kodeProvinsi,
    this.telepon,
    this.website,
    this.email,
    this.latitude,
    this.longitude,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
    id: json["id"] == null ? null : json["id"],
    namaRsu: json["nama_rsu"] == null ? null : json["nama_rsu"],
    jenisRsu: json["jenis_rsu"] == null ? null : json["jenis_rsu"],
    alamat: json["alamat"] == null ? null : json["alamat"],
    kodeProvinsi: json["kode_provinsi"] == null ? null : json["kode_provinsi"],
    telepon: json["telepon"] == null ? null : json["telepon"],
    website: json["website"] == null ? null : json["website"],
    email: json["email"] == null ? null : json["email"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nama_rsu": namaRsu == null ? null : namaRsu,
    "jenis_rsu": jenisRsu == null ? null : jenisRsu,
    "alamat": alamat == null ? null : alamat,
    "kode_provinsi": kodeProvinsi == null ? null : kodeProvinsi,
    "telepon": telepon == null ? null : telepon,
    "website": website == null ? null : website,
    "email": email == null ? null : email,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
  };
}

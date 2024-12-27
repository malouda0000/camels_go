import 'dart:convert';

class PersonalProfileModel {
    final int? code;
    final String? message;
    final Data? data;

    PersonalProfileModel({
        this.code,
        this.message,
        this.data,
    });

    PersonalProfileModel copyWith({
        int? code,
        String? message,
        Data? data,
    }) => 
        PersonalProfileModel(
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PersonalProfileModel.fromRawJson(String str) => PersonalProfileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PersonalProfileModel.fromJson(Map<String, dynamic> json) => PersonalProfileModel(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final String? image;
    final String? nameAr;
    final String? nameEn;
    final dynamic nationalityId;
    final dynamic nationalityAr;
    final dynamic nationalityEn;
    final dynamic birthdate;
    final int? gender;
    final String? email;
    final String? mobile;

    Data({
        this.image,
        this.nameAr,
        this.nameEn,
        this.nationalityId,
        this.nationalityAr,
        this.nationalityEn,
        this.birthdate,
        this.gender,
        this.email,
        this.mobile,
    });

    Data copyWith({
        String? image,
        String? nameAr,
        String? nameEn,
        dynamic nationalityId,
        dynamic nationalityAr,
        dynamic nationalityEn,
        dynamic birthdate,
        int? gender,
        String? email,
        String? mobile,
    }) => 
        Data(
            image: image ?? this.image,
            nameAr: nameAr ?? this.nameAr,
            nameEn: nameEn ?? this.nameEn,
            nationalityId: nationalityId ?? this.nationalityId,
            nationalityAr: nationalityAr ?? this.nationalityAr,
            nationalityEn: nationalityEn ?? this.nationalityEn,
            birthdate: birthdate ?? this.birthdate,
            gender: gender ?? this.gender,
            email: email ?? this.email,
            mobile: mobile ?? this.mobile,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        image: json["image"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        nationalityId: json["nationality_id"],
        nationalityAr: json["nationality_ar"],
        nationalityEn: json["nationality_en"],
        birthdate: json["birthdate"],
        gender: json["gender"],
        email: json["email"],
        mobile: json["mobile"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name_ar": nameAr,
        "name_en": nameEn,
        "nationality_id": nationalityId,
        "nationality_ar": nationalityAr,
        "nationality_en": nationalityEn,
        "birthdate": birthdate,
        "gender": gender,
        "email": email,
        "mobile": mobile,
    };
}

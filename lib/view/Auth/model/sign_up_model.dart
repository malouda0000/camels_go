class SignUpModel {
  final Data? data;
  final String? accessToken;
  final String? tokenType;
  final int? code;

  SignUpModel({
    this.data,
    this.accessToken,
    this.tokenType,
    this.code,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      code: json['code'],
    );
  }
}

class Data {
  final Name? name;
  final String? email;
  final String? mobile;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  Data({
    this.name,
    this.email,
    this.mobile,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'] != null ? Name.fromJson(json['name']) : null,
      email: json['email'],
      mobile: json['mobile'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
}

class Name {
  final String? en;
  final String? ar;

  Name({
    this.en,
    this.ar,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      en: json['en'],
      ar: json['ar'],
    );
  }
}

class SignUpErrorModel {
  final Map<String, List<String>>? errors;
  final int? code;

  SignUpErrorModel({this.errors, this.code});

  factory SignUpErrorModel.fromJson(Map<String, dynamic> json) {
    return SignUpErrorModel(
      errors: json['0'] != null
          ? Map<String, List<String>>.from(json['0'])
          : null,
      code: json['code'],
    );
  }
}

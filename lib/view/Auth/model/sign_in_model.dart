// class SignUpModel {
//   final Data? data;
//   final String? accessToken;
//   final String? tokenType;
//   final int? code;

//   SignUpModel({
//     this.data,
//     this.accessToken,
//     this.tokenType,
//     this.code,
//   });

//   factory SignUpModel.fromJson(Map<String, dynamic> json) {
//     return SignUpModel(
//       data: json['data'] != null ? Data.fromJson(json['data']) : null,
//       accessToken: json['access_token'],
//       tokenType: json['token_type'],
//       code: json['code'],
//     );
//   }
// }

// class Data {
//   final Name? name;
//   final String? email;
//   final String? mobile;
//   final String? updatedAt;
//   final String? createdAt;
//   final int? id;

//   Data({
//     this.name,
//     this.email,
//     this.mobile,
//     this.updatedAt,
//     this.createdAt,
//     this.id,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       name: json['name'] != null ? Name.fromJson(json['name']) : null,
//       email: json['email'],
//       mobile: json['mobile'],
//       updatedAt: json['updated_at'],
//       createdAt: json['created_at'],
//       id: json['id'],
//     );
//   }
// }

// class Name {
//   final String? en;
//   final String? ar;

//   Name({
//     this.en,
//     this.ar,
//   });

//   factory Name.fromJson(Map<String, dynamic> json) {
//     return Name(
//       en: json['en'],
//       ar: json['ar'],
//     );
//   }
// }

// class ErrorResponse {
//   final Map<String, List<String>>? errors;
//   final int? code;

//   ErrorResponse({this.errors, this.code});

//   factory ErrorResponse.fromJson(Map<String, dynamic> json) {
//     return ErrorResponse(
//       errors: json['0'] != null
//           ? Map<String, List<String>>.from(json['0'])
//           : null,
//       code: json['code'],
//     );
//   }
// }

// #### chat gpt code #### //

// class SignInModel {
//   final String message;
//   final String? accessToken;
//   final String? tokenType;
//   final int code;

//   SignInModel({
//     required this.message,
//     this.accessToken,
//     this.tokenType,
//     required this.code,
//   });

//   factory SignInModel.fromJson(Map<String, dynamic> json) {
//     return SignInModel(
//       message: json['message'] as String,
//       accessToken: json['access_token'] as String?,
//       tokenType: json['token_type'] as String?,
//       code: json['code'] as int,
//     );
//   }
// }

// import 'dart:convert';

// class SignInModel {
//   final String? message;
//   final String? accessToken;
//   final String? tokenType;
//   final int? code;

//   SignInModel({
//     this.message,
//     this.accessToken,
//     this.tokenType,
//     this.code,
//   });

//   SignInModel copyWith({
//     String? message,
//     String? accessToken,
//     String? tokenType,
//     int? code,
//   }) =>
//       SignInModel(
//         message: message ?? this.message,
//         accessToken: accessToken ?? this.accessToken,
//         tokenType: tokenType ?? this.tokenType,
//         code: code ?? this.code,
//       );

//   factory SignInModel.fromRawJson(String str) =>
//       SignInModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
//         message: json["message"],
//         accessToken: json["access_token"]?.toString(), // Force to string
//         tokenType: json["token_type"],
//         code: json["code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "access_token": accessToken,
//         "token_type": tokenType,
//         "code": code,
//       };
// }

// class SignInErrorModel {
//   final String message;
//   final int code;

//   SignInErrorModel({required this.message, required this.code});

//   factory SignInErrorModel.fromJson(Map<String, dynamic> json) {
//     return SignInErrorModel(
//       message: json['message'] as String,
//       code: json['code'] as int,
//     );
//   }
// }


class SignInModel {
  final String? accessToken;
  final String? message;
  final String? tokenType;
  final int? code;

  SignInModel({this.accessToken, this.message, this.tokenType, this.code});

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      accessToken: json['access_token'], // Correctly map the JSON key
      message: json['message'],
      tokenType: json['token_type'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'message': message,
      'token_type': tokenType,
      'code': code,
    };
  }
}


// class SignInModel {
//   final String? accessToken;
//   final String? message;

//   SignInModel({this.accessToken, this.message});

//   factory SignInModel.fromJson(Map<String, dynamic> json) {
//     return SignInModel(
//       accessToken: json['access_token'],
//       message: json['message'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'access_token': accessToken,
//       'message': message,
//     };
//   }
// }

// class SignInModel {
//   final String message;
//   final String? accessToken;

//   SignInModel({required this.message, this.accessToken});

//   factory SignInModel.fromJson(Map<String, dynamic> json) {
//     return SignInModel(
//       message: json['message'] ?? "",
//       accessToken: json['accessToken'],
//     );
//   }
// }
class SignInErrorModel {
  final String message;
  final int? code;

  SignInErrorModel({required this.message, this.code});

  factory SignInErrorModel.fromJson(Map<String, dynamic> json) {
    final errorData = json['error'];
    if (errorData != null && errorData is Map<String, dynamic>) {
      return SignInErrorModel(
        message: errorData['message'] ?? "Unknown error",
        code: errorData['code'],
      );
    }
    return SignInErrorModel(
      message: "Unknown error format",
      code: null,
    );
  }
}

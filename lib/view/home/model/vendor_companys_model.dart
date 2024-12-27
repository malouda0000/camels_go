// // lib/models/vendor_company.dart

// class VendorCompanysModel {
//   final int id;
//   final String nameAr;
//   final String nameEn;
//   final String logo;
//   final int vendorId;
//   final int notificationsCount;

//   VendorCompanysModel({
//     required this.id,
//     required this.nameAr,
//     required this.nameEn,
//     required this.logo,
//     required this.vendorId,
//     required this.notificationsCount,
//   });

//   factory VendorCompanysModel.fromJson(Map<String, dynamic> json) {
//     return VendorCompanysModel(
//       id: json['id'],
//       nameAr: json['name_ar'] ?? '',
//       nameEn: json['name_en'] ?? '',
//       logo: json['logo'] ?? '',
//       vendorId: json['vendor_id'],
//       notificationsCount: json['notifications_count'] ?? 0,
//     );
//   }
// }

// Main Response Model
class VendorCompaniesModel {
  final int code;
  final String message;
  final VendorData data;

  VendorCompaniesModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory VendorCompaniesModel.fromJson(Map<String, dynamic> json) {
    return VendorCompaniesModel(
      code: json['code'],
      message: json['message'],
      data: VendorData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

// Vendor Data Model
class VendorData {
  final List<VendorCompany> companies;
  final VendorLinks links;
  final VendorMeta meta;

  VendorData({
    required this.companies,
    required this.links,
    required this.meta,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) {
    return VendorData(
      companies: (json['data'] as List)
          .map((item) => VendorCompany.fromJson(item))
          .toList(),
      links: VendorLinks.fromJson(json['links']),
      meta: VendorMeta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': companies.map((item) => item.toJson()).toList(),
      'links': links.toJson(),
      'meta': meta.toJson(),
    };
  }
}

// Vendor Company Model
class VendorCompany {
  final int id;
  final String nameAr;
  final String nameEn;
  final String logo;
  final int vendorId;
  final int notificationsCount;

  VendorCompany({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.logo,
    required this.vendorId,
    required this.notificationsCount,
  });

  factory VendorCompany.fromJson(Map<String, dynamic> json) {
    return VendorCompany(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      logo: json['logo'],
      vendorId: json['vendor_id'],
      notificationsCount: json['notifications_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'logo': logo,
      'vendor_id': vendorId,
      'notifications_count': notificationsCount,
    };
  }
}

// Links Model
class VendorLinks {
  final String first;
  final String last;
  final String? prev;
  final String? next;

  VendorLinks({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  factory VendorLinks.fromJson(Map<String, dynamic> json) {
    return VendorLinks(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}

// Meta Data Model
class VendorMeta {
  final int currentPage;
  final int from;
  final int lastPage;
  final List<VendorMetaLink> links;
  final String path;
  final int perPage;
  final int to;
  final int total;

  VendorMeta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory VendorMeta.fromJson(Map<String, dynamic> json) {
    return VendorMeta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      links: (json['links'] as List)
          .map((item) => VendorMetaLink.fromJson(item))
          .toList(),
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': links.map((item) => item.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

// Meta Links Model
class VendorMetaLink {
  final String? url;
  final String label;
  final bool active;

  VendorMetaLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory VendorMetaLink.fromJson(Map<String, dynamic> json) {
    return VendorMetaLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

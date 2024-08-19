class Pagination {
  final int total;
  final int current;
  final int pageSize;

  Pagination({
    required this.total,
    required this.current,
    required this.pageSize,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      current: json['current'],
      pageSize: json['pageSize'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'current': current,
      'pageSize': pageSize,
    };
  }
}

class Page<T> {
  final List<T> content;
  final int totalPage;
  final int currentPage;
  final int pageSize;
  final int totalElement;
  final bool? last;

  Page({
    required this.content,
    required this.totalPage,
    required this.currentPage,
    required this.pageSize,
    required this.totalElement,
    this.last,
  });

  factory Page.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return Page(
      content: (json['content'] as List)
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      totalPage: json['totalPage'],
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
      totalElement: json['totalElement'],
      last: json['last'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.map((item) => item).toList(),
      'totalPage': totalPage,
      'currentPage': currentPage,
      'pageSize': pageSize,
      'totalElement': totalElement,
      'last': last,
    };
  }
}

class PayLoad<T> {
  final int code;
  final String status;
  final String message;
  final T data;

  PayLoad({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory PayLoad.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return PayLoad(
      code: json['code'],
      status: json['status'],
      message: json['message'],
      data: fromJsonT(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'data': data,
    };
  }
}

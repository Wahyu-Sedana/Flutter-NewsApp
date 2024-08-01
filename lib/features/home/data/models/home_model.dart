class NewsResponse {
  final String message;
  final int total;
  final List<NewsData> data;

  NewsResponse({
    required this.message,
    required this.total,
    required this.data,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<NewsData> dataList = list.map((i) => NewsData.fromJson(i)).toList();

    return NewsResponse(
      message: json['message'],
      total: json['total'],
      data: dataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'total': total,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class NewsData {
  final String title;
  final String link;
  final DateTime isoDate;
  final String image;
  final String description;

  NewsData({
    required this.title,
    required this.link,
    required this.isoDate,
    required this.image,
    required this.description,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      title: json['title'],
      link: json['link'],
      isoDate: DateTime.parse(json['isoDate']),
      image: json['image'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'isoDate': isoDate.toIso8601String(),
      'image': image,
      'description': description,
    };
  }
}

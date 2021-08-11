/// data : [{"desc":"扔物线","id":29,"imagePath":"https://wanandroid.com/blogimgs/18320a47-148a-4f8e-bf1a-71e633872dcf.png","isVisible":1,"order":0,"title":"Android 面试黑洞&mdash;&mdash;当我按下 Home 键再切回来，会发生什么？","type":0,"url":"https://www.bilibili.com/video/BV1CA41177Se"},{"desc":"","id":6,"imagePath":"https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png","isVisible":1,"order":1,"title":"我们新增了一个常用导航Tab~","type":1,"url":"https://www.wanandroid.com/navi"},{"desc":"一起来做个App吧","id":10,"imagePath":"https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png","isVisible":1,"order":1,"title":"一起来做个App吧","type":1,"url":"https://www.wanandroid.com/blog/show/2"},{"desc":"","id":20,"imagePath":"https://www.wanandroid.com/blogimgs/90c6cc12-742e-4c9f-b318-b912f163b8d0.png","isVisible":1,"order":2,"title":"flutter 中文社区 ","type":1,"url":"https://flutter.cn/"}]
/// errorCode : 0
/// errorMsg : ""

class YLZReportCarouselModel {
  List<YLZCarouselChildModel>? _data;
  int? _errorCode;
  String? _errorMsg;

  List<YLZCarouselChildModel>? get data => _data;
  int? get errorCode => _errorCode;
  String? get errorMsg => _errorMsg;

  YLZReportCarouselModel(
      {List<YLZCarouselChildModel>? data, int? errorCode, String? errorMsg}) {
    _data = data;
    _errorCode = errorCode;
    _errorMsg = errorMsg;
  }

  YLZReportCarouselModel.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(YLZCarouselChildModel.fromJson(v));
      });
    }
    _errorCode = json["errorCode"];
    _errorMsg = json["errorMsg"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data?.map((v) => v.toJson()).toList();
    }
    map["errorCode"] = _errorCode;
    map["errorMsg"] = _errorMsg;
    return map;
  }
}

/// desc : "扔物线"
/// id : 29
/// imagePath : "https://wanandroid.com/blogimgs/18320a47-148a-4f8e-bf1a-71e633872dcf.png"
/// isVisible : 1
/// order : 0
/// title : "Android 面试黑洞&mdash;&mdash;当我按下 Home 键再切回来，会发生什么？"
/// type : 0
/// url : "https://www.bilibili.com/video/BV1CA41177Se"

class YLZCarouselChildModel {
  String? _desc;
  int? _id;
  String? _imagePath;
  int? _isVisible;
  int? _order;
  String? _title;
  int? _type;
  String? _url;

  String? get desc => _desc;
  int? get id => _id;
  String? get imagePath => _imagePath;
  int? get isVisible => _isVisible;
  int? get order => _order;
  String? get title => _title;
  int? get type => _type;
  String? get url => _url;

  YLZCarouselChildModel(
      {String? desc,
      int? id,
      String? imagePath,
      int? isVisible,
      int? order,
      String? title,
      int? type,
      String? url}) {
    _desc = desc;
    _id = id;
    _imagePath = imagePath;
    _isVisible = isVisible;
    _order = order;
    _title = title;
    _type = type;
    _url = url;
  }

  YLZCarouselChildModel.fromJson(dynamic json) {
    _desc = json["desc"];
    _id = json["id"];
    _imagePath = json["imagePath"];
    _isVisible = json["isVisible"];
    _order = json["order"];
    _title = json["title"];
    _type = json["type"];
    _url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["desc"] = _desc;
    map["id"] = _id;
    map["imagePath"] = _imagePath;
    map["isVisible"] = _isVisible;
    map["order"] = _order;
    map["title"] = _title;
    map["type"] = _type;
    map["url"] = _url;
    return map;
  }
}

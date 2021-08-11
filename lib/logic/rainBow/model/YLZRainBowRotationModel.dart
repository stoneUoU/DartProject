/// bannerList : [{"imgUrl":"http://tu.chdesign.cn//upload/Ads/20181109/553dbca76e88466f806bb9154887c370.jpg?x-oss-process=image/resize,m_fill,h_450,w_750,limit_0/format,jpg","bannerName":"新样中心","bannerId":484,"decript":"新样中心","thumbnailImg":"http://tu.chdesign.cn//upload/Ads/20181109/553dbca76e88466f806bb9154887c370.jpg?x-oss-process=image/resize,m_fill,h_450,w_750,limit_0/format,jpg","linkUrl":"http://www.chdesign.cn/article/97882.html?type=app"}]
/// newBannerList : [{"imgUrl":"http://tu.chdesign.cn//upload/Ads/20210223/3deaba973c4045c4a8d229414bd81963.jpg?x-oss-process=image/resize,m_fill,h_350,w_750,limit_0/format,jpg","bannerName":"商标设计注册","bannerId":712,"decript":"商标设计注册","thumbnailImg":"http://tu.chdesign.cn//upload/Ads/20210223/3deaba973c4045c4a8d229414bd81963.jpg?x-oss-process=image/resize,m_fill,h_350,w_750,limit_0/format,jpg","linkUrl":"https://mp.weixin.qq.com/s/Za29QixVfII_GVgcTXNZXg"},{"imgUrl":"http://tu.chdesign.cn//upload/Ads/20200511/4b782fef2abd47eaa4aedd3883a42761.jpg?x-oss-process=image/resize,m_fill,h_350,w_750,limit_0/format,jpg","bannerName":"诚招代理，携手共赢！","bannerId":585,"decript":"诚招代理，携手共赢！","thumbnailImg":"http://tu.chdesign.cn//upload/Ads/20200511/4b782fef2abd47eaa4aedd3883a42761.jpg?x-oss-process=image/resize,m_fill,h_350,w_750,limit_0/format,jpg","linkUrl":"https://x.eqxiu.com/s/271D5DjK"}]
/// advertisings : null
/// newsList : [{"news":"sheldon大仁哥的作品被诸暨怡泽电子商务有限...采纳"},{"news":"朱晓英采纳了onesockss的作品"},{"news":"yabang采纳了UWANTME的作品"},{"news":"yabang采纳了UWANTME的作品"},{"news":"鱼头设计师的作品被13157951930采纳"},{"news":"Mrako采纳了吉至设计的作品"},{"news":"点点Maggie的作品被弘创工艺采纳"},{"news":"林小珂的作品被彩虹视觉项目部采纳"},{"news":"一只傲娇的袜子的作品被彩虹视觉项目部采纳"},{"news":"王秀娟的作品被东阳夏诚服装有限公司采纳"},{"news":"SJXB889采纳了Samuel_shan的作品"},{"news":"AKIRA的作品被曹孟德采纳"},{"news":"AKIRA的作品被曹孟德采纳"},{"news":"AKIRA的作品被曹孟德采纳"},{"news":"ch69724344采纳了shinepig的作品"},{"news":"千境设计的作品被敖发包装采纳"},{"news":"勇者无惧的作品被ch07389965采纳"},{"news":"alina的作品被宁心静气采纳"},{"news":"毛阿毛的作品被ch66964430采纳"},{"news":"言蹊设计工作室的作品被土豆小子采纳"}]

class YLZRainBowRotationModel {
  List<BannerList>? _bannerList;
  List<NewBannerList>? _newBannerList;
  dynamic? _advertisings;
  List<NewsList>? _newsList;

  List<BannerList>? get bannerList => _bannerList;
  List<NewBannerList>? get newBannerList => _newBannerList;
  dynamic? get advertisings => _advertisings;
  List<NewsList>? get newsList => _newsList;

  YLZRainBowRotationModel(
      {List<BannerList>? bannerList,
      List<NewBannerList>? newBannerList,
      dynamic? advertisings,
      List<NewsList>? newsList}) {
    _bannerList = bannerList;
    _newBannerList = newBannerList;
    _advertisings = advertisings;
    _newsList = newsList;
  }

  YLZRainBowRotationModel.fromJson(dynamic json) {
    if (json["bannerList"] != null) {
      _bannerList = [];
      json["bannerList"].forEach((v) {
        _bannerList?.add(BannerList.fromJson(v));
      });
    }
    if (json["newBannerList"] != null) {
      _newBannerList = [];
      json["newBannerList"].forEach((v) {
        _newBannerList?.add(NewBannerList.fromJson(v));
      });
    }
    _advertisings = json["advertisings"];
    if (json["newsList"] != null) {
      _newsList = [];
      json["newsList"].forEach((v) {
        _newsList?.add(NewsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_bannerList != null) {
      map["bannerList"] = _bannerList?.map((v) => v.toJson()).toList();
    }
    if (_newBannerList != null) {
      map["newBannerList"] = _newBannerList?.map((v) => v.toJson()).toList();
    }
    map["advertisings"] = _advertisings;
    if (_newsList != null) {
      map["newsList"] = _newsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// news : "sheldon大仁哥的作品被诸暨怡泽电子商务有限...采纳"

class NewsList {
  String? _news;

  String? get news => _news;

  NewsList({String? news}) {
    _news = news;
  }

  NewsList.fromJson(dynamic json) {
    _news = json["news"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["news"] = _news;
    return map;
  }
}

/// imgUrl : "http://tu.chdesign.cn//upload/Ads/20210223/3deaba973c4045c4a8d229414bd81963.jpg?x-oss-process=image/resize,m_fill,h_350,w_750,limit_0/format,jpg"
/// bannerName : "商标设计注册"
/// bannerId : 712
/// decript : "商标设计注册"
/// thumbnailImg : "http://tu.chdesign.cn//upload/Ads/20210223/3deaba973c4045c4a8d229414bd81963.jpg?x-oss-process=image/resize,m_fill,h_350,w_750,limit_0/format,jpg"
/// linkUrl : "https://mp.weixin.qq.com/s/Za29QixVfII_GVgcTXNZXg"

class NewBannerList {
  String? _imgUrl;
  String? _bannerName;
  int? _bannerId;
  String? _decript;
  String? _thumbnailImg;
  String? _linkUrl;

  String? get imgUrl => _imgUrl;
  String? get bannerName => _bannerName;
  int? get bannerId => _bannerId;
  String? get decript => _decript;
  String? get thumbnailImg => _thumbnailImg;
  String? get linkUrl => _linkUrl;

  NewBannerList(
      {String? imgUrl,
      String? bannerName,
      int? bannerId,
      String? decript,
      String? thumbnailImg,
      String? linkUrl}) {
    _imgUrl = imgUrl;
    _bannerName = bannerName;
    _bannerId = bannerId;
    _decript = decript;
    _thumbnailImg = thumbnailImg;
    _linkUrl = linkUrl;
  }

  NewBannerList.fromJson(dynamic json) {
    _imgUrl = json["imgUrl"];
    _bannerName = json["bannerName"];
    _bannerId = json["bannerId"];
    _decript = json["decript"];
    _thumbnailImg = json["thumbnailImg"];
    _linkUrl = json["linkUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["imgUrl"] = _imgUrl;
    map["bannerName"] = _bannerName;
    map["bannerId"] = _bannerId;
    map["decript"] = _decript;
    map["thumbnailImg"] = _thumbnailImg;
    map["linkUrl"] = _linkUrl;
    return map;
  }
}

/// imgUrl : "http://tu.chdesign.cn//upload/Ads/20181109/553dbca76e88466f806bb9154887c370.jpg?x-oss-process=image/resize,m_fill,h_450,w_750,limit_0/format,jpg"
/// bannerName : "新样中心"
/// bannerId : 484
/// decript : "新样中心"
/// thumbnailImg : "http://tu.chdesign.cn//upload/Ads/20181109/553dbca76e88466f806bb9154887c370.jpg?x-oss-process=image/resize,m_fill,h_450,w_750,limit_0/format,jpg"
/// linkUrl : "http://www.chdesign.cn/article/97882.html?type=app"

class BannerList {
  String? _imgUrl;
  String? _bannerName;
  int? _bannerId;
  String? _decript;
  String? _thumbnailImg;
  String? _linkUrl;

  String? get imgUrl => _imgUrl;
  String? get bannerName => _bannerName;
  int? get bannerId => _bannerId;
  String? get decript => _decript;
  String? get thumbnailImg => _thumbnailImg;
  String? get linkUrl => _linkUrl;

  BannerList(
      {String? imgUrl,
      String? bannerName,
      int? bannerId,
      String? decript,
      String? thumbnailImg,
      String? linkUrl}) {
    _imgUrl = imgUrl;
    _bannerName = bannerName;
    _bannerId = bannerId;
    _decript = decript;
    _thumbnailImg = thumbnailImg;
    _linkUrl = linkUrl;
  }

  BannerList.fromJson(dynamic json) {
    _imgUrl = json["imgUrl"];
    _bannerName = json["bannerName"];
    _bannerId = json["bannerId"];
    _decript = json["decript"];
    _thumbnailImg = json["thumbnailImg"];
    _linkUrl = json["linkUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["imgUrl"] = _imgUrl;
    map["bannerName"] = _bannerName;
    map["bannerId"] = _bannerId;
    map["decript"] = _decript;
    map["thumbnailImg"] = _thumbnailImg;
    map["linkUrl"] = _linkUrl;
    return map;
  }
}

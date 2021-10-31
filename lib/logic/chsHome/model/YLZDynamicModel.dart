/// list : [{"summary":"​为贯彻落实《国家医保局财政部关于扩大长期护理保险制度试点的指导意见》（医保发〔2020〕37号，以下简称37号文件），稳步推进长期护理保险制度试点，协同促进养老服务体系建设，近日，国家医保局办公室会同民政部办公厅印发了《关于印发〈长期护理失能等级评估标准（试行）〉的通知》（以下简称《通知》）。","rlsDate":1627920000000,"stas":"1","bizCode":"1","visitCountUrl":"http://www.nhsa.gov.cn/vc/vc/interface/artcount/artcount.jsp?i_columnid=14&i_articleid=5693","newsPkId":36096,"rid":"36095","title":"国家医保局、民政部出台长期护理失能等级评估标准","url":"http://www.nhsa.gov.cn/art/2021/8/3/art_14_5693.html","rlsDateStr":"2021-08-03","picUrl":"https://fuwu.nhsa.gov.cn/bucket-iep-usc/LWSK1628071206345.jpg","newsId":"5693","visitCount":"28069"},{"summary":"国家医保局办公室 民政部办公厅关于印发《","rlsDate":1627920000000,"stas":"1","bizCode":"3","visitCountUrl":"http://www.nhsa.gov.cn/vc/vc/interface/artcount/artcount.jsp?i_columnid=14&i_articleid=5692","newsPkId":36098,"rid":"36097","title":"国家医保局办公室 民政部办公厅关于印发《长期护理失能等级评估标准（试行）》的通知","url":"http://www.nhsa.gov.cn/art/2021/8/3/art_37_5692.html","rlsDateStr":"2021-08-03","newsId":"5692","visitCount":"1"},{"summary":"一、制定出台《指导意见》的背景国家医保局","rlsDate":1620576000000,"stas":"1","bizCode":"4","visitCountUrl":"http://www.nhsa.gov.cn/vc/vc/interface/artcount/artcount.jsp?i_columnid=14&i_articleid=5024","newsPkId":34088,"rid":"34087","title":"《关于建立完善国家医保谈判药品“双通道”管理机制的指导意见》政策解读","url":"http://www.nhsa.gov.cn/art/2021/5/10/art_38_5024.html","rlsDateStr":"2021-05-10","newsId":"5024","visitCount":"1"},{"summary":"​为深入学习领会习近平总书记关于牢固树立政治机关意识、加强中央和国家机关党的政治建设重要论述的精神，“七一”前夕，局党组书记、局长胡静林同志以“强化政治机关意识、走好第一方阵”为题向国家医疗保障局全局党员干部讲授党课。","rlsDate":1593532800000,"stas":"1","bizCode":"5","newsPkId":1072,"rid":"1071","title":"胡静林局长为全局党员干部讲授党课","url":"http://www.nhsa.gov.cn/art/2020/7/1/art_8_3278.html","rlsDateStr":"2020-07-01","newsId":"3278","visitCount":"1"}]

class YLZDynamicModel {
  List<YLZDynamicModelList>? _list;

  List<YLZDynamicModelList>? get list => _list;

  YLZDynamicModel({List<YLZDynamicModelList>? list}) {
    _list = list;
  }

  YLZDynamicModel.fromJson(dynamic json) {
    if (json["list"] != null) {
      _list = [];
      json["list"].forEach((v) {
        _list?.add(YLZDynamicModelList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_list != null) {
      map["list"] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// summary : "​为贯彻落实《国家医保局财政部关于扩大长期护理保险制度试点的指导意见》（医保发〔2020〕37号，以下简称37号文件），稳步推进长期护理保险制度试点，协同促进养老服务体系建设，近日，国家医保局办公室会同民政部办公厅印发了《关于印发〈长期护理失能等级评估标准（试行）〉的通知》（以下简称《通知》）。"
/// rlsDate : 1627920000000
/// stas : "1"
/// bizCode : "1"
/// visitCountUrl : "http://www.nhsa.gov.cn/vc/vc/interface/artcount/artcount.jsp?i_columnid=14&i_articleid=5693"
/// newsPkId : 36096
/// rid : "36095"
/// title : "国家医保局、民政部出台长期护理失能等级评估标准"
/// url : "http://www.nhsa.gov.cn/art/2021/8/3/art_14_5693.html"
/// rlsDateStr : "2021-08-03"
/// picUrl : "https://fuwu.nhsa.gov.cn/bucket-iep-usc/LWSK1628071206345.jpg"
/// newsId : "5693"
/// visitCount : "28069"

class YLZDynamicModelList {
  String? _summary;
  int? _rlsDate;
  String? _stas;
  String? _bizCode;
  String? _visitCountUrl;
  int? _newsPkId;
  String? _rid;
  String? _title;
  String? _url;
  String? _rlsDateStr;
  String? _picUrl;
  String? _newsId;
  String? _visitCount;

  String? get summary => _summary;
  int? get rlsDate => _rlsDate;
  String? get stas => _stas;
  String? get bizCode => _bizCode;
  String? get visitCountUrl => _visitCountUrl;
  int? get newsPkId => _newsPkId;
  String? get rid => _rid;
  String? get title => _title;
  String? get url => _url;
  String? get rlsDateStr => _rlsDateStr;
  String? get picUrl => _picUrl;
  String? get newsId => _newsId;
  String? get visitCount => _visitCount;

  YLZDynamicModelList(
      {String? summary,
      int? rlsDate,
      String? stas,
      String? bizCode,
      String? visitCountUrl,
      int? newsPkId,
      String? rid,
      String? title,
      String? url,
      String? rlsDateStr,
      String? picUrl,
      String? newsId,
      String? visitCount}) {
    _summary = summary;
    _rlsDate = rlsDate;
    _stas = stas;
    _bizCode = bizCode;
    _visitCountUrl = visitCountUrl;
    _newsPkId = newsPkId;
    _rid = rid;
    _title = title;
    _url = url;
    _rlsDateStr = rlsDateStr;
    _picUrl = picUrl;
    _newsId = newsId;
    _visitCount = visitCount;
  }

  YLZDynamicModelList.fromJson(dynamic json) {
    _summary = json["summary"];
    _rlsDate = json["rlsDate"];
    _stas = json["stas"];
    _bizCode = json["bizCode"];
    _visitCountUrl = json["visitCountUrl"];
    _newsPkId = json["newsPkId"];
    _rid = json["rid"];
    _title = json["title"];
    _url = json["url"];
    _rlsDateStr = json["rlsDateStr"];
    _picUrl = json["picUrl"];
    _newsId = json["newsId"];
    _visitCount = json["visitCount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["summary"] = _summary;
    map["rlsDate"] = _rlsDate;
    map["stas"] = _stas;
    map["bizCode"] = _bizCode;
    map["visitCountUrl"] = _visitCountUrl;
    map["newsPkId"] = _newsPkId;
    map["rid"] = _rid;
    map["title"] = _title;
    map["url"] = _url;
    map["rlsDateStr"] = _rlsDateStr;
    map["picUrl"] = _picUrl;
    map["newsId"] = _newsId;
    map["visitCount"] = _visitCount;
    return map;
  }
}

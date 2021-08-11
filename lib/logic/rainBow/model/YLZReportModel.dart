/// reportId : 93
/// cover : "http://tu.chdesign.cn//upload/match/20210312/bcab389033b5484687ee1d0e67732639.jpg?x-oss-process=image/resize,m_fill,h_530,w_750,limit_0/format,jpg"
/// title : "2022-2023国际体育用品及运动时尚趋势分析报告"
/// description : "报告分析了7大模块，8大市场趋势，10种主流色，4种主流色彩搭配，17类亮点产品，11种花纹，14种材质。产品种类多，涉及的行业范围广。此次的ISPO Award 2021（ISPO全球设计大奖），作为体育与运动品行业内少有的专业程度拔尖的重磅奖项，早已成为了体育用品行业中创新与质量的重要标志。运动"
/// salePrice : "5000"
/// reason : "报告分析了7大模块，8大市场趋势，10种主流色，4种主流色彩搭配，17类亮点产品，11种花纹，14种材质。产品种类多，涉及的行业范围广。此次的ISPO Award 2021（ISPO全球设计大奖），作为体育与运动品行业内少有的专业程度拔尖的重磅奖项，早已成为了体育用品行业中创新与质量的重要标志。运动"
/// onLineState : 1
/// stateName : "已上线"
/// isShowApply : false
/// exhibitionName : "2021德国慕尼黑国际体育用品及运动时尚博览会ISPO MUNICH"
/// startTime : "2021.02.09"
/// endTime : "2021.02.12"

class YLZReportModel {
  int? _reportId;
  String? _cover;
  String? _title;
  String? _description;
  String? _salePrice;
  String? _reason;
  int? _onLineState;
  String? _stateName;
  bool? _isShowApply;
  String? _exhibitionName;
  String? _startTime;
  String? _endTime;

  int? get reportId => _reportId;
  String? get cover => _cover;
  String? get title => _title;
  String? get description => _description;
  String? get salePrice => _salePrice;
  String? get reason => _reason;
  int? get onLineState => _onLineState;
  String? get stateName => _stateName;
  bool? get isShowApply => _isShowApply;
  String? get exhibitionName => _exhibitionName;
  String? get startTime => _startTime;
  String? get endTime => _endTime;

  YLZReportModel(
      {int? reportId,
      String? cover,
      String? title,
      String? description,
      String? salePrice,
      String? reason,
      int? onLineState,
      String? stateName,
      bool? isShowApply,
      String? exhibitionName,
      String? startTime,
      String? endTime}) {
    _reportId = reportId;
    _cover = cover;
    _title = title;
    _description = description;
    _salePrice = salePrice;
    _reason = reason;
    _onLineState = onLineState;
    _stateName = stateName;
    _isShowApply = isShowApply;
    _exhibitionName = exhibitionName;
    _startTime = startTime;
    _endTime = endTime;
  }

  YLZReportModel.fromJson(dynamic json) {
    _reportId = json["reportId"];
    _cover = json["cover"];
    _title = json["title"];
    _description = json["description"];
    _salePrice = json["salePrice"];
    _reason = json["reason"];
    _onLineState = json["onLineState"];
    _stateName = json["stateName"];
    _isShowApply = json["isShowApply"];
    _exhibitionName = json["exhibitionName"];
    _startTime = json["startTime"];
    _endTime = json["endTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["reportId"] = _reportId;
    map["cover"] = _cover;
    map["title"] = _title;
    map["description"] = _description;
    map["salePrice"] = _salePrice;
    map["reason"] = _reason;
    map["onLineState"] = _onLineState;
    map["stateName"] = _stateName;
    map["isShowApply"] = _isShowApply;
    map["exhibitionName"] = _exhibitionName;
    map["startTime"] = _startTime;
    map["endTime"] = _endTime;
    return map;
  }
}

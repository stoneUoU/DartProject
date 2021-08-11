/// orgName : "厦门市"
/// insuStas : "1"
/// orgCode : "350200"

class YLZInsuredLandModel {
  String? _orgName;
  String? _insuStas;
  String? _orgCode;
  bool selected = false;

  String? get orgName => _orgName;
  String? get insuStas => _insuStas;
  String? get orgCode => _orgCode;

  YLZInsuredLandModel({String? orgName, String? insuStas, String? orgCode}) {
    _orgName = orgName;
    _insuStas = insuStas;
    _orgCode = orgCode;
  }

  YLZInsuredLandModel.fromJson(dynamic json) {
    _orgName = json["orgName"];
    _insuStas = json["insuStas"];
    _orgCode = json["orgCode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["orgName"] = _orgName;
    map["insuStas"] = _insuStas;
    map["orgCode"] = _orgCode;
    return map;
  }
}

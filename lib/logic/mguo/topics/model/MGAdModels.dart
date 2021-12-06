import 'package:FlutterProject/logic/mguo/home/model/mg_ad_model.dart';

/// code : 1
/// msg : "ok"
/// data : {"title":"IOS播放页","img":"http://ykimg.alicdn.com/develop/image/2020-08-20/a7f6b424f42b8bd53b824c257433e5ab.png","url":"https://www.xigtv.com","subTitle":""}

class MGAdModels {
  MGAdModels({
    int? code,
    String? msg,
    MGAdModel? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  MGAdModels.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['data'] != null ? MGAdModel.fromJson(json['data']) : null;
  }

  int? _code;
  String? _msg;
  MGAdModel? _data;

  int? get code => _code;

  String? get msg => _msg;

  MGAdModel? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

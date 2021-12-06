import 'package:FlutterProject/logic/mguo/home/model/mg_video_detail_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MGMovieDetailProvider with ChangeNotifier, DiagnosticableTreeMixin {
  MGVideoDetailModel _detailModel = MGVideoDetailModel();

  MGVideoDetailModel get detailModel => _detailModel;

  void fireMovieDetail(MGVideoDetailModel model) {
    _detailModel = model;
    notifyListeners();
  }

// @override
// void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   super.debugFillProperties(properties);
//   properties.add(IntProperty('_detailModel', detailModel));
// }
}

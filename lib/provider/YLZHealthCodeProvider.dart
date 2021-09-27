import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class YLZHealthCodeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _clickNum = 0;

  int get clickNum => _clickNum;

  void setClickNum(int clickNum) {
    _clickNum = clickNum;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('clickNum', clickNum));
  }
}

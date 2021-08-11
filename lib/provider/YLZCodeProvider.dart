import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class YLZCodeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _barCodeBytes = "";

  String _codeBytes = "";

  String get barCodeBytes => _barCodeBytes;

  String get codeBytes => _codeBytes;

  void setBarCodeBytes(String barCodeBytes) {
    _barCodeBytes = barCodeBytes;
    notifyListeners();
  }

  void setCodeBytes(String codeBytes) {
    _codeBytes = codeBytes;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('barCodeBytes', barCodeBytes));
    properties.add(StringProperty('codeBytes', codeBytes));
  }
}

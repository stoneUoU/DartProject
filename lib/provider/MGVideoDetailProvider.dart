import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MGVideoDetailProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int _selectedChannel = 0;

  int get selectedChannel => _selectedChannel;

  int _selectedRow = 0;

  int get selectedRow => _selectedRow;

  void changeSelectedChannel(int channel) {
    _selectedChannel = channel;
    notifyListeners();
  }

  void changeSelectedRow(int row) {
    _selectedRow = row;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('_selectedChannel', selectedChannel));
    properties.add(IntProperty('_selectedRow', selectedRow));
  }
}

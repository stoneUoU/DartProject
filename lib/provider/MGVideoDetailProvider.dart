import 'package:FlutterProject/net/db/hi_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MGVideoDetailProvider with ChangeNotifier, DiagnosticableTreeMixin {
  int selectedChannel(int videoId) {
    return HiCache.getInstance().get("Channel-${videoId}") ?? 0;
  }

  int selectedRow(int videoId) {
    return HiCache.getInstance().get("Row-${videoId}") ?? 0;
  }

  void changeSelectedChannel(int videoId, int channel) {
    HiCache.getInstance().setInt("Channel-${videoId}", channel);
    notifyListeners();
  }

  void changeSelectedRow(int videoId, int row) {
    HiCache.getInstance().setInt("Row-${videoId}", row);
    notifyListeners();
  }
}

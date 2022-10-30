import 'package:flutter/material.dart';

import 'package:android/network/event/get_event_service.dart';
import 'package:android/network/event/get_event_output.dart';

class EventProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<GetEventOutput> getEvent(int id) async {
    isLoading = true;
    notifyListeners();
    GetEventOutput getEventOutput = await getEventNetwork(id);
    isLoading = false;
    notifyListeners();
    return getEventOutput;
  }
}

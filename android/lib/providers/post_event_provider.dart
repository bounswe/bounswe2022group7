import 'package:android/network/event/post_event_service.dart';
import 'package:android/network/event/post_event_input.dart';
import 'package:android/network/event/post_event_output.dart';
import 'package:flutter/material.dart';

class PostEventProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<PostEventOutput> postOnlineEvent(
      PostOnlineEventInput postEventInput) async {
    isLoading = true;
    notifyListeners();
    PostEventOutput postEventOutput =
        await postOnlineEventNetwork(postEventInput);
    isLoading = false;
    notifyListeners();
    return postEventOutput;
  }

  Future<PostEventOutput> postPhysicalEvent(
      PostPhysicalEventInput postEventInput) async {
    isLoading = true;
    notifyListeners();
    PostEventOutput postEventOutput =
        await postPhysicalEventNetwork(postEventInput);
    isLoading = false;
    notifyListeners();
    return postEventOutput;
  }
}

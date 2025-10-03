import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<String?> getToken() => _messaging.getToken();

  Future<void> requestPermission() async {
    await _messaging.requestPermission();
  }

  void listenForeground(void Function(RemoteMessage) onMessage) {
    FirebaseMessaging.onMessage.listen(onMessage);
  }

  // Sending FCM to other devices requires a server key; implement with Cloud Functions or server API.
  Future<void> sendRemoteMessage({required String token, required String title, required String body, Map<String, String>? data}) async {
    if (kIsWeb) return; // Not implemented client-side here.
  }
}

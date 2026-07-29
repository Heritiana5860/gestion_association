import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:login_with_unite_test_and_clean_architecture/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifs =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'events_channel',
    'Événements',
    description: 'Notifications de nouveaux événements',
    importance: Importance.high,
  );

  Future<void> initialize({required String baseUrl}) async {
    await _initLocalNotifications();
    await _fcm.requestPermission();

    final token = await _fcm.getToken();
    if (token != null) {
      await _registerToken(token, baseUrl);
    }

    _fcm.onTokenRefresh.listen((newToken) {
      _registerToken(newToken, baseUrl);
    });

    FirebaseMessaging.onMessage.listen(_showLocalNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
  }

  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _localNotifs.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (response) {
        _handleLocalNotificationTap(response.payload);
      },
    );

    await _localNotifs
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);
  }

  /// Construit et affiche une notification enrichie (titre, description,
  /// date, heures) avec le logo de l'association.
  void _showLocalNotification(RemoteMessage message) {
    final data = message.data;
    final notification = message.notification;

    // On privilégie les données structurées envoyées par le backend,
    // avec repli sur le "notification" classique si absent.
    final eventName =
        data['event_name'] ?? notification?.title ?? 'Nouvel événement';
    final description = data['event_description'] ?? '';
    final eventDate = data['event_date'] ?? '';
    final startTime = data['event_start_time'] ?? '';
    final endTime = data['event_end_time'] ?? '';

    final title = '📅 $eventName';

    // Ligne courte affichée quand la notification n'est pas dépliée
    final summaryLine = [
      if (eventDate.isNotEmpty) eventDate,
      if (startTime.isNotEmpty && endTime.isNotEmpty)
        'de $startTime à $endTime',
    ].join(' ');

    // Texte complet affiché quand l'utilisateur déplie la notification
    final expandedText = [
      if (description.isNotEmpty) description,
      if (summaryLine.isNotEmpty) summaryLine,
    ].join('\n\n');

    _localNotifs.show(
      id: message.hashCode,
      title: title,
      body: summaryLine.isNotEmpty ? summaryLine : description,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          // Icône monochrome obligatoire pour la barre de statut
          icon: 'ic_stat_notifications',
          // Logo couleur complet de l'association affiché dans la notification
          largeIcon: const DrawableResourceAndroidBitmap('logo_association'),
          // Affiche le texte complet (description + date/heure) en dépliant
          styleInformation: BigTextStyleInformation(
            expandedText,
            contentTitle: title,
            summaryText: eventDate,
          ),
          color: const Color(0xFF1565C0), // couleur d'accent de l'association
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentSound: true,
        ),
      ),
      // On transmet toutes les infos en JSON pour la navigation au tap
      payload: jsonEncode(data),
    );
  }

  void _handleNotificationTap(RemoteMessage message) {
    final eventId = message.data['event_id'];
    // TODO: navigation vers le détail de l'événement avec eventId
  }

  void _handleLocalNotificationTap(String? payload) {
    if (payload == null) return;
    final data = jsonDecode(payload) as Map<String, dynamic>;
    final eventId = data['event_id'];
    // TODO: navigation vers le détail de l'événement avec eventId
  }

  Future<void> _registerToken(String token, String baseUrl) async {
    final cleanBaseUrl = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;

    try {
      final response = await http.post(
        Uri.parse('$cleanBaseUrl/device-token/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'platform': Platform.isIOS ? 'ios' : 'android',
        }),
      );
      debugPrint('Device token registered: ${response.statusCode}');
    } catch (e) {
      // gérer l'échec réseau
    }
  }
}

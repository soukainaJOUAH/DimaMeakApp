import 'package:flutter/foundation.dart';

enum NotificationType { info, success, warning, action }

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

class NotificationsService extends ChangeNotifier {
  NotificationsService._();

  static final NotificationsService instance = NotificationsService._();

  final List<NotificationItem> _items = [
    NotificationItem(
      title: 'Nouvelle demande',
      message: 'Une demande proche de vous est disponible.',
      time: 'Il y a 2 min',
      type: NotificationType.action,
    ),
    NotificationItem(
      title: 'Rappel',
      message: 'N\'oubliez pas de mettre a jour votre profil.',
      time: 'Il y a 1 h',
      type: NotificationType.info,
    ),
    NotificationItem(
      title: 'Confirmation',
      message: 'Votre demande a ete prise en charge.',
      time: 'Hier',
      type: NotificationType.success,
      isRead: true,
    ),
    NotificationItem(
      title: 'Alerte',
      message: 'Localisation indisponible, activez le GPS.',
      time: 'Hier',
      type: NotificationType.warning,
    ),
  ];

  List<NotificationItem> get items => List.unmodifiable(_items);

  int get unreadCount => _items.where((item) => !item.isRead).length;

  void markAllRead() {
    for (final item in _items) {
      item.isRead = true;
    }
    notifyListeners();
  }

  void toggleRead(NotificationItem item) {
    item.isRead = !item.isRead;
    notifyListeners();
  }

  void addNotification(NotificationItem item) {
    _items.insert(0, item);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import '../models/app_notification.dart';

class NotificationService extends ChangeNotifier {
  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void addNotification(AppNotification notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void markAllRead() {
    for (final n in _notifications) {
      n.isRead = true;
    }
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  void loadSampleNotifications() {
    final samples = [
      AppNotification(
        id: '1',
        title: 'Welcome!',
        body: 'Welcome to Upgrade. Start building amazing apps.',
      ),
      AppNotification(
        id: '2',
        title: 'New Feature',
        body: 'Dark mode is now available. Try it in Settings.',
      ),
      AppNotification(
        id: '3',
        title: 'Tip',
        body: 'Long press any item for more options.',
      ),
    ];
    _notifications.addAll(samples);
    notifyListeners();
  }
}

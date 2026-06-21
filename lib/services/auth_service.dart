import 'package:uuid/uuid.dart';
import '../models/user.dart';
import '../storage/hive_storage.dart';

class AuthService {
  final HiveStorage _storage = HiveStorage();
  static const _uuid = Uuid();

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;

  Future<AppUser> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final existingId = _storage.getSetting('userId', null) as String?;
    final name = _storage.getSetting('profileName', 'User') as String;

    final user = AppUser(
      id: existingId ?? _uuid.v4(),
      name: name,
      email: email,
    );

    _currentUser = user;
    await _storage.saveSetting('userId', user.id);
    return user;
  }

  Future<AppUser> signup(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final user = AppUser(
      id: _uuid.v4(),
      name: name,
      email: email,
    );

    _currentUser = user;
    await _storage.saveSetting('userId', user.id);
    await _storage.saveSetting('profileName', name);
    return user;
  }

  Future<void> logout() async {
    _currentUser = null;
    await _storage.saveSetting('userId', null);
  }

  Future<void> restoreSession() async {
    final userId = _storage.getSetting('userId', null) as String?;
    if (userId == null) return;

    final name = _storage.getSetting('profileName', 'User') as String;
    _currentUser = AppUser(
      id: userId,
      name: name,
      email: 'user@example.com',
    );
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}

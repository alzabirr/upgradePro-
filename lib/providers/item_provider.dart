import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/item.dart';

class ItemProvider extends ChangeNotifier {
  final List<AppItem> _items = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';

  List<AppItem> get items => List.unmodifiable(_items);

  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  List<AppItem> get filteredItems {
    var result = List<AppItem>.from(_items);

    if (_searchQuery.isNotEmpty) {
      result = result
          .where((item) =>
              item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    if (_selectedCategory != 'All') {
      result =
          result.where((item) => item.category == _selectedCategory).toList();
    }

    return result;
  }

  List<AppItem> get favorites =>
      _items.where((item) => item.isFavorite).toList();

  List<String> get categories {
    final cats = _items.map((e) => e.category).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }

  void addItem(AppItem item) {
    _items.insert(0, item);
    notifyListeners();
  }

  void updateItem(String id, AppItem updated) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index] = updated;
      notifyListeners();
    }
  }

  void deleteItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].isFavorite = !_items[index].isFavorite;
      notifyListeners();
    }
  }

  AppItem? getById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  void loadSampleData() {
    final categories = ['Work', 'Personal', 'Ideas', 'Health', 'Finance'];
    final samples = List.generate(
      12,
      (i) => AppItem(
        id: const Uuid().v4(),
        title: 'Sample Item ${i + 1}',
        description:
            'This is a sample item description for demonstration purposes. Item ${i + 1}.',
        category: categories[i % categories.length],
        isFavorite: i < 3,
      ),
    );
    _items.addAll(samples);
    notifyListeners();
  }
}

// Copyright 2019

import 'package:flutter/foundation.dart';

import 'data.dart';
import 'cache.dart' as cache;


/// Limit Order data
class LimitOrderModel with ChangeNotifier {
  List<LimitOrder> _orders = [];

  // Cache flag
  var _useCache = true;
  bool get useCache => _useCache;
  set useCache(bool val) {
    _useCache = val;
    notifyListeners();
  }

  // Limit Order data
  List<LimitOrder> get orders => _orders;

  void fetchOrders() async {
      _orders = await loadOrders(useCache);
      notifyListeners();
  }
}

/// Manage loading orders
Future<List<LimitOrder>> loadOrders([bool fromCache = false]) => cache.limitOrders;
    //fromCache ? cache.limitOrders  : api.orders();
  

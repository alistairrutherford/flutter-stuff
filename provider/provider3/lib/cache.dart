// Copyright 2019 A. Rutherford

/// Pre-cached api results for testing/offline demonstration

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'data.dart';

Future<List<LimitOrder>> get limitOrders async =>
    (json.decode(await rootBundle.loadString(
      'assets/orders.json',
    )) as List)
        .map<LimitOrder>((j) => LimitOrder.fromMap(j))
        .toList();
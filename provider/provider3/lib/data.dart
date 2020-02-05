import 'dart:convert';

class LimitOrder {
	int id;

	int index; // Time series index order was made against
	String dataSourceId; // Unique id of this data source (trading bot).
	String orderId; // Server id of order.
	double size;
	double baseBuyPrice = -1;
	double baseSellPrice = -1;
	double buyPrice = -1;
	double sellPrice = -1;
	String productId;  
  String buyTime;
  String sellTime;
  
  LimitOrder({
    this.id,
    this.index,
    this.dataSourceId,
    this.orderId,
    this.size,
    this.baseBuyPrice,
    this.baseSellPrice,
    this.buyPrice,
    this.sellPrice,
    this.productId,
    this.buyTime,
    this.sellTime,
  });


  LimitOrder copyWith({
    int id,
    int index,
    String dataSourceId,
    String orderId,
    double size,
    double baseBuyPrice,
    double baseSellPrice,
    double buyPrice,
    double sellPrice,
    String productId,
    String buyTime,
    String sellTime,
  }) {
    return LimitOrder(
      id: id ?? this.id,
      index: index ?? this.index,
      dataSourceId: dataSourceId ?? this.dataSourceId,
      orderId: orderId ?? this.orderId,
      size: size ?? this.size,
      baseBuyPrice: baseBuyPrice ?? this.baseBuyPrice,
      baseSellPrice: baseSellPrice ?? this.baseSellPrice,
      buyPrice: buyPrice ?? this.buyPrice,
      sellPrice: sellPrice ?? this.sellPrice,
      productId: productId ?? this.productId,
      buyTime: buyTime ?? this.buyTime,
      sellTime: sellTime ?? this.sellTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': index,
      'dataSourceId': dataSourceId,
      'orderId': orderId,
      'size': size,
      'baseBuyPrice': baseBuyPrice,
      'baseSellPrice': baseSellPrice,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'productId': productId,
      'buyTime': buyTime,
      'sellTime': sellTime,
    };
  }

  static LimitOrder fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return LimitOrder(
      id: map['id'],
      index: map['index'],
      dataSourceId: map['dataSourceId'],
      orderId: map['orderId'],
      size: map['size'],
      baseBuyPrice: map['baseBuyPrice'],
      baseSellPrice: map['baseSellPrice'],
      buyPrice: map['buyPrice'],
      sellPrice: map['sellPrice'],
      productId: map['productId'],
      buyTime: map['buyTime'],
      sellTime: map['sellTime'],
    );
  }

  String toJson() => json.encode(toMap());

  static LimitOrder fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'LimitOrder id: $id, index: $index, dataSourceId: $dataSourceId, orderId: $orderId, size: $size, baseBuyPrice: $baseBuyPrice, baseSellPrice: $baseSellPrice, buyPrice: $buyPrice, sellPrice: $sellPrice, productId: $productId, buyTime: $buyTime, sellTime: $sellTime';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is LimitOrder &&
      o.id == id &&
      o.index == index &&
      o.dataSourceId == dataSourceId &&
      o.orderId == orderId &&
      o.size == size &&
      o.baseBuyPrice == baseBuyPrice &&
      o.baseSellPrice == baseSellPrice &&
      o.buyPrice == buyPrice &&
      o.sellPrice == sellPrice &&
      o.productId == productId &&
      o.buyTime == buyTime &&
      o.sellTime == sellTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      index.hashCode ^
      dataSourceId.hashCode ^
      orderId.hashCode ^
      size.hashCode ^
      baseBuyPrice.hashCode ^
      baseSellPrice.hashCode ^
      buyPrice.hashCode ^
      sellPrice.hashCode ^
      productId.hashCode ^
      buyTime.hashCode ^
      sellTime.hashCode;
  }
}

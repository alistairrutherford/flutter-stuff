import 'package:provider6/json/SupplierIdentification.dart';

class Exchange {
    SupplierIdentification supplierIdentification;

    Exchange({this.supplierIdentification});

    factory Exchange.fromJson(Map<String, dynamic> json) {
        return Exchange(
            supplierIdentification: json['supplierIdentification'] != null ? SupplierIdentification.fromJson(json['supplierIdentification']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.supplierIdentification != null) {
            data['supplierIdentification'] = this.supplierIdentification.toJson();
        }
        return data;
    }
}
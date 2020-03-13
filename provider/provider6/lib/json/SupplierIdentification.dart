class SupplierIdentification {
    String country;
    String nationalIdentifier;

    SupplierIdentification({this.country, this.nationalIdentifier});

    factory SupplierIdentification.fromJson(Map<String, dynamic> json) {
        return SupplierIdentification(
            country: json['country'], 
            nationalIdentifier: json['nationalIdentifier'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['country'] = this.country;
        data['nationalIdentifier'] = this.nationalIdentifier;
        return data;
    }
}
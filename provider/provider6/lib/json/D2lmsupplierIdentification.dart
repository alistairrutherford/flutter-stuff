class D2lmsupplierIdentification {
    String d2lmcountry;
    String d2lmnationalIdentifier;

    D2lmsupplierIdentification({this.d2lmcountry, this.d2lmnationalIdentifier});

    factory D2lmsupplierIdentification.fromJson(Map<String, dynamic> json) {
        return D2lmsupplierIdentification(
            d2lmcountry: json['d2lmcountry'], 
            d2lmnationalIdentifier: json['d2lmnationalIdentifier'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['d2lmcountry'] = this.d2lmcountry;
        data['d2lmnationalIdentifier'] = this.d2lmnationalIdentifier;
        return data;
    }
}
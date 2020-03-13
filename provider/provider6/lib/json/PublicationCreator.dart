class PublicationCreator {
    String country;
    String nationalIdentifier;

    PublicationCreator({this.country, this.nationalIdentifier});

    factory PublicationCreator.fromJson(Map<String, dynamic> json) {
        return PublicationCreator(
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
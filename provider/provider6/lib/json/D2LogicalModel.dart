package json

class D2LogicalModel {
    Exchange exchange;
    String modelBaseVersion;
    PayloadPublication payloadPublication;
    String xmlns;
    String xmlnsxalan;
    String xmlnsxsi;
    String xsischemaLocation;

    D2LogicalModel({this.exchange, this.modelBaseVersion, this.payloadPublication, this.xmlns, this.xmlnsxalan, this.xmlnsxsi, this.xsischemaLocation});

    factory D2LogicalModel.fromJson(Map<String, dynamic> json) {
        return D2LogicalModel(
            exchange: json['exchange'] != null ? Exchange.fromJson(json['exchange']) : null, 
            modelBaseVersion: json['modelBaseVersion'], 
            payloadPublication: json['payloadPublication'] != null ? PayloadPublication.fromJson(json['payloadPublication']) : null, 
            xmlns: json['xmlns'], 
            xmlnsxalan: json['xmlnsxalan'], 
            xmlnsxsi: json['xmlnsxsi'], 
            xsischemaLocation: json['xsischemaLocation'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['modelBaseVersion'] = this.modelBaseVersion;
        data['xmlns'] = this.xmlns;
        data['xmlnsxalan'] = this.xmlnsxalan;
        data['xmlnsxsi'] = this.xmlnsxsi;
        data['xsischemaLocation'] = this.xsischemaLocation;
        if (this.exchange != null) {
            data['exchange'] = this.exchange.toJson();
        }
        if (this.payloadPublication != null) {
            data['payloadPublication'] = this.payloadPublication.toJson();
        }
        return data;
    }
}
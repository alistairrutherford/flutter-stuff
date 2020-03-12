package json

class vms {
    D2LogicalModel d2LogicalModel;
    String encoding;
    String version;

    vms({this.d2LogicalModel, this.encoding, this.version});

    factory vms.fromJson(Map<String, dynamic> json) {
        return vms(
            d2LogicalModel: json['d2LogicalModel'] != null ? D2LogicalModel.fromJson(json['d2LogicalModel']) : null, 
            encoding: json['encoding'], 
            version: json['version'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['encoding'] = this.encoding;
        data['version'] = this.version;
        if (this.d2LogicalModel != null) {
            data['d2LogicalModel'] = this.d2LogicalModel.toJson();
        }
        return data;
    }
}
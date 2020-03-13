import 'package:provider6/json/D2LogicalModel.dart';

class Vms {
    D2LogicalModel d2LogicalModel;
    String encoding;
    String version;

    Vms({this.d2LogicalModel, this.encoding, this.version});

    factory Vms.fromJson(Map<String, dynamic> json) {
        return Vms(
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
import 'D2lmd2LogicalModel.dart';

class Events {
    D2lmd2LogicalModel d2lmd2LogicalModel;
    String encoding;
    String version;

    Events({this.d2lmd2LogicalModel, this.encoding, this.version});

    factory Events.fromJson(Map<String, dynamic> json) {
        return Events(
            d2lmd2LogicalModel: json['d2lmd2LogicalModel'] != null ? D2lmd2LogicalModel.fromJson(json['d2lmd2LogicalModel']) : null, 
            encoding: json['encoding'], 
            version: json['version'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['encoding'] = this.encoding;
        data['version'] = this.version;
        if (this.d2lmd2LogicalModel != null) {
            data['d2lmd2LogicalModel'] = this.d2lmd2LogicalModel.toJson();
        }
        return data;
    }
}
import 'package:provider6/json/GroupOfLocations.dart';
import 'package:provider6/json/Validity.dart';

class SituationRecord {
    GroupOfLocations groupOfLocations;
    String id;
    String probabilityOfOccurrence;
    String situationRecordCreationTime;
    String situationRecordFirstSupplierVersionTime;
    String situationRecordVersion;
    String situationRecordVersionTime;
    String timeLastSet;
    Validity validity;
    String vmsIdentifier;
    List<String> vmsLegend;
    String xsitype;

    SituationRecord({this.groupOfLocations, this.id, this.probabilityOfOccurrence, this.situationRecordCreationTime, this.situationRecordFirstSupplierVersionTime, this.situationRecordVersion, this.situationRecordVersionTime, this.timeLastSet, this.validity, this.vmsIdentifier, this.vmsLegend, this.xsitype});

    factory SituationRecord.fromJson(Map<String, dynamic> json) {
        return SituationRecord(
            groupOfLocations: json['groupOfLocations'] != null ? GroupOfLocations.fromJson(json['groupOfLocations']) : null, 
            id: json['id'], 
            probabilityOfOccurrence: json['probabilityOfOccurrence'], 
            situationRecordCreationTime: json['situationRecordCreationTime'], 
            situationRecordFirstSupplierVersionTime: json['situationRecordFirstSupplierVersionTime'], 
            situationRecordVersion: json['situationRecordVersion'], 
            situationRecordVersionTime: json['situationRecordVersionTime'], 
            timeLastSet: json['timeLastSet'], 
            validity: json['validity'] != null ? Validity.fromJson(json['validity']) : null, 
            vmsIdentifier: json['vmsIdentifier'], 
            vmsLegend: json['vmsLegend'] != null ? new List<String>.from(json['vmsLegend']) : null, 
            xsitype: json['xsitype'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['probabilityOfOccurrence'] = this.probabilityOfOccurrence;
        data['situationRecordCreationTime'] = this.situationRecordCreationTime;
        data['situationRecordFirstSupplierVersionTime'] = this.situationRecordFirstSupplierVersionTime;
        data['situationRecordVersion'] = this.situationRecordVersion;
        data['situationRecordVersionTime'] = this.situationRecordVersionTime;
        data['timeLastSet'] = this.timeLastSet;
        data['vmsIdentifier'] = this.vmsIdentifier;
        data['xsitype'] = this.xsitype;
        if (this.groupOfLocations != null) {
            data['groupOfLocations'] = this.groupOfLocations.toJson();
        }
        if (this.validity != null) {
            data['validity'] = this.validity.toJson();
        }
        if (this.vmsLegend != null) {
            data['vmsLegend'] = this.vmsLegend;
        }
        return data;
    }
}
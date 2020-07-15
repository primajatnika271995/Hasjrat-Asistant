// To parse this JSON data, do
//
//     final branchStockModel = branchStockModelFromJson(jsonString);

import 'dart:convert';

List<BranchStockModel> branchStockModelFromJson(String str) => List<BranchStockModel>.from(json.decode(str).map((x) => BranchStockModel.fromJson(x)));

String branchStockModelToJson(List<BranchStockModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BranchStockModel {
    BranchStockModel({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory BranchStockModel.fromJson(Map<String, dynamic> json) => BranchStockModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
    };
}

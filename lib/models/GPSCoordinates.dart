/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the GPSCoordinates type in your schema. */
@immutable
class GPSCoordinates extends Model {
  static const classType = const GPSCoordinatesType();
  final String id;
  final String locationName;
  final double Longitude;
  final double Latitude;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const GPSCoordinates._internal(
      {@required this.id,
      @required this.locationName,
      @required this.Longitude,
      @required this.Latitude});

  factory GPSCoordinates(
      {@required String id,
      @required String locationName,
      @required double Longitude,
      @required double Latitude}) {
    return GPSCoordinates._internal(
        id: id == null ? UUID.getUUID() : id,
        locationName: locationName,
        Longitude: Longitude,
        Latitude: Latitude);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPSCoordinates &&
        id == other.id &&
        locationName == other.locationName &&
        Longitude == other.Longitude &&
        Latitude == other.Latitude;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("GPSCoordinates {");
    buffer.write("id=" + id + ", ");
    buffer.write("locationName=" + locationName + ", ");
    buffer.write("Longitude=" +
        (Longitude != null ? Longitude.toString() : "null") +
        ", ");
    buffer
        .write("Latitude=" + (Latitude != null ? Latitude.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  GPSCoordinates copyWith(
      {String id, String locationName, double Longitude, double Latitude}) {
    return GPSCoordinates(
        id: id ?? this.id,
        locationName: locationName ?? this.locationName,
        Longitude: Longitude ?? this.Longitude,
        Latitude: Latitude ?? this.Latitude);
  }

  GPSCoordinates.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        locationName = json['locationName'],
        Longitude = json['Longitude'],
        Latitude = json['Latitude'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'locationName': locationName,
        'Longitude': Longitude,
        'Latitude': Latitude
      };

  static final QueryField ID = QueryField(fieldName: "gPSCoordinates.id");
  static final QueryField LOCATIONNAME = QueryField(fieldName: "locationName");
  static final QueryField LONGITUDE = QueryField(fieldName: "Longitude");
  static final QueryField LATITUDE = QueryField(fieldName: "Latitude");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "GPSCoordinates";
    modelSchemaDefinition.pluralName = "GPSCoordinates";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: GPSCoordinates.LOCATIONNAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: GPSCoordinates.LONGITUDE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: GPSCoordinates.LATITUDE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.double)));
  });
}

class GPSCoordinatesType extends ModelType<GPSCoordinates> {
  const GPSCoordinatesType();

  @override
  GPSCoordinates fromJson(Map<String, dynamic> jsonData) {
    return GPSCoordinates.fromJson(jsonData);
  }
}

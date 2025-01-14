import 'dart:convert';

class PlaceDetail {
  final String id;
  final String formattedAddress;
  final List<AddressComponent> addressComponents;
  final Location location;

  PlaceDetail({
    required this.id,
    required this.formattedAddress,
    required this.addressComponents,
    required this.location,
  });

  factory PlaceDetail.fromRawJson(String str) =>
      PlaceDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceDetail.fromJson(Map<String, dynamic> json) => PlaceDetail(
        id: json["id"],
        formattedAddress: json["formattedAddress"],
        addressComponents: List<AddressComponent>.from(
            json["addressComponents"].map((x) => AddressComponent.fromJson(x))),
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "formattedAddress": formattedAddress,
        "addressComponents":
            List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "location": location.toJson(),
      };
}

class AddressComponent {
  final String longText;
  final String shortText;
  final List<String> types;
  final String? languageCode;

  AddressComponent({
    required this.longText,
    required this.shortText,
    required this.types,
    this.languageCode,
  });

  factory AddressComponent.fromRawJson(String str) =>
      AddressComponent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longText: json["longText"],
        shortText: json["shortText"],
        types: List<String>.from(json["types"].map((x) => x)),
        languageCode: json["languageCode"],
      );

  Map<String, dynamic> toJson() => {
        "longText": longText,
        "shortText": shortText,
        "types": List<dynamic>.from(types.map((x) => x)),
        "languageCode": languageCode,
      };
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

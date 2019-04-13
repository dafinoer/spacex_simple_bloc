
class Rockets {
  final String rocketId;
  final String rocketName;
  final String rocketType;
  final List<Cores> core;

  Rockets({
    this.rocketId,
    this.rocketName,
    this.rocketType,
    this.core
  });

  factory Rockets.fromJson(Map<String, dynamic> json){
    final List<dynamic> data = json['first_stage']['cores'];

    return Rockets(
      rocketId: json['rocket_id'],
      rocketName: json['rocket_name'],
      rocketType: json['rocket_type'],
      core: data.map((f) => Cores.fromJson(f)).toList()
    );
  }
}

class Cores {
  final String coreSerial;
  final int flight;
  final bool gridfins;
  final bool legs;
  final String landingtype;
  final String landingVehicle;

  Cores({
    this.coreSerial,
    this.flight,
    this.gridfins,
    this.legs,
    this.landingtype,
    this.landingVehicle
  });

  factory Cores.fromJson(Map<String, dynamic> json){
    return Cores(
      coreSerial: json['core_serial'],
      flight: json['flight'],
      gridfins: json['gridfins'],
      legs: json['legs'],
      landingtype: json['landing_type'],
      landingVehicle: json['landing_vehicle']
    );
  }
}
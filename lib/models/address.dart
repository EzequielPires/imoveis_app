class Address {
  String? id;
  String? nation;
  StateAddress? state;
  City? city;
  District? district;
  String? complement;
  String? route;
  String? number;
  String? zipcode;
  String? placeId;
  String? formattedAddress;
  dynamic location;

  Address({
    this.id,
    this.nation,
    this.state,
    this.city,
    this.district,
    this.complement,
    this.route,
    this.number,
    this.zipcode,
    this.placeId,
    this.formattedAddress,
    this.location,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      nation: json['nation'],
      state:
          json['state'] != null ? StateAddress.fromJson(json['state']) : null,
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      district:
          json['district'] != null ? District.fromJson(json['district']) : null,
      complement: json['complement'],
      route: json['route'],
      number: json['number'],
      zipcode: json['zipcode'],
      placeId: json['place_id'],
      formattedAddress: json['formatted_address'],
      location: json['location'],
    );
  }
}

class StateAddress {
  int id;
  String name;
  String? shortName;
  String? region;

  StateAddress({
    required this.name,
    required this.id,
    this.region,
    this.shortName,
  });

  factory StateAddress.fromJson(Map<String, dynamic> json) {
    return StateAddress(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      region: json['region'],
    );
  }
}

class City {
  int id;
  String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class District {
  int id;
  String name;

  District({
    required this.id,
    required this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      name: json['name'],
    );
  }
}


final List<StateAddress> statesData = [
  StateAddress(id: 1, name: 'Acre', shortName: 'AC', region: 'Norte'),
  StateAddress(id: 2, name: 'Alagoas', shortName: 'AL', region: 'Nordeste'),
  StateAddress(id: 3, name: 'Amapá', shortName: 'AP', region: 'Norte'),
  StateAddress(id: 4, name: 'Amazonas', shortName: 'AM', region: 'Norte'),
  StateAddress(id: 5, name: 'Bahia', shortName: 'BA', region: 'Nordeste'),
  StateAddress(id: 6, name: 'Ceará', shortName: 'CE', region: 'Nordeste'),
  StateAddress(id: 7, name: 'Distrito Federal', shortName: 'DF', region: 'Centro-Oeste'),
  StateAddress(id: 8, name: 'Espírito Santo', shortName: 'ES', region: 'Sudeste'),
  StateAddress(id: 9, name: 'Goiás', shortName: 'GO', region: 'Centro-Oeste'),
  StateAddress(id: 10, name: 'Maranhão', shortName: 'MA', region: 'Nordeste'),
  StateAddress(id: 11, name: 'Mato Grosso', shortName: 'MT', region: 'Centro-Oeste'),
  StateAddress(id: 12, name: 'Mato Grosso do Sul', shortName: 'MS', region: 'Centro-Oeste'),
  StateAddress(id: 13, name: 'Minas Gerais', shortName: 'MG', region: 'Sudeste'),
  StateAddress(id: 14, name: 'Pará', shortName: 'PA', region: 'Norte'),
  StateAddress(id: 15, name: 'Paraíba', shortName: 'PB', region: 'Nordeste'),
  StateAddress(id: 16, name: 'Paraná', shortName: 'PR', region: 'Sul'),
  StateAddress(id: 17, name: 'Pernambuco', shortName: 'PE', region: 'Nordeste'),
  StateAddress(id: 18, name: 'Piauí', shortName: 'PI', region: 'Nordeste'),
  StateAddress(id: 19, name: 'Rio de Janeiro', shortName: 'RJ', region: 'Sudeste'),
  StateAddress(id: 20, name: 'Rio Grande do Norte', shortName: 'RN', region: 'Nordeste'),
  StateAddress(id: 21, name: 'Rio Grande do Sul', shortName: 'RS', region: 'Sul'),
  StateAddress(id: 22, name: 'Rondônia', shortName: 'RO', region: 'Norte'),
  StateAddress(id: 23, name: 'Roraima', shortName: 'RR', region: 'Norte'),
  StateAddress(id: 24, name: 'Santa Catarina', shortName: 'SC', region: 'Sul'),
  StateAddress(id: 25, name: 'São Paulo', shortName: 'SP', region: 'Sudeste'),
  StateAddress(id: 26, name: 'Sergipe', shortName: 'SE', region: 'Nordeste'),
];
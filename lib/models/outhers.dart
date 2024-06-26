class Concierge {
  final String id;
  final String name;
  final String enumValue;

  Concierge({required this.id, required this.name, required this.enumValue});
}

class PropertyOccupation {
  final String id;
  final String name;
  final String enumValue;

  PropertyOccupation({required this.id, required this.name, required this.enumValue});
}

class KeyType {
  final String id;
  final String name;
  final String enumValue;

  KeyType({required this.id, required this.name, required this.enumValue});
}

final List<Concierge> conciergeData = [
  Concierge(id: '1', name: '24hrs', enumValue: 'integral'),
  Concierge(id: '2', name: 'Diurna', enumValue: 'diurna'),
  Concierge(id: '3', name: 'Noturna', enumValue: 'noturna'),
  Concierge(id: '4', name: 'Sem Portaria', enumValue: 'sem_portaria'),
];

final List<PropertyOccupation> propertyOccupationData = [
  PropertyOccupation(id: '1', name: 'Inquilino mora', enumValue: 'inquilino_mora'),
  PropertyOccupation(id: '2', name: 'Proprietário mora', enumValue: 'eu_moro'),
  PropertyOccupation(id: '3', name: 'Está vago', enumValue: 'esta_vago'),
  PropertyOccupation(id: '4', name: 'Em construção', enumValue: 'em_construcao'),
];

final List<KeyType> keyTypeData = [
  KeyType(id: '1', name: 'Chave', enumValue: 'chave'),
  KeyType(id: '2', name: 'Senha', enumValue: 'senha'),
  KeyType(id: '3', name: 'Biometria', enumValue: 'biometria'),
];
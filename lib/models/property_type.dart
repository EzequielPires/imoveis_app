class PropertyType {
  final int id;
  final String name;
  final String enumValue;

  PropertyType({required this.id, required this.name, required this.enumValue});
}

enum PropertyAdType {
  venda,
  aluguel
}

extension EnumExtension on PropertyAdType {
  String get name => toString().split('.').last;
}


final List<PropertyType> propertyTypeData = [
  PropertyType(id: 1, name: 'Apartamento', enumValue: 'apartamento'),
  PropertyType(id: 2, name: 'Casa', enumValue: 'casa'),
  PropertyType(id: 3, name: 'Casa de Condomínio', enumValue: 'casa_condominio'),
  PropertyType(id: 4, name: 'Kitnet/Studio', enumValue: 'kitnet_studio'),
  PropertyType(id: 5, name: 'Loteamento', enumValue: 'loteamento'),
  PropertyType(id: 12, name: 'Loteamento de Condomínio', enumValue: 'loteamento_condominio'),
  PropertyType(id: 6, name: 'Fazenda', enumValue: 'fazenda'),
  PropertyType(id: 7, name: 'Chácara', enumValue: 'chacara'),
  PropertyType(id: 8, name: 'Comercial', enumValue: 'comercial'),
  PropertyType(id: 9, name: 'Galpão', enumValue: 'galpao'),
  PropertyType(id: 10, name: 'Sobrado', enumValue: 'sobrado'),
  PropertyType(id: 11, name: 'Sobrado de Condomínio', enumValue: 'sobrado_condominio'),
];
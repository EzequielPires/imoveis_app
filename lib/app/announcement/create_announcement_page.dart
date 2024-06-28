import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';
import 'package:imoveis_app/models/address.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:imoveis_app/repositories/address_repository.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/cards/card_custom_file.dart';
import 'package:imoveis_app/widgets/form_components/count_field.dart';
import 'package:imoveis_app/widgets/form_components/select_city.dart';
import 'package:imoveis_app/widgets/form_components/select_district.dart';
import 'package:imoveis_app/widgets/form_components/select_state.dart';
import 'package:imoveis_app/widgets/form_components/select_type.dart';
import 'package:imoveis_app/widgets/image_picker.dart';
import 'package:imoveis_app/widgets/multimage_picker.dart';

class CreateAnnouncementPage extends StatefulWidget {
  const CreateAnnouncementPage({super.key});

  @override
  State<CreateAnnouncementPage> createState() => _CreateAnnouncementPageState();
}

class _CreateAnnouncementPageState extends State<CreateAnnouncementPage>
    with TickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  final AddressRepository _addressRepository = AddressRepository();
  late TabController _tabController;
  final AnnouncementFactory _announcementFactory = AnnouncementFactory();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  changeType(PropertyType type) {
    setState(() {
      _announcementFactory.type = type;
      _announcementFactory.typeController.text = type.name;
    });
  }

  changeState(StateAddress state) async {
    List<City> cities = await _addressRepository.findCities(state);

    setState(() {
      _announcementFactory.addressFactory.cities = cities;
      _announcementFactory.addressFactory.districts = [];
      _announcementFactory.addressFactory.stateAddress = state;
      _announcementFactory.addressFactory.stateController.text = state.name;
    });
  }

  changeCity(City city) async {
    List<District> districts = await _addressRepository.findDistricts(city);

    setState(() {
      _announcementFactory.addressFactory.districts = districts;
      _announcementFactory.addressFactory.city = city;
      _announcementFactory.addressFactory.cityController.text = city.name;
    });
  }

  changeDistrict(District district) async {
    setState(() {
      _announcementFactory.addressFactory.district = district;
      _announcementFactory.addressFactory.districtController.text =
          district.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Criar anúncio',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Vender',
              ),
              Tab(
                text: 'Alugar',
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: _announcementFactory.typeController,
              decoration: const InputDecoration(
                label: Text('Tipo de imóvel'),
                hintText: 'Selecione um tipo',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                suffixIcon: Icon(Icons.arrow_drop_down),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              //enabled: !value.isLoading,
              readOnly: true,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => SelectPropertyType(
                    types: propertyTypeData,
                    onSelected: changeType,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _announcementFactory.price,
              decoration: const InputDecoration(
                label: Text('Preço do imóvel'),
                hintText: 'Insira o preço do imóvel',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                prefix: Text('R\$ '),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(
              height: 12,
            ),
            /* Seção de detalhes */
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 8),
              title: const Text(
                'Detalhes do imóvel',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              shape: Border.all(color: Colors.transparent),
              children: [
                CountField(
                  count: _announcementFactory.numberRooms,
                  title: 'Quantos quartos?',
                  onChange: (value) {
                    setState(() {
                      _announcementFactory.numberRooms = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CountField(
                  count: _announcementFactory.numberSuites,
                  title: 'Destes, quantos são suites?',
                  onChange: (value) {
                    setState(() {
                      _announcementFactory.numberSuites = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CountField(
                  count: _announcementFactory.numberBathrooms,
                  title: 'Quantos banheiros?',
                  onChange: (value) {
                    setState(() {
                      _announcementFactory.numberBathrooms = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                CountField(
                  count: _announcementFactory.numberGarages,
                  title: 'E garagens?',
                  onChange: (value) {
                    setState(() {
                      _announcementFactory.numberGarages = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(
              height: 12,
            ),
            /* Seção de endereço */
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 8),
              title: const Text(
                'Endereço do imóvel',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              shape: Border.all(color: Colors.transparent),
              children: [
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller:
                      _announcementFactory.addressFactory.stateController,
                  decoration: const InputDecoration(
                    label: Text('Estado'),
                    hintText: 'Escolha um estado',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  //enabled: !value.isLoading,
                  readOnly: true,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => SelectState(
                        states: _announcementFactory.addressFactory.states,
                        onSelected: changeState,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller:
                      _announcementFactory.addressFactory.cityController,
                  decoration: const InputDecoration(
                    label: Text('Cidade'),
                    hintText: 'Escolha uma cidade',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  readOnly: true,
                  //enabled: !value.isLoading,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => SelectCity(
                        cities: _announcementFactory.addressFactory.cities,
                        onSelected: changeCity,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller:
                      _announcementFactory.addressFactory.districtController,
                  decoration: const InputDecoration(
                    label: Text('Bairro'),
                    hintText: 'Escolha um bairro',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  //enabled: !value.isLoading,
                  readOnly: true,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => SelectDistrict(
                        districts:
                            _announcementFactory.addressFactory.districts,
                        onSelected: changeDistrict,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _announcementFactory.addressFactory.route,
                  decoration: const InputDecoration(
                    label: Text('Rua'),
                    hintText: 'Insira a rua do imóvel',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _announcementFactory.addressFactory.number,
                        decoration: const InputDecoration(
                          label: Text('Número'),
                          hintText: 'Insira a rua do imóvel',
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _announcementFactory.addressFactory.zipcode,
                        decoration: const InputDecoration(
                          label: Text('CEP'),
                          hintText: 'Insira o CEP do imóvel',
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _announcementFactory.addressFactory.complement,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    label: Text('Complemento'),
                    hintText: 'Insira o complamento do imóvel',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(
              height: 12,
            ),
            /* Seção de endereço */
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 8),
              title: const Text(
                'Descrição do imóvel',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              shape: Border.all(color: Colors.transparent),
              children: [
                TextFormField(
                  controller: _announcementFactory.addressFactory.complement,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    label: Text('Breve descrição'),
                    hintText: 'Insira o complamento do imóvel',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _announcementFactory.addressFactory.complement,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    label: Text('Observações do imóvel'),
                    hintText: 'Insira o complamento do imóvel',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _announcementFactory.addressFactory.number,
                        decoration: const InputDecoration(
                          label: Text('Nº da chave'),
                          hintText: 'Insira a rua do imóvel',
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _announcementFactory.addressFactory.zipcode,
                        decoration: const InputDecoration(
                          label: Text('Comissão'),
                          hintText: 'Insira o CEP do imóvel',
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _announcementFactory.addressFactory.number,
                        decoration: const InputDecoration(
                          label: Text('Nº da chave'),
                          hintText: 'Insira a rua do imóvel',
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: IconButton.filled(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(
              height: 12,
            ),
            /* Seção de endereço */
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 8),
              title: const Text(
                'Galeria do imóvel',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              shape: Border.all(color: Colors.transparent),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _announcementFactory.files
                      .map((element) => CardCustomFile(customFile: element))
                      .toList(),
                ),
                const SizedBox(
                  height: 12,
                ),
                MultimagePicker(
                  onImageSelected: (file) {
                    setState(() {
                      _announcementFactory.files.addAll(file);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(
              height: 12,
            ),
            /* Seção de endereço */
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 0, right: 8),
              title: const Text(
                'Adicionais',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              shape: Border.all(color: Colors.transparent),
              children: [
                CheckboxListTile(
                  value: _announcementFactory.isFeatured,
                  title: const Text('Imóvel em destaque?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.isFeatured = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.isDeedRegistered,
                  title: const Text('Imóvel escriturado?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.isDeedRegistered = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.isRegistered,
                  title: const Text('Imóvel averbado?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.isRegistered = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.isFurnished,
                  title: const Text('Imóvel mobiliado?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.isFurnished = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.allowPets,
                  title: const Text('Permite pets?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.allowPets = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.isRoof,
                  title: const Text('É uma cobertura?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.isRoof = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.hasPool,
                  title: const Text('Tem piscina?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.hasPool = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.hasSolarEnergy,
                  title: const Text('Tem energia solar?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.hasSolarEnergy = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.hasSecuritySystem,
                  title: const Text('Tem sistema de segurança?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.hasSecuritySystem = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.hasElectricFence,
                  title: const Text('Tem cerca elétrica?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.hasElectricFence = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.hasConcertina,
                  title: const Text('Tem concertina?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.hasConcertina = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.hasBarbecue,
                  title: const Text('Tem churrasqueira?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.hasBarbecue = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.hasGym,
                  title: const Text('Tem academia?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.hasGym = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.hasSoccerField,
                  title: const Text('Tem campo?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.hasSoccerField = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  value: _announcementFactory.hasCourt,
                  title: const Text('Tem quadra?'),
                  onChanged: (value) {
                    setState(() {
                      _announcementFactory.hasCourt = value ?? false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ButtonPrimary(
          title: 'Salvar imóvel',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Yay! A SnackBar!', style: TextStyle(color: Colors.red),),
              backgroundColor: Colors.red[50],
            ));
          },
        ),
      ),
    );
  }
}

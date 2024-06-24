import 'package:flutter/material.dart';
import 'package:imoveis_app/controllers/filter_announcements_controller.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/cards/card_announcement_full.dart';
import 'package:imoveis_app/widgets/form_components/select_city.dart';
import 'package:imoveis_app/widgets/form_components/select_district.dart';
import 'package:imoveis_app/widgets/form_components/select_state.dart';
import 'package:imoveis_app/widgets/form_components/select_type.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiService _apiService = ApiService();
  List<Announcement> announcements = [];
  AnnouncementQuery query = AnnouncementQuery();
  bool isLoading = true;

  findAnnouncements(AnnouncementQuery? queryData) async {
    try {
      setState(() {
        query = queryData ?? AnnouncementQuery();
        isLoading = true;
      });

      var res = await _apiService.get(
          'property?complete=true&status=disponivel${queryData.toString() != 'null' ? queryData.toString() : ''}',
          {'origin': 'https://imoveis.portalcatalao.com.br'});
      if (res['success']) {
        var results = res['properties'] as List;
        List<Announcement> data = results
            .map(
              (e) => Announcement.fromJson(e),
            )
            .toList();

        setState(() {
          announcements = data;
        });
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    findAnnouncements(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Encontre seu imóvel ideal',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              query.toFilterContent(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialogFilter(
                    onSelected: (query) => findAnnouncements(query),
                  ),
                );
              },
              icon: const Icon(Icons.tune_outlined))
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) =>
                  CardAnnouncementFull(announcement: announcements[index]),
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: announcements.length,
            ),
    );
  }
}

class CustomDialogFilter extends StatefulWidget {
  final void Function(AnnouncementQuery query) onSelected;
  const CustomDialogFilter({super.key, required this.onSelected});

  @override
  State<CustomDialogFilter> createState() => _CustomDialogFilterState();
}

class _CustomDialogFilterState extends State<CustomDialogFilter>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterAnnouncementsController>(
      builder: (context, value, child) => Dialog.fullscreen(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Filtrar imóveis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            toolbarHeight: 80,
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  onTap: (v) => value.changeAdType(
                      v == 0 ? PropertyAdType.venda : PropertyAdType.aluguel),
                  tabs: const [
                    Tab(
                      text: 'Comprar',
                    ),
                    Tab(
                      text: 'Alugar',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: value.stateController,
                  decoration: const InputDecoration(
                    label: Text('Estado'),
                    hintText: 'Escolha um estado',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  enabled: !value.isLoading,
                  readOnly: true,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => SelectState(
                        states: value.states,
                        onSelected: (state) {
                          value.changeState(state);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: value.cityController,
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
                  enabled: !value.isLoading,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => SelectCity(
                        cities: value.cities,
                        onSelected: (cityData) {
                          value.changeCity(cityData);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: value.districtController,
                  decoration: const InputDecoration(
                    label: Text('Bairro'),
                    hintText: 'Escolha um bairro',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  enabled: !value.isLoading,
                  readOnly: true,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => SelectDistrict(
                        districts: value.districts,
                        onSelected: (district) {
                          value.changeDistrict(district);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: value.typeController,
                  decoration: const InputDecoration(
                    label: Text('Tipo de imóvel'),
                    hintText: 'Selecione um tipo',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  enabled: !value.isLoading,
                  readOnly: true,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => SelectPropertyType(
                        types: value.types,
                        onSelected: (type) {
                          value.changeType(type);
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextButton(
                  onPressed: () {
                    value.clearFilter();
                    widget.onSelected(AnnouncementQuery(
                        city: value.city,
                        district: value.district,
                        state: value.stateAddress,
                        type: value.type,
                        adType: value.adType));
                    Navigator.pop(context);
                  },
                  child: const Text('Limpar filtro'),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: ButtonPrimary(
              title: 'Buscar imóveis',
              onPressed: () {
                widget.onSelected(AnnouncementQuery(
                    city: value.city,
                    district: value.district,
                    state: value.stateAddress,
                    type: value.type,
                    adType: value.adType));
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}

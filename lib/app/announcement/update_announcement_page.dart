import 'package:flutter/material.dart';
import 'package:imoveis_app/app/announcement/components/additional_section.dart';
import 'package:imoveis_app/app/announcement/components/address_section.dart';
import 'package:imoveis_app/app/announcement/components/description_section.dart';
import 'package:imoveis_app/app/announcement/components/details_section.dart';
import 'package:imoveis_app/app/announcement/components/gallery_section.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:imoveis_app/repositories/announcements_repository.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/cards/card_custom_file.dart';
import 'package:imoveis_app/widgets/form_components/select_type.dart';
import 'package:imoveis_app/widgets/image_picker.dart';

class UpdateAnnouncementPage extends StatefulWidget {
  final Announcement announcement;
  const UpdateAnnouncementPage({super.key, required this.announcement});

  @override
  State<UpdateAnnouncementPage> createState() => _UpdateAnnouncementPageState();
}

class _UpdateAnnouncementPageState extends State<UpdateAnnouncementPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final AnnouncementsRepository _announcementsRepository =
      AnnouncementsRepository();
  final AnnouncementFactory _announcementFactory = AnnouncementFactory();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _announcementFactory.hydrate(widget.announcement);
    super.initState();
  }

  changeType(PropertyType type) {
    setState(() {
      _announcementFactory.type = type;
      _announcementFactory.typeController.text = type.name;
    });
  }

  handleSubmit() async {
    var valid = _announcementFactory.isValid();
    if (valid == null) {
      var res = await _announcementsRepository.update(
          widget.announcement.id!, _announcementFactory.toJson());
      if (res.success && res.announcement != null) {
        if (_announcementFactory.thumbnail != null) {
          await _announcementsRepository.uploadThumbnail(
              widget.announcement.id!, _announcementFactory.thumbnail!);
        }
        await _announcementsRepository.uploadImages(
            widget.announcement.id!, _announcementFactory.files);
      }
    } else {
      handleError(valid);
    }
  }

  handleError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.red[50],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          'Atualizar anúncio',
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
                prefix: Text(
                  'R\$ ',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.indigo),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text('Foto de capa'),
            const SizedBox(
              height: 8,
            ),
            _announcementFactory.thumbnail != null
                ? CardCustomFile(
                    customFile: _announcementFactory.thumbnail!,
                    full: true,
                  )
                : ButtonImagePicker(
                    onImageSelected: (file) {
                      setState(() {
                        _announcementFactory.thumbnail = file;
                      });
                    },
                  ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.grey[200],
            ),
            DetailsSection(announcementFactory: _announcementFactory),
            Divider(
              color: Colors.grey[200],
            ),
            AddressSection(announcementFactory: _announcementFactory),
            Divider(
              color: Colors.grey[200],
            ),
            DescriptionSection(announcementFactory: _announcementFactory),
            Divider(
              color: Colors.grey[200],
            ),
            GallerySection(announcementFactory: _announcementFactory),
            Divider(
              color: Colors.grey[200],
            ),
            AdditionalSection(announcementFactory: _announcementFactory),
            Divider(
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ButtonPrimary(
          title: 'Salvar imóvel',
          onPressed: handleSubmit,
        ),
      ),
    );
  }
}

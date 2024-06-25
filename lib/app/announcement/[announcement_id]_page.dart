import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imoveis_app/helpers/date.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/real_estate_wrapper.dart';
import 'package:imoveis_app/widgets/realtor_wrapper.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementViewPage extends StatefulWidget {
  final Announcement announcement;
  const AnnouncementViewPage({super.key, required this.announcement});

  @override
  State<AnnouncementViewPage> createState() => _AnnouncementViewPageState();
}

class _AnnouncementViewPageState extends State<AnnouncementViewPage> {
  late final Announcement announcement;
  late final String? phoneNumber;
  late final String? email;
  List<String> images = [];

  String formatCurrency(int number) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(number / 100);
  }

  void _openWhatsApp() async {
    if (phoneNumber != null) {
      final url = Uri.parse('https://wa.me/+55$phoneNumber');

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void _openCellphone() async {
    if (phoneNumber != null) {
      final url = Uri.parse('tel:$phoneNumber');

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void _openMail() async {
    if (email != null) {
      final url = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          'subject': '',
          'body': '',
        },
      );

      await launchUrl(url);
    }
  }

  @override
  void initState() {
    announcement = widget.announcement;
    announcement.thumbnail != null ? images.add(announcement.thumbnail!) : null;
    announcement.images != null && announcement.images!.isNotEmpty
        ? images = [...images, ...announcement.images!]
        : null;
    phoneNumber = announcement.realtor?.cellPhone ??
        announcement.realEstate?.cellPhone ??
        announcement.owner?.cellPhone;
    email = announcement.realtor?.email ??
        announcement.realEstate?.email ??
        announcement.owner?.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Share.share('Veja este imóvel incrível! Confira mais detalhes e fotos aqui: https://imoveis.portalcatalao.com.br/imovel/${announcement.id}');
              },
              icon: const Icon(Icons.share_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
        ],
        title: const Text(
          'Detalhes do anúncio',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: MediaQuery.of(context).size.width / 248,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                height: 248,
              ),
              items: images
                  .map((item) => Container(
                        child: Center(
                          child: Image.network(
                            item.startsWith('storage') ?
                            'https://api.imoveis.portalcatalao.com.br/$item' : item,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 248,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'R\$${formatCurrency(int.parse(announcement.value))}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
                    ),
                  ),
                  Text(
                    announcement.getFullTitle(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600, height: 1.2),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'em ${announcement.address?.city?.name} - ${announcement.address?.state?.shortName}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Publicado em ${formatFullDate(announcement.createdAt.toString())}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Descrição',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    announcement.description ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      announcement.totalArea.isNotEmpty
                          ? Expanded(
                              child: Column(
                                children: [
                                  const Icon(Icons.straighten_outlined),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(announcement.totalArea),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text('Área m2'),
                                ],
                              ),
                            )
                          : Container(),
                      announcement.totalArea.isNotEmpty
                          ? const SizedBox(
                              width: 16,
                            )
                          : Container(),
                      announcement.numberRooms > 0
                          ? Expanded(
                              child: Column(
                                children: [
                                  const Icon(Icons.bed_outlined),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('${announcement.numberRooms}'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text('Quartos'),
                                ],
                              ),
                            )
                          : Container(),
                      announcement.numberRooms > 0
                          ? const SizedBox(
                              width: 16,
                            )
                          : Container(),
                      announcement.numberBathrooms > 0
                          ? Expanded(
                              child: Column(
                                children: [
                                  const Icon(Icons.shower_outlined),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('${announcement.numberBathrooms}'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text('Banheiros'),
                                ],
                              ),
                            )
                          : Container(),
                      announcement.numberBathrooms > 0
                          ? const SizedBox(
                              width: 16,
                            )
                          : Container(),
                      announcement.numberGarages > 0
                          ? Expanded(
                              child: Column(
                                children: [
                                  const Icon(Icons.directions_car_outlined),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('${announcement.numberGarages}'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text('Vagas'),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Anunciado por',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  announcement.realtor != null
                      ? RealtorWrapper(realtor: announcement.realtor!)
                      : announcement.realEstate != null
                          ? RealEstateWrapper(
                              realEstate: announcement.realEstate!)
                          : announcement.owner != null
                              ? RealtorWrapper(realtor: announcement.owner!)
                              : Container(),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Row(
          children: [
            phoneNumber != null
                ? SizedBox(
                    width: 56,
                    height: 56,
                    child: IconButton.filled(
                      onPressed: _openWhatsApp,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.green),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)))),
                      icon: const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
            phoneNumber != null
                ? const SizedBox(
                    width: 8,
                  )
                : Container(),
            Expanded(
                child: ButtonPrimary(
              title: 'Contatar',
              onPressed: () async {
                await showModalBottomSheet<void>(
                  backgroundColor: Colors.white,
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.email_outlined),
                              title: const Text('E-mail'),
                              onTap: _openMail,
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone_outlined),
                              title: const Text('Ligar'),
                              onTap: _openCellphone,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

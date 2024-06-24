import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imoveis_app/app/announcement/%5Bannouncement_id%5D_page.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:intl/intl.dart';

class CardAnnouncementFull extends StatelessWidget {
  final Announcement announcement;
  const CardAnnouncementFull({super.key, required this.announcement});

  String formatCurrency(int number) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(number / 100);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnnouncementViewPage(
                announcement: announcement,
              ),
            )),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 228,
                    child: announcement.thumbnail != null
                        ? Image.network(
                            announcement.thumbnail!.startsWith('storage') ? 'https://api.imoveis.portalcatalao.com.br/${announcement.thumbnail!}' : announcement.thumbnail!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 228,
                          )
                        : const Icon(Icons.image),
                  ),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        announcement.adType == 'venda' ? 'Venda' : 'Aluguel',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          propertyTypeData.firstWhere((item) => item.enumValue == announcement.type).name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.circle,
                          size: 4,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${announcement.address?.city?.name} - ${announcement.address?.state?.shortName}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      announcement.getFullTitle(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Row(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bed_outlined),
                            SizedBox(
                              width: 4,
                            ),
                            Text('3')
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Row(
                          children: [
                            Icon(Icons.shower_outlined),
                            SizedBox(
                              width: 4,
                            ),
                            Text('3')
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Row(
                          children: [
                            Icon(Icons.directions_car_outlined),
                            SizedBox(
                              width: 4,
                            ),
                            Text('2')
                          ],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'R\$${formatCurrency(int.parse(announcement.value))}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/donasi_ini.dart';
import 'package:intl/intl.dart';

class CampaignCard extends StatelessWidget {
  final Donasi donasi;
  const CampaignCard({Key? key, required this.donasi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rupiah = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    final dateFmt = DateFormat('dd/MM/yyyy');
    final collected = donasi.displayCollected;
    final target = donasi.displayTarget == 0 ? 1 : donasi.displayTarget;
    final progress = donasi.progressPercentage.clamp(0.0, 1.0);

    String expired = '-';
    if (donasi.displayDeadline.isNotEmpty) {
      try {
        expired = dateFmt.format(DateTime.parse(donasi.displayDeadline));
      } catch (_) {}
    }

    return Container(
      width: 220,
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            // TODO: navigate to campaign detail
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: donasi.displayImage.isNotEmpty
                  ? Image.network(
                      donasi.displayImage,
                      width: 220,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        color: Colors.grey[300],
                        height: 110,
                        width: 220,
                        child: const Icon(Icons.broken_image, size: 40),
                      ),
                    )
                  : Container(
                      width: 220,
                      height: 110,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 40),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    Text(
                      donasi.displayTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Progress bar & percent
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 7,
                            backgroundColor: Colors.grey[200],
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('${(progress * 100).round()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Collected & expired
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('collected',
                                style: TextStyle(fontSize: 11, color: Colors.grey)),
                            Text(
                              rupiah.format(collected),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('expired',
                                style: TextStyle(fontSize: 11, color: Colors.grey)),
                            Text(
                              expired,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
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
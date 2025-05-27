import 'package:flutter/material.dart';
import '../models/donasi_ini.dart';
import '../services/api_service.dart';
import '../widgets/widgets.dart';
import '../widgets/campaign_card.dart'; // pastikan import ini ada
import 'emergency_bantoo_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<Donasi>> futureDonasi;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureDonasi = ApiService.getDonasi();
  }

  void _refresh() => setState(() => futureDonasi = ApiService.getDonasi());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: dashboardAppBar(onRefresh: _refresh),
      body: RefreshIndicator(
        onRefresh: () async => _refresh(),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: GreetingCard()),
            const SliverToBoxAdapter(child: SearchBarDash()),

            SectionHeader(
              title: 'Emergency Bantoo!',
              showSeeAll: true,
              onSeeAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmergencyBantooScreen(),
                  ),
                ).then((_) => _refresh());
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250, // sedikit lebih tinggi agar card & progress bar muat
                child: FutureBuilder<List<Donasi>>(
                  future: futureDonasi,
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snap.hasError) {
                      return Center(child: Text('Error: ${snap.error}'));
                    }
                    // Ambil semua data donasi tanpa filter emergency!
                    final data = snap.data ?? [];
                    if (data.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.campaign_outlined,
                              size: 40,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Belum ada donasi',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/add-campaign')
                                  .then((_) => _refresh());
                              },
                              child: const Text('Tambah Campaign'),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: data.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) => CampaignCard(donasi: data[i]),
                    );
                  },
                ),
              ),
            ),

            const SectionHeader(title: 'The Event Is About To Expire'),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 310,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) => EventCard(
                    title: 'Pelatihan One Day Thousand Smiles',
                    subtitle: 'Surabaya, Jawa Timur • 14/05/2025',
                    imageAsset: 'assets/images/event_$i.jpg',
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 50),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SectionHeader(title: 'Choose Bantoo Favourite Category'),
            const SliverToBoxAdapter(child: CategoryChips()),

            const SectionHeader(title: 'Ask For New Campaign'),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/add-campaign')
                    .then((_) => _refresh());
                },
                child: const BannerAddCampaign(),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    '© 2025 Bantoo — All rights reserved',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: mainBottomBar(
        current: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
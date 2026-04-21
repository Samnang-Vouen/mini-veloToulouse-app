import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:velotoulouse/ui/screens/map/view_model/map_view_model.dart';
import 'package:velotoulouse/ui/screens/station/station_detail_screen.dart';
import 'package:velotoulouse/ui/theme/theme.dart';
import 'package:velotoulouse/ui/widgets/map_icon_button.dart';
import 'package:velotoulouse/ui/widgets/map_search_bar.dart';
import 'package:velotoulouse/ui/widgets/station_marker_widget.dart';

class MapContent extends StatefulWidget {
  const MapContent({super.key});

  @override
  State<MapContent> createState() => _MapContentState();
}

class _MapContentState extends State<MapContent> {
  final MapController _mapController = MapController();
  static const LatLng _watPhnom = LatLng(11.5754, 104.9214);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MapViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: _watPhnom,
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.velotoulouse',
              ),
              MarkerLayer(
                markers: vm.filteredStations.map((station) {
                  return Marker(
                    point: LatLng(station.latitude, station.longitude),
                    width: 48,
                    height: 48,
                    child: GestureDetector(
                      onTap: () {
                        final mapVm = context.read<MapViewModel>();
                        Navigator.push<Set<String>>(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ChangeNotifierProvider<MapViewModel>.value(
                                  value: mapVm,
                                  child: StationDetailScreen(station: station),
                                ),
                          ),
                        ).then((bookedDockIds) {
                          if (!context.mounted) return;
                          mapVm.recordBookings(station.id, bookedDockIds ?? {});
                          mapVm.loadStations();
                        });
                      },
                      child: StationMarkerWidget(
                        count: vm.effectiveAvailableBikes(station),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            right: 16,
            child: const MapSearchBar(),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 16,
            child: const _BikeShortcutButton(),
          ),

          Positioned(
            right: 16,
            bottom: 130,
            child: Column(
              children: [
                MapIconButton(
                  icon: Icons.refresh,
                  onTap: () => _mapController.move(_watPhnom, 14),
                ),
                const SizedBox(height: 10),
                MapIconButton(
                  icon: Icons.my_location,
                  onTap: () => _mapController.move(_watPhnom, 15),
                ),
              ],
            ),
          ),

          if (vm.stationsValue.isLoading)
            const Positioned.fill(
              child: ColoredBox(
                color: AppColors.shadowMedium,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),

          if (vm.stationsValue.isError)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: _ErrorBanner(
                  message: vm.stationsValue.error.toString(),
                  onRetry: () => context.read<MapViewModel>().loadStations(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BikeShortcutButton extends StatelessWidget {
  const _BikeShortcutButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(Icons.directions_bike, color: Colors.white, size: 22),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorBanner({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.error,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.label.copyWith(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: AppTextStyles.label.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

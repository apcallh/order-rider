import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:order_rider/app/theme/app_colors.dart';
import 'package:order_rider/core/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mc = MapController();
  LatLng _center = const LatLng(24.7136, 46.6753);
  LatLng? _me;
  bool _follow = true;
  bool _is3D = false;
  double _zoom = 13;
  double _pitch = 0;

  @override
  void initState() {
    super.initState();
    _goToMe(silent: true);
  }

  Future<void> _goToMe({bool silent = false}) async {
    try {
      var p = await Geolocator.checkPermission();
      if (p == LocationPermission.denied) {
        p = await Geolocator.requestPermission();
      }
      if (p == LocationPermission.denied ||
          p == LocationPermission.deniedForever) {
        if (!silent && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('لم يتم منح صلاحية الموقع')),
          );
        }
        return;
      }
      final pos = await Geolocator.getCurrentPosition();
      final loc = LatLng(pos.latitude, pos.longitude);
      setState(() {
        _me = loc;
        _center = loc;
      });
      _mc.move(loc, 16);
    } catch (e) {
      if (!silent && mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('تعذر تحديد الموقع: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mc,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: _zoom,
              minZoom: 2,
              maxZoom: 19,
              onPositionChanged: (cam, has) {
                if (has) {
                  setState(() {
                    _follow = false;
                    _zoom = cam.zoom;
                    _pitch = cam.rotation;
                  });
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: AppConstants.osmTileUrl,
                userAgentPackageName: AppConstants.osmUserAgent,
                maxZoom: 19,
              ),
              if (_me != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _me!,
                      width: 60,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryBlue.withOpacity(0.2),
                          border: Border.all(
                              color: AppColors.primaryBlue, width: 2),
                        ),
                        child: const Icon(Icons.navigation,
                            color: AppColors.primaryBlue, size: 28),
                      ),
                    ),
                  ],
                ),
              const RichAttributionWidget(
                attributions: [
                  TextSourceAttribution('OpenStreetMap contributors'),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3), blurRadius: 12),
                  ],
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'ابحث عن موقع...',
                    hintStyle: TextStyle(color: AppColors.textSecondaryDark),
                    prefixIcon:
                        Icon(Icons.search, color: AppColors.primaryBlue),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 120,
            child: Column(
              children: [
                _Btn(
                  icon: Icons.add,
                  onTap: () {
                    _zoom = (_zoom + 1).clamp(2, 19);
                    _mc.move(_mc.camera.center, _zoom);
                  },
                ),
                const SizedBox(height: 8),
                _Btn(
                  icon: Icons.remove,
                  onTap: () {
                    _zoom = (_zoom - 1).clamp(2, 19);
                    _mc.move(_mc.camera.center, _zoom);
                  },
                ),
                const SizedBox(height: 8),
                _Btn(
                  icon: _is3D ? Icons.view_in_ar : Icons.map_outlined,
                  onTap: () {
                    setState(() {
                      _is3D = !_is3D;
                      _pitch = _is3D ? 60 : 0;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_is3D
                            ? 'وضع ثلاثي الأبعاد مفعّل'
                            : 'وضع ثنائي الأبعاد'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            bottom: 40,
            child: FloatingActionButton(
              heroTag: 'loc',
              onPressed: () {
                setState(() => _follow = true);
                _goToMe();
              },
              backgroundColor:
                  _follow ? AppColors.primaryBlue : AppColors.darkCard,
              child: Icon(Icons.my_location,
                  color: _follow ? Colors.white : AppColors.primaryBlue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mc.dispose();
    super.dispose();
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _Btn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.darkSurface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

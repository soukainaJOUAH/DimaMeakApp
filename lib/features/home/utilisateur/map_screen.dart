import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';

enum _ProviderType { helper, association }
enum _FilterType { all, helpers, associations }

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _defaultCenter = LatLng(33.5731, -7.5898);
  static const double _defaultZoom = 13.2;

  GoogleMapController? _mapController;
  Position? _userPosition;
  bool _locationReady = false;
  bool _locationDenied = false;
  String? _locationError;
  _FilterType _filter = _FilterType.all;

  final List<_Provider> _providers = [];

  @override
  void initState() {
    super.initState();
    _seedProviders();
    _initLocation();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _initLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationReady = true;
          _locationDenied = true;
          _locationError = 'Localisation indisponible';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _locationReady = true;
          _locationDenied = true;
          _locationError = 'Autorisation de localisation refusée';
        });
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;
      setState(() {
        _userPosition = position;
        _locationReady = true;
        _locationDenied = false;
        _locationError = null;
      });

      _animateToUser();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _locationReady = true;
        _locationDenied = true;
        _locationError = 'Localisation indisponible';
      });
    }
  }

  void _seedProviders() {
    _providers.clear();
    _providers.addAll([
      _Provider(
        id: 'h1',
        name: 'Amina El Idrissi',
        type: _ProviderType.helper,
        services: const ['Accompagnement', 'Courses', 'Transport'],
        position: const LatLng(33.58, -7.60),
      ),
      _Provider(
        id: 'h2',
        name: 'Youssef Benali',
        type: _ProviderType.helper,
        services: const ['Aide administrative', 'Assistance quotidienne'],
        position: const LatLng(33.568, -7.575),
      ),
      _Provider(
        id: 'h3',
        name: 'Nadia Rami',
        type: _ProviderType.helper,
        services: const ['Accompagnement medical', 'Lecture vocale'],
        position: const LatLng(33.563, -7.605),
      ),
      _Provider(
        id: 'a1',
        name: 'Association Rahma',
        type: _ProviderType.association,
        services: const ['Soutien social', 'Aides materielles'],
        position: const LatLng(33.575, -7.56),
      ),
      _Provider(
        id: 'a2',
        name: 'Fondation Al Amal',
        type: _ProviderType.association,
        services: const ['Reeducation', 'Aide psychologique'],
        position: const LatLng(33.585, -7.57),
      ),
    ]);
  }

  LatLng _currentCenter() {
    if (_userPosition == null) return _defaultCenter;
    return LatLng(_userPosition!.latitude, _userPosition!.longitude);
  }

  Future<void> _animateToUser() async {
    if (_mapController == null) return;
    final target = _currentCenter();
    await _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 15.2),
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};

    for (final provider in _providers) {
      if (_filter == _FilterType.helpers && provider.type != _ProviderType.helper) {
        continue;
      }
      if (_filter == _FilterType.associations && provider.type != _ProviderType.association) {
        continue;
      }

      final hue = provider.type == _ProviderType.helper
          ? BitmapDescriptor.hueGreen
          : BitmapDescriptor.hueAzure;

      markers.add(
        Marker(
          markerId: MarkerId(provider.id),
          position: provider.position,
          icon: BitmapDescriptor.defaultMarkerWithHue(hue),
          onTap: () => _showProviderSheet(provider),
        ),
      );
    }
    return markers;
  }

  double? _distanceKm(LatLng target) {
    if (_userPosition == null) return null;
    final meters = Geolocator.distanceBetween(
      _userPosition!.latitude,
      _userPosition!.longitude,
      target.latitude,
      target.longitude,
    );
    return meters / 1000.0;
  }

  void _showProviderSheet(_Provider provider) {
    final distanceKm = _distanceKm(provider.position);
    final distanceText = distanceKm == null
        ? 'Distance inconnue'
        : distanceKm < 1
            ? '${(distanceKm * 1000).round()} m'
            : '${distanceKm.toStringAsFixed(1)} km';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: provider.type == _ProviderType.helper
                            ? const Color(0xFF1BA9B5)
                            : const Color(0xFF0A3D91),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.place, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            provider.type == _ProviderType.helper
                                ? 'Accompagnant'
                                : 'Association',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3F8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        distanceText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Services offerts',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: provider.services
                      .map(
                        (service) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6FB),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            service,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.call,
                        label: 'Appeler',
                        onTap: () => _showActionSnack('Appel en cours...'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.message,
                        label: 'Message',
                        onTap: () => _showActionSnack('Ouverture du message...'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.directions,
                        label: 'Itineraire',
                        onTap: () {
                          Navigator.pop(context);
                          _focusOnProvider(provider.position);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showActionSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _focusOnProvider(LatLng position) async {
    if (_mapController == null) return;
    await _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 16.5),
      ),
    );
  }

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtrer les affichages',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                _FilterTile(
                  label: 'Tout',
                  selected: _filter == _FilterType.all,
                  onTap: () => _setFilter(_FilterType.all),
                ),
                _FilterTile(
                  label: 'Accompagnants',
                  selected: _filter == _FilterType.helpers,
                  onTap: () => _setFilter(_FilterType.helpers),
                ),
                _FilterTile(
                  label: 'Associations',
                  selected: _filter == _FilterType.associations,
                  onTap: () => _setFilter(_FilterType.associations),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _setFilter(_FilterType filter) {
    setState(() => _filter = filter);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'La carte Google n’est pas disponible sur le web.\nUtilisez l’app mobile.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final markers = _buildMarkers();
    final mapPadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _defaultCenter,
              zoom: _defaultZoom,
            ),
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: !_locationDenied && _locationError == null,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: markers,
            mapToolbarEnabled: false,
            compassEnabled: true,
            padding: EdgeInsets.only(bottom: mapPadding.bottom + 90),
          ),
          Positioned(
            top: mapPadding.top + 12,
            left: 16,
            right: 16,
            child: _TopBar(
              onFilterTap: _openFilterSheet,
              filterLabel: _filter == _FilterType.helpers
                  ? 'Accompagnants'
                  : _filter == _FilterType.associations
                      ? 'Associations'
                      : 'Tout',
            ),
          ),
          Positioned(
            right: 16,
            bottom: mapPadding.bottom + 24,
            child: Column(
              children: [
                _CircleFab(
                  icon: Icons.filter_list,
                  tooltip: 'Filtrer',
                  onTap: _openFilterSheet,
                ),
                const SizedBox(height: 12),
                _CircleFab(
                  icon: Icons.my_location,
                  tooltip: 'Ma position',
                  onTap: _animateToUser,
                ),
              ],
            ),
          ),
          if (_locationError != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Center(
                child: _LoadingChip(label: _locationError!),
              ),
            )
          else if (_locationDenied && _locationReady)
            const Positioned(
              left: 0,
              right: 0,
              bottom: 24,
              child: Center(
                child: _LoadingChip(label: 'Localisation desactivee'),
              ),
            ),
        ],
      ),
    );
  }
}

class _Provider {
  final String id;
  final String name;
  final _ProviderType type;
  final List<String> services;
  final LatLng position;

  const _Provider({
    required this.id,
    required this.name,
    required this.type,
    required this.services,
    required this.position,
  });
}

class _TopBar extends StatelessWidget {
  final VoidCallback onFilterTap;
  final String filterLabel;

  const _TopBar({
    required this.onFilterTap,
    required this.filterLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.map, color: Color(0xFF0A3D91)),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Autour de vous',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          InkWell(
            onTap: onFilterTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.tune, size: 18, color: Color(0xFF0A3D91)),
                  const SizedBox(width: 6),
                  Text(
                    filterLabel,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleFab extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _CircleFab({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 6,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 52,
          height: 52,
          child: Tooltip(
            message: tooltip,
            child: Icon(icon, color: const Color(0xFF0A3D91), size: 26),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0A3D91),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF0A3D91) : const Color(0xFFF4F6FB),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? Colors.white : Colors.black54,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingChip extends StatelessWidget {
  final String label;

  const _LoadingChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.75),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}

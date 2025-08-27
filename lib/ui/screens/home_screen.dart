import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_project/core/services/location_service.dart';
import 'package:interview_project/core/utils/distance.dart';
import '../../features/stations/presentation/bloc/station_bloc.dart';
import '../../features/stations/presentation/bloc/station_event.dart';
import '../../features/stations/presentation/bloc/station_state.dart';
import '../widgets/station_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final _locationService = LocationService();
  bool _loading = true;
  LocationResult? _result;
  bool? _lastGranted;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _load();
    }
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() => _loading = true);
    final res = await _locationService.fetch();
    if (!mounted) return;
    final prevGranted = _lastGranted;
    setState(() {
      _result = res;
      _loading = false;
      _lastGranted = res.granted;
    });
    if (_lastGranted == true && prevGranted != true) {
      // nově povoleno → reload pro přepočet vzdáleností
      if (mounted) {
        context.read<StationBloc>().add(LoadStations());
      }
    }
  }

  Widget _buildLocationIndicator() {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    final r = _result;
    if (r == null) return const SizedBox.shrink();
    if (r.granted) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          '${r.position!.latitude.toStringAsFixed(5)}, ${r.position!.longitude.toStringAsFixed(5)}',
          style: const TextStyle(fontSize: 12),
        ),
      );
    }
    if (r.serviceDisabled) {
      return IconButton(
        tooltip: 'Zapněte služby polohy',
        onPressed: _load,
        icon: const Icon(Icons.location_disabled),
      );
    }
    if (r.denied) {
      return IconButton(
        tooltip: 'Povolit polohu',
        onPressed: _load,
        icon: const Icon(Icons.location_off),
      );
    }
    if (r.deniedForever) {
      return IconButton(
        tooltip: 'Nastavení aplikace',
        onPressed: () async {
          await _locationService.openAppSettings();
          await _locationService.openLocationSettings();
        },
        icon: const Icon(Icons.lock, color: Colors.redAccent),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StationBloc>();
    final pos = _result?.granted == true ? _result!.position : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Místo'),
        actions: [_buildLocationIndicator()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Hledat (min. 3 znaky)...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) {
                if (v.length >= 3) {
                  bloc.add(SearchStations(v));
                } else {
                  bloc.add(LoadStations());
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<StationBloc, StationState>(
              builder: (context, state) {
                if (state.status == StationStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == StationStatus.failure) {
                  return Center(child: Text('Chyba: ${state.error}'));
                }
                if (state.stations.isEmpty) {
                  return const Center(child: Text('Žádné výsledky'));
                }
                return ListView.builder(
                  itemCount: state.stations.length,
                  itemBuilder: (c, i) {
                    final s = state.stations[i];
                    double? distKm;
                    if (pos != null) {
                      distKm = distanceMeters(
                        pos.latitude,
                        pos.longitude,
                        s.lat,
                        s.lon,
                      ) /
                          1000.0;
                    }
                    return StationTile(
                      station: s,
                      distanceKm: distKm,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: (_result?.deniedForever ?? false)
          ? FloatingActionButton.extended(
        onPressed: () async {
          await _locationService.openAppSettings();
          await _locationService.openLocationSettings();
        },
        label: const Text('Nastavení'),
        icon: const Icon(Icons.settings),
      )
          : null,
    );
  }
}
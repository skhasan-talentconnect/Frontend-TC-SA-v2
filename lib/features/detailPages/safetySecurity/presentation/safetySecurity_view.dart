import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/detailPages/safetySecurity/data/entities/safety-security-model.dart';
import 'view_models/safetySecurity_view_model.dart';


class SafetyAndSecurityView extends StatefulWidget {
  const SafetyAndSecurityView({super.key});

  @override
  State<SafetyAndSecurityView> createState() => _SafetyAndSecurityViewState();
}

class _SafetyAndSecurityViewState extends State<SafetyAndSecurityView> {
  final SafetyAndSecurityViewModel _vm = SafetyAndSecurityViewModel();
  String _schoolId = '';
  String _schoolName = 'Safety & Security';
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInitialized) return;
    _isInitialized = true;

    final extra = GoRouterState.of(context).extra;
    if (extra is Map) {
      _schoolId = extra['schoolId'] as String? ?? '';
      _schoolName = extra['schoolName'] as String? ?? 'Safety & Security';
    }

    if (_schoolId.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _vm.getSafetyAndSecurityBySchoolId(schoolId: _schoolId);
      });
    }
  }

  Future<void> _refresh() async {
    if (_schoolId.isNotEmpty) {
      await _vm.getSafetyAndSecurityBySchoolId(schoolId: _schoolId);
    }
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _vm,
      child: Scaffold(
        // --- THEME UPDATE ---
        backgroundColor: Colors.white,
        appBar: SAppBar(
          title: _schoolName,
          leading: SIcon(
            icon: Icons.keyboard_arrow_left,
            onTap: () => context.pop(),
          ),
        ),
        body: Consumer<SafetyAndSecurityViewModel>(
          builder: (context, vm, _) {
            if (vm.viewState == ViewState.busy) {
              return const Center(child: SLoadingIndicator(color: Colors.amber));
            }

            final model = vm.safetyAndSecurity;

            if (model == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.health_and_safety_outlined, size: 60, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      vm.message ?? "No safety data found.",
                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                    ),
                  ],
                )
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              // --- THEME UPDATE ---
              color: Colors.amber,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildCctvCard(context, model.cctvCoveragePercentage),
                  const SizedBox(height: 20),
                  _buildMedicalCard(context, model.medicalFacility),
                  const SizedBox(height: 20),
                  _buildTransportCard(context, model.transportSafety),
                  const SizedBox(height: 20),
                  _buildGeneralSafetyCard(context, model.fireSafetyMeasures, model.visitorManagementSystem),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCctvCard(BuildContext context, double? percentage) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // --- THEME UPDATE ---
      color: Colors.white,
      shadowColor: Colors.amber.shade100.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('CCTV Coverage', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                if (percentage != null)
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      // --- THEME UPDATE ---
                      color: Colors.amber
                    ),
                  ),
              ],
            ),
            if (percentage != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  minHeight: 12,
                  // --- THEME UPDATE ---
                  backgroundColor: Colors.orange.shade100,
                  color: Colors.amber,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalCard(BuildContext context, MedicalFacilityModel? medicalFacility) {
    if (medicalFacility == null) return const SizedBox.shrink();
    return _TitledCard(
      title: 'Medical Facility',
      icon: Icons.medical_services_outlined,
      // --- THEME UPDATE ---
      iconColor: Colors.amber,
      children: [
        _InfoTile(
          title: 'Doctor Availability',
          value: medicalFacility.doctorAvailability ?? 'N/A',
        ),
        _CheckTile(title: 'Med-Kit Available', isAvailable: medicalFacility.medkitAvailable),
        _CheckTile(title: 'Ambulance On-site', isAvailable: medicalFacility.ambulanceAvailable),
      ],
    );
  }

  Widget _buildTransportCard(BuildContext context, TransportSafetyModel? transportSafety) {
     if (transportSafety == null) return const SizedBox.shrink();
    return _TitledCard(
      title: 'Transport Safety',
      icon: Icons.directions_bus_outlined,
      // --- THEME UPDATE ---
      iconColor: Colors.amber,
      children: [
        _CheckTile(title: 'GPS Trackers in Buses', isAvailable: transportSafety.gpsTrackerAvailable),
        _CheckTile(title: 'Verified Drivers', isAvailable: transportSafety.driversVerified),
      ],
    );
  }

  Widget _buildGeneralSafetyCard(BuildContext context, List<String> fireMeasures, bool? visitorManagement) {
    return _TitledCard(
      title: 'General Safety',
      icon: Icons.health_and_safety_outlined,
      // --- THEME UPDATE ---
      iconColor: Colors.amber,
      children: [
        _CheckTile(title: 'Visitor Management System', isAvailable: visitorManagement),
        const SizedBox(height: 8),
        if (fireMeasures.isNotEmpty) ...[
          const Text('Fire Safety Measures:', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: fireMeasures.map((measure) => Chip(
              label: Text(measure),
              // --- THEME UPDATE ---
              backgroundColor: Colors.amber.withOpacity(0.1),
              side: BorderSide(color: Colors.amber.withOpacity(0.3)),
            )).toList(),
          )
        ],
      ],
    );
  }
}


// --- Local Helper Widgets for this View ---

class _TitledCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Widget> children;
  const _TitledCard({required this.title, required this.icon, required this.iconColor, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      // --- THEME UPDATE ---
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1) // Softer border
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 10),
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          
          
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _CheckTile extends StatelessWidget {
  final String title;
  final bool? isAvailable;
  const _CheckTile({required this.title, this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final available = isAvailable ?? false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            available ? Icons.check_circle : Icons.cancel,
            // --- THEME UPDATE: Use grey for 'no' ---
            color: available ? Colors.green : Colors.grey.shade400,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
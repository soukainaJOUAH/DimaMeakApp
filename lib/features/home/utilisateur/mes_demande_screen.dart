import 'package:flutter/material.dart';

class MesDemandesScreen extends StatelessWidget {
  const MesDemandesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1BA9B5);
    const accent = Color(0xFF0E7C7B);
    const deepBlue = Color(0xFF0A3D91);

    final current = <_DemandeItem>[
      _DemandeItem(
        title: 'Accompagnement medical',
        date: '12 Fev 2026 · 09:30',
        status: 'En cours',
        statusColor: const Color(0xFF1BA9B5),
        location: 'Casablanca',
      ),
    ];

    final past = <_DemandeItem>[
      _DemandeItem(
        title: 'Transport',
        date: '10 Fev 2026 · 14:10',
        status: 'Terminee',
        statusColor: const Color(0xFF2E8B57),
        location: 'Mohammedia',
      ),
      _DemandeItem(
        title: 'Aide administrative',
        date: '02 Fev 2026 · 11:00',
        status: 'Annulee',
        statusColor: const Color(0xFFE53935),
        location: 'Rabat',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [deepBlue, accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.description, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mes demandes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Suivez l\'etat de vos demandes',
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionHeader(title: 'Demande en cours'),
            if (current.isEmpty)
              _EmptyCard(
                icon: Icons.hourglass_empty,
                message: 'Aucune demande en cours',
                accent: primary,
              )
            else
              _DemandeCard(item: current.first),
            const SizedBox(height: 16),
            _SectionHeader(title: 'Anciennes demandes'),
            if (past.isEmpty)
              _EmptyCard(
                icon: Icons.history,
                message: 'Aucune demande precedente',
                accent: primary,
              )
            else
              Column(
                children: [
                  for (final item in past) ...[
                    _DemandeCard(item: item),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}

class _DemandeItem {
  final String title;
  final String date;
  final String status;
  final Color statusColor;
  final String location;

  const _DemandeItem({
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.location,
  });
}

class _DemandeCard extends StatelessWidget {
  final _DemandeItem item;

  const _DemandeCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: item.statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.assignment_outlined, color: item.statusColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 14, color: Colors.black45),
                    const SizedBox(width: 4),
                    Text(item.date, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.place, size: 14, color: Colors.black45),
                    const SizedBox(width: 4),
                    Text(item.location, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: item.statusColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item.status,
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color accent;

  const _EmptyCard({
    required this.icon,
    required this.message,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

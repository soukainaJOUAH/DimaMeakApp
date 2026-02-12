import 'package:flutter/material.dart';
import '../services/notifications_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _showUnreadOnly = false;

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1BA9B5);
    const accent = Color(0xFF0E7C7B);
    const deepBlue = Color(0xFF0A3D91);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: NotificationsService.instance,
          builder: (context, _) {
            final items = NotificationsService.instance.items;
            final filtered = _showUnreadOnly
                ? items.where((item) => !item.isRead).toList()
                : items;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
                          child: const Icon(Icons.notifications, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${NotificationsService.instance.unreadCount} non lues',
                                style: const TextStyle(fontSize: 12, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: _markAllRead,
                          style: TextButton.styleFrom(foregroundColor: Colors.white),
                          child: const Text('Tout marquer'),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          label: const Text('Tout'),
                          selected: !_showUnreadOnly,
                          selectedColor: primary.withOpacity(0.18),
                          onSelected: (_) => setState(() => _showUnreadOnly = false),
                        ),
                        FilterChip(
                          label: const Text('Non lues'),
                          selected: _showUnreadOnly,
                          selectedColor: primary.withOpacity(0.18),
                          onSelected: (_) => setState(() => _showUnreadOnly = true),
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                if (filtered.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                              color: primary.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.notifications_none, color: primary, size: 28),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Aucune notification',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Vous etes a jour pour le moment.',
                            style: TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = filtered[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                          child: _NotificationCard(
                            item: item,
                            onTap: () => _toggleRead(item),
                          ),
                        );
                      },
                      childCount: filtered.length,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _markAllRead() {
    NotificationsService.instance.markAllRead();
  }

  void _toggleRead(NotificationItem item) {
    NotificationsService.instance.toggleRead(item);
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = _typeColors(item.type);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: item.isRead ? Colors.transparent : colors.border,
          ),
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
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: colors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(colors.icon, color: colors.foreground),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                      if (!item.isRead)
                        Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1BA9B5),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.message,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.time,
                    style: const TextStyle(fontSize: 11, color: Colors.black45),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _TypeColors _typeColors(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return const _TypeColors(
          icon: Icons.check_circle,
          background: Color(0xFFE6F6EF),
          foreground: Color(0xFF2E8B57),
          border: Color(0xFFBDE6D3),
        );
      case NotificationType.warning:
        return const _TypeColors(
          icon: Icons.warning_amber_rounded,
          background: Color(0xFFFFF1D6),
          foreground: Color(0xFFB26A00),
          border: Color(0xFFFFE1A1),
        );
      case NotificationType.action:
        return const _TypeColors(
          icon: Icons.flash_on,
          background: Color(0xFFE7F1FF),
          foreground: Color(0xFF2B6DEB),
          border: Color(0xFFCFE0FF),
        );
      case NotificationType.info:
      default:
        return const _TypeColors(
          icon: Icons.info_outline,
          background: Color(0xFFE4F7F6),
          foreground: Color(0xFF1BA9B5),
          border: Color(0xFFBEE8E6),
        );
    }
  }
}

class _TypeColors {
  final IconData icon;
  final Color background;
  final Color foreground;
  final Color border;

  const _TypeColors({
    required this.icon,
    required this.background,
    required this.foreground,
    required this.border,
  });
}

import 'package:flutter/material.dart';
import '../../../core/services/sos_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _voiceReading = false;
  bool _locationSharing = true;
  bool _largeText = false;
  String _language = 'Francais';
  String _themeMode = 'Mode lumiere';
  bool _sosEnabled = false;

  @override
  void initState() {
    super.initState();
    _sosEnabled = SosService.instance.enabled.value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF1BA9B5);
    const accent = Color(0xFF0E7C7B);
    const deepBlue = Color(0xFF0A3D91);
    const mint = Color(0xFFE6F6EF);
    const mintIcon = Color(0xFF2E8B57);
    const lavender = Color(0xFFF3E9FF);
    const lavenderIcon = Color(0xFF7B5FD6);
    const teal = Color(0xFFE4F7F6);
    const tealIcon = Color(0xFF1BA9B5);
    const sky = Color(0xFFE7F1FF);
    const skyIcon = Color(0xFF2B6DEB);
    const amberBg = Color(0xFFFFF1D6);
    const amberIcon = Color(0xFFB26A00);
    const coralBg = Color(0xFFFFE7E7);
    const coralIcon = Color(0xFFE53935);
    const dangerCard = Color(0xFFFFF0F0);
    const slateBg = Color(0xFFF1F3F8);
    const slateIcon = Color(0xFF0A3D91);

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
                    child: const Icon(Icons.settings, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Paramètres',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Gérez vos préférences et votre sécurité',
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const _SectionHeader(title: 'Compte'),
            _SectionCard(
              children: [
                _SettingsTile(
                  icon: Icons.person_outline,
                  title: 'Informations personnelles',
                  subtitle: 'Nom, email, téléphone',
                  iconBackground: mint,
                  iconColor: mintIcon,
                  onTap: _openPersonalInfo,
                ),
                const _DividerLine(),
                _SettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Mot de passe',
                  subtitle: 'Modifier votre mot de passe',
                  iconBackground: amberBg,
                  iconColor: amberIcon,
                  onTap: _openPassword,
                ),
                const _DividerLine(),
                _SettingsTile(
                  icon: Icons.location_on_outlined,
                  title: 'Adresse',
                  subtitle: 'Ville et adresse',
                  iconBackground: teal,
                  iconColor: tealIcon,
                  onTap: _openAddress,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _SectionHeader(title: 'Preferences'),
            _SectionCard(
              children: [
                _PreferenceTile(
                  icon: Icons.translate,
                  title: 'Langue',
                  value: _language,
                  iconBackground: sky,
                  iconColor: skyIcon,
                  onTap: _showLanguagePicker,
                ),
                const _DividerLine(),
                _PreferenceTile(
                  icon: Icons.brightness_6_outlined,
                  title: 'Theme',
                  value: _themeMode,
                  iconBackground: amberBg,
                  iconColor: amberIcon,
                  onTap: _showThemePicker,
                ),
                const _DividerLine(),
                _SwitchTile(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  iconBackground: sky,
                  iconColor: skyIcon,
                  value: _notifications,
                  onChanged: (value) => setState(() => _notifications = value),
                ),
                const _DividerLine(),
                _SwitchTile(
                  icon: Icons.volume_up_outlined,
                  title: 'Lecture vocale',
                  iconBackground: lavender,
                  iconColor: lavenderIcon,
                  value: _voiceReading,
                  onChanged: (value) => setState(() => _voiceReading = value),
                ),
                const _DividerLine(),
                _SwitchTile(
                  icon: Icons.location_searching,
                  title: 'Partage de localisation',
                  iconBackground: teal,
                  iconColor: tealIcon,
                  value: _locationSharing,
                  onChanged: (value) => setState(() => _locationSharing = value),
                ),
                const _DividerLine(),
                _SwitchTile(
                  icon: Icons.text_fields,
                  title: 'Texte agrandi',
                  iconBackground: slateBg,
                  iconColor: slateIcon,
                  value: _largeText,
                  onChanged: (value) => setState(() => _largeText = value),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _SectionHeader(title: 'Urgence'),
            _SectionCard(
              children: [
                _SwitchTile(
                  icon: Icons.warning_amber_rounded,
                  title: 'Bouton SOS',
                  iconBackground: coralBg,
                  iconColor: coralIcon,
                  value: _sosEnabled,
                  onChanged: (value) {
                    setState(() => _sosEnabled = value);
                    SosService.instance.setEnabled(value);
                  },
                ),
                const _DividerLine(),
                _SettingsTile(
                  icon: Icons.edit_outlined,
                  title: 'Modifier numero d\'urgence',
                  subtitle: 'Dans les informations personnelles',
                  iconBackground: coralBg,
                  iconColor: coralIcon,
                  onTap: _openPersonalInfo,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _SectionHeader(title: 'Assistance'),
            _SectionCard(
              children: [
                _SettingsTile(
                  icon: Icons.help_outline,
                  title: 'Aide et support',
                  subtitle: 'FAQ et support',
                  iconBackground: teal,
                  iconColor: tealIcon,
                  onTap: _openHelpSupport,
                ),
                const _DividerLine(),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Confidentialite',
                  subtitle: 'Politique et securite',
                  iconBackground: lavender,
                  iconColor: lavenderIcon,
                  onTap: _openPrivacy,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _SectionHeader(title: 'Session'),
            _SectionCard(
              children: [
                _SettingsTile(
                  icon: Icons.logout,
                  title: 'Se deconnecter',
                  subtitle: 'Quitter la session actuelle',
                  iconBackground: coralBg,
                  iconColor: coralIcon,
                  onTap: _confirmLogout,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Text(
                  'Dima Meak v0.1',
                  style: TextStyle(color: primary.withOpacity(0.85), fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                const Text(
                  'TOUJOURS AVEC VOUS',
                  style: TextStyle(fontSize: 10, letterSpacing: 1.4, color: Colors.black38),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openPersonalInfo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const _PersonalInfoScreen()),
    );
  }

  void _openPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const _PasswordScreen()),
    );
  }

  void _openAddress() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const _AddressScreen()),
    );
  }

  void _openHelpSupport() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const _HelpSupportScreen()),
    );
  }

  void _openPrivacy() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const _PrivacyScreen()),
    );
  }

  void _confirmLogout() {
    _showActionDialog(
      context: context,
      icon: Icons.logout,
      iconBackground: const Color(0xFFFFE7E7),
      iconColor: const Color(0xFFE53935),
      title: 'Deconnexion',
      message: 'Voulez-vous vraiment vous deconnecter ?\nVous pourrez vous reconnecter plus tard.',
      primaryLabel: 'Se deconnecter',
      primaryColor: const Color(0xFFE53935),
      onPrimary: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deconnexion effectuee.')),
        );
      },
    );
  }


  void _showActionDialog({
    required BuildContext context,
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
    required String title,
    required String message,
    required String primaryLabel,
    required Color primaryColor,
    required VoidCallback onPrimary,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: iconColor),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black.withOpacity(0.08)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Annuler'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onPrimary();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(primaryLabel, style: const TextStyle(color: Colors.white)),
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

  void _showPicker({
    required String title,
    required String currentValue,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFF4F6FB),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black.withOpacity(0.06)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      for (final option in options) ...[
                        InkWell(
                          onTap: () {
                            onSelected(option);
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(option, style: const TextStyle(fontSize: 14)),
                                ),
                                if (option == currentValue)
                                  const Icon(Icons.check, color: Color(0xFF1BA9B5)),
                              ],
                            ),
                          ),
                        ),
                        if (option != options.last) const _DividerLine(),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.black.withOpacity(0.06)),
                    ),
                    child: const Text('Annuler', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLanguagePicker() {
    final options = [
      const _LanguageOption(
        label: 'العربية',
        value: 'Arabe',
        badgeText: 'AR',
        badgeColor: Color(0xFFFFE7E7),
        badgeTextColor: Color(0xFFE53935),
      ),
      const _LanguageOption(
        label: 'English',
        value: 'Anglais',
        badgeText: 'EN',
        badgeColor: Color(0xFFE7F1FF),
        badgeTextColor: Color(0xFF2B6DEB),
      ),
      const _LanguageOption(
        label: 'Francais',
        value: 'Francais',
        badgeText: 'FR',
        badgeColor: Color(0xFFF3E9FF),
        badgeTextColor: Color(0xFF7B5FD6),
      ),
    ];

    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choisir la langue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                for (final option in options) ...[
                  _LanguageRow(
                    option: option,
                    selected: _language == option.value,
                    onTap: () {
                      setState(() => _language = option.value);
                      Navigator.of(context).pop();
                    },
                  ),
                  if (option != options.last) const _DividerLine(),
                ],
                const SizedBox(height: 6),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showThemePicker() {
    final options = [
      const _LanguageOption(
        label: 'Mode lumiere',
        value: 'Mode lumiere',
        badgeText: 'L',
        badgeColor: Color(0xFFFFF1D6),
        badgeTextColor: Color(0xFFB26A00),
      ),
      const _LanguageOption(
        label: 'Mode sombre',
        value: 'Mode sombre',
        badgeText: 'D',
        badgeColor: Color(0xFFE7E9F1),
        badgeTextColor: Color(0xFF3A4358),
      ),
      const _LanguageOption(
        label: 'Systeme',
        value: 'Systeme',
        badgeText: 'S',
        badgeColor: Color(0xFFE4F7F6),
        badgeTextColor: Color(0xFF1BA9B5),
      ),
    ];

    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choisir le theme',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                for (final option in options) ...[
                  _LanguageRow(
                    option: option,
                    selected: _themeMode == option.value,
                    onTap: () {
                      setState(() => _themeMode = option.value);
                      Navigator.of(context).pop();
                    },
                  ),
                  if (option != options.last) const _DividerLine(),
                ],
                const SizedBox(height: 6),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LanguageOption {
  final String label;
  final String value;
  final String badgeText;
  final Color badgeColor;
  final Color badgeTextColor;

  const _LanguageOption({
    required this.label,
    required this.value,
    required this.badgeText,
    required this.badgeColor,
    required this.badgeTextColor,
  });
}

class _LanguageRow extends StatelessWidget {
  final _LanguageOption option;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageRow({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: option.badgeColor,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                option.badgeText,
                style: TextStyle(
                  color: option.badgeTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            if (selected)
              Container(
                height: 22,
                width: 22,
                decoration: const BoxDecoration(
                  color: Color(0xFF1BA9B5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
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
      padding: const EdgeInsets.only(left: 6, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black45),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;

  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Column(children: children),
    );
  }
}

class _DangerCard extends StatelessWidget {
  final List<Widget> children;
  final Color backgroundColor;
  final Color borderColor;

  const _DangerCard({
    required this.children,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color iconBackground;
  final Color iconColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.iconBackground = const Color(0xFFF1F3F8),
    this.iconColor = const Color(0xFF0A3D91),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle ?? '-', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color iconBackground;
  final Color iconColor;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.iconBackground = const Color(0xFFF1F3F8),
    this.iconColor = const Color(0xFF0A3D91),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1BA9B5),
          ),
        ],
      ),
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback? onTap;
  final Color iconBackground;
  final Color iconColor;

  const _PreferenceTile({
    required this.icon,
    required this.title,
    this.value,
    this.onTap,
    this.iconBackground = const Color(0xFFF1F3F8),
    this.iconColor = const Color(0xFF0A3D91),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            ),
            Text(value ?? '-', style: const TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: Colors.black45, size: 18),
          ],
        ),
      ),
    );
  }
}

class _DangerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconBackground;
  final Color iconColor;
  final Color titleColor;

  const _DangerTile({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.iconBackground,
    required this.iconColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: titleColor),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}

class _PersonalInfoScreen extends StatefulWidget {
  const _PersonalInfoScreen();

  @override
  State<_PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<_PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Nom');
  final _emailController = TextEditingController(text: 'email@exemple.com');
  final _phoneController = TextEditingController(text: '+212 6 00 00 00 00');
  final _emergencyController = TextEditingController(
    text: SosService.instance.phoneNumber.value,
  );

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _emergencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Informations personnelles',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _InputField(label: 'Nom complet', controller: _nameController),
            const SizedBox(height: 12),
            _InputField(label: 'Email', controller: _emailController, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 12),
            _InputField(label: 'Telephone', controller: _phoneController, keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            _InputField(
              label: 'Numero d\'urgence',
              controller: _emergencyController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _PrimaryButton(
              label: 'Enregistrer',
              onTap: () {
                if (!_formKey.currentState!.validate()) return;
                SosService.instance.setPhoneNumber(_emergencyController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Informations mises a jour.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordScreen extends StatefulWidget {
  const _PasswordScreen();

  @override
  State<_PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<_PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Mot de passe',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _InputField(label: 'Mot de passe actuel', controller: _currentController, obscureText: true),
            const SizedBox(height: 12),
            _InputField(label: 'Nouveau mot de passe', controller: _newController, obscureText: true),
            const SizedBox(height: 12),
            _InputField(label: 'Confirmer le nouveau mot de passe', controller: _confirmController, obscureText: true),
            const SizedBox(height: 16),
            _PrimaryButton(
              label: 'Mettre a jour',
              onTap: () {
                if (!_formKey.currentState!.validate()) return;
                if (_newController.text != _confirmController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Les mots de passe ne correspondent pas.')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mot de passe mis a jour.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressScreen extends StatefulWidget {
  const _AddressScreen();

  @override
  State<_AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<_AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController(text: 'Casablanca');
  final _addressController = TextEditingController(text: 'Quartier, Rue 12');

  @override
  void dispose() {
    _cityController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Adresse',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _InputField(label: 'Ville', controller: _cityController),
            const SizedBox(height: 12),
            _InputField(label: 'Adresse', controller: _addressController, maxLines: 2),
            const SizedBox(height: 16),
            _PrimaryButton(
              label: 'Enregistrer',
              onTap: () {
                if (!_formKey.currentState!.validate()) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Adresse mise a jour.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpSupportScreen extends StatelessWidget {
  const _HelpSupportScreen();

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Aide et support',
      child: Column(
        children: [
          _InfoCard(
            title: 'Questions frequentes',
            content:
                'Consultez les questions frequentes pour obtenir des reponses rapides sur l\'application.',
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'Contactez-nous',
            content:
                'Email: support@dima-m3ak.com\nTelephone: +212 5 00 00 00 00',
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'Horaires',
            content: 'Lun - Ven: 09:00 - 18:00\nSam: 10:00 - 14:00',
          ),
        ],
      ),
    );
  }
}

class _PrivacyScreen extends StatelessWidget {
  const _PrivacyScreen();

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: 'Confidentialite',
      child: Column(
        children: [
          _InfoCard(
            title: '1. Types de donnees que nous collectons',
            content:
                'L\'application peut collecter des donnees personnelles telles que le nom, l\'adresse e-mail, le numero de telephone (si fourni), et/ou les informations (beneficiaire ou accompagnant) et les informations de profil necessaires au fonctionnement de l\'application.',
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: '2. Utilisation de vos donnees personnelles',
            content:
                'Nous utilisons ces informations pour vous fournir nos services, ameliorer l\'application, et garantir une experience utilisateur optimale.',
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: '3. Securite des donnees',
            content:
                'Les mesures de securite techniques et organisationnelles sont mises en place pour proteger vos donnees personnelles, notamment l\'authentification securisee et le stockage protege des informations.',
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: '4. Droits des utilisateurs',
            content:
                'Chaque utilisateur dispose d\'un droit d\'acces, de modification et de suppression de ses donnees personnelles, ainsi que du droit de se retirer son consentement a l\'utilisation des donnees.',
          ),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 12, color: Colors.black.withOpacity(0.06));
  }
}

class _SettingsScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingsScaffold({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF0E7C7B);
    const deepBlue = Color(0xFF0A3D91);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(title, style: const TextStyle(color: Colors.black87)),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView(
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
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.tune, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final int maxLines;

  const _InputField({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          validator: (value) => (value == null || value.trim().isEmpty) ? 'Champ requis' : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF4F6FB),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF1BA9B5), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF0A3D91), Color(0xFF0E7C7B)]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const _InfoCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(content, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}

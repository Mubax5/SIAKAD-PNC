import 'package:flutter/material.dart';
import '../helper/warna_aplikasi.dart';

/// Reusable menu button widget for the SIAKAD dashboard grid.
class TombolMenu extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color warnaTint;
  final Color warnaIcon;
  final VoidCallback? onTap;

  const TombolMenu({
    super.key,
    required this.icon,
    required this.label,
    required this.warnaTint,
    required this.warnaIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: warnaTint,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: warnaIcon, size: 28),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: WarnaAplikasi.teksUtama,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../app/theme.dart';

class GlowButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool secondary;
  const GlowButton({super.key, required this.label, this.icon, this.onPressed, this.secondary = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
        style: FilledButton.styleFrom(
          backgroundColor: secondary ? MercDealTheme.card : MercDealTheme.green,
          foregroundColor: secondary ? Colors.white : const Color(0xFF04120B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
          side: secondary ? BorderSide(color: Colors.white.withValues(alpha: .08)) : BorderSide.none,
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  const SectionHeader({super.key, required this.title, this.action, this.onAction});
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900))),
          if (action != null) TextButton(onPressed: onAction, child: Text(action!, style: const TextStyle(color: MercDealTheme.green, fontWeight: FontWeight.w800))),
        ],
      );
}

class DealCard extends StatelessWidget {
  final String title;
  final String price;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final bool featured;
  final bool following;
  const DealCard({super.key, required this.title, required this.price, required this.subtitle, required this.icon, this.onTap, this.featured = false, this.following = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 190,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MercDealTheme.card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: featured ? MercDealTheme.green.withValues(alpha: .35) : Colors.white.withValues(alpha: .06)),
          boxShadow: featured ? [BoxShadow(color: MercDealTheme.green.withValues(alpha: .07), blurRadius: 24)] : null,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(children: [
            Container(height: 128, decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF132A3D), Color(0xFF0A1522)])), child: Center(child: Icon(icon, size: 55, color: MercDealTheme.green))),
            Positioned(top: 8, right: 8, child: Container(width: 34, height: 34, decoration: BoxDecoration(color: Colors.black.withValues(alpha: .45), shape: BoxShape.circle), child: Icon(following ? Icons.favorite : Icons.favorite_border, size: 18, color: following ? MercDealTheme.green : Colors.white70))),
            if (featured) Positioned(left: 8, top: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: MercDealTheme.green, borderRadius: BorderRadius.circular(9)), child: const Text('VETRINA', style: TextStyle(color: Color(0xFF03110A), fontSize: 10, fontWeight: FontWeight.w900)))),
          ]),
          const SizedBox(height: 11),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(price, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 3),
          Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: MercDealTheme.green, fontSize: 12, fontWeight: FontWeight.w700)),
        ]),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const EmptyState({super.key, required this.icon, required this.title, required this.text});
  @override
  Widget build(BuildContext context) => Center(child: Padding(padding: const EdgeInsets.all(30), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 58, color: MercDealTheme.green), const SizedBox(height: 14), Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)), const SizedBox(height: 7), Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white54, height: 1.4))])));
}

import 'package:flutter/material.dart';
import '../../app/theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final bool glow;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.glow = false,
  });

  @override
  Widget build(BuildContext c) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: MercDealTheme.card,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: glow
                    ? MercDealTheme.green.withValues(alpha: .45)
                    : Colors.white10,
              ),
              boxShadow: glow
                  ? [
                      BoxShadow(
                        color: MercDealTheme.green.withValues(alpha: .09),
                        blurRadius: 30,
                      )
                    ]
                  : null,
            ),
            child: child,
          ),
        ),
      );
}

class GlowButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool secondary;

  const GlowButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.secondary = false,
  });

  @override
  Widget build(BuildContext c) => SizedBox(
        height: 52,
        width: double.infinity,
        child: secondary
            ? OutlinedButton.icon(
                onPressed: onPressed,
                icon: icon == null
                    ? const SizedBox.shrink()
                    : Icon(icon),
                label: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(
                    color: MercDealTheme.green.withValues(alpha: .45),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
              )
            : FilledButton.icon(
                onPressed: onPressed,
                icon: icon == null
                    ? const SizedBox.shrink()
                    : Icon(icon),
                label: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: MercDealTheme.green,
                  foregroundColor: const Color(0xFF02120A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  elevation: 8,
                  shadowColor: MercDealTheme.green,
                ),
              ),
      );
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext c) => Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          if (action != null)
            TextButton(
              onPressed: onAction,
              child: Text(
                action!,
                style: const TextStyle(
                  color: MercDealTheme.green,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
        ],
      );
}

class PriceBadge extends StatelessWidget {
  final String text;

  const PriceBadge(this.text, {super.key});

  @override
  Widget build(BuildContext c) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: MercDealTheme.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF03130B),
            fontWeight: FontWeight.w900,
            fontSize: 11,
          ),
        ),
      );
}

class ProductThumb extends StatelessWidget {
  final String asset;

  const ProductThumb(this.asset, {super.key});

  @override
  Widget build(BuildContext c) => ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          'assets/images/$asset',
          height: 128,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
}

class DealCard extends StatefulWidget {
  final String title, price, oldPrice, drop, asset, category;
  final VoidCallback? onTap;
  final bool showcase;

  const DealCard({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.drop,
    required this.asset,
    required this.category,
    this.onTap,
    this.showcase = false,
  });

  @override
  State<DealCard> createState() => _DealCardState();
}

class _DealCardState extends State<DealCard> {
  bool following = false;

  @override
  Widget build(BuildContext c) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: 205,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MercDealTheme.card,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: widget.showcase
                    ? MercDealTheme.gold.withValues(alpha: .55)
                    : MercDealTheme.green.withValues(alpha: .18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .22),
                  blurRadius: 18,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ProductThumb(widget.asset),
                    Positioned(
                      left: 8,
                      top: 8,
                      child: PriceBadge(widget.drop),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => following = !following),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            following
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18,
                            color: following
                                ? MercDealTheme.green
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  widget.category,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 4),

                // FIX: the card is only ~185 px wide internally.
                // Flexible/FittedBox prevents long prices from overflowing.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.price,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: MercDealTheme.green,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      fit: FlexFit.loose,
                      child: FittedBox(
                        alignment: Alignment.centerRight,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.oldPrice,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.white38,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.trending_down_rounded,
                      color: MercDealTheme.green,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Flexible(
                      child: Text(
                        'Sta scendendo',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MercDealTheme.green,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

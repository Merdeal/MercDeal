import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/widgets/merc_widgets.dart';
import '../auth/auth_screen.dart';
import '../deal_plus/deal_plus_screen.dart';
import '../how_it_works/how_it_works_screen.dart';
import '../notifications/notifications_screen.dart';
import '../orders/orders_screen.dart';
import '../reviews/reviews_screen.dart';
import '../security/security_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Profilo',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.notifications_none_rounded),
              ),
            ],
          ),
          const GlassCard(
            glow: true,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 31,
                  backgroundColor: MercDealTheme.card2,
                  child: Icon(Icons.person_rounded, size: 34),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Il tuo profilo',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        '🟢 ✓ Venditore verificato',
                        style: TextStyle(
                          color: MercDealTheme.green,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        'Reputazione basata sulle transazioni concluse',
                        style: TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _stat('—', 'Rating'),
              const SizedBox(width: 7),
              _stat('—', 'Affari'),
              const SizedBox(width: 7),
              _stat('—', 'Puntuale'),
            ],
          ),
          const SizedBox(height: 15),
          _tile(
            context,
            Icons.sell_outlined,
            'Le mie vendite',
            'Annunci, aste e ordini',
            const OrdersScreen(),
          ),
          _tile(
            context,
            Icons.shopping_bag_outlined,
            'I miei acquisti',
            'Ordini, spedizioni e ritiri',
            const OrdersScreen(),
          ),
          _tile(
            context,
            Icons.favorite_border,
            'Preferiti e seguiti',
            'Affari monitorati',
            const NotificationsScreen(),
          ),
          _tile(
            context,
            Icons.star_outline_rounded,
            'Recensioni',
            'Feedback e reputazione',
            const ReviewsScreen(),
          ),
          _tile(
            context,
            Icons.diamond_outlined,
            'Deal+',
            '€4,99/mese · €39,99/anno · Vetrina',
            const DealPlusScreen(),
          ),
          _tile(
            context,
            Icons.menu_book_outlined,
            'Come funziona MercDeal',
            'Venditore, acquirente e sicurezza',
            const HowItWorksScreen(),
          ),
          _tile(
            context,
            Icons.security_outlined,
            'Sicurezza',
            'Account, acquisti, vendite e contestazioni',
            const SecurityScreen(),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AuthScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.login_rounded),
              label: const Text('Accedi / Registrati'),
              style: OutlinedButton.styleFrom(
                foregroundColor: MercDealTheme.green,
                side: BorderSide(
                  color: MercDealTheme.green.withValues(alpha: 0.45),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Expanded(
      child: GlassCard(
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget page,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: MercDealTheme.green.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: MercDealTheme.green,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white30,
            ),
          ],
        ),
      ),
    );
  }
}

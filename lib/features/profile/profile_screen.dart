import 'package:flutter/material.dart';

import '../../app/theme.dart';
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
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 32),
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Profilo',
                  style: TextStyle(
                    fontSize: 28,
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
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF12382F),
                  Color(0xFF0A1724),
                ],
              ),
              border: Border.all(
                color: MercDealTheme.green.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 31,
                  backgroundColor: Color(0xFF193246),
                  child: Icon(
                    Icons.person_rounded,
                    size: 34,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
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
                      SizedBox(height: 4),
                      Text(
                        '🟢 ✓ Venditore verificato',
                        style: TextStyle(
                          color: MercDealTheme.green,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Reputazione costruita sulle transazioni concluse',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _stat('—', 'Rating')),
              const SizedBox(width: 8),
              Expanded(child: _stat('—', 'Affari')),
              const SizedBox(width: 8),
              Expanded(child: _stat('—', 'Puntuale')),
            ],
          ),
          const SizedBox(height: 18),
          _tile(
            context,
            Icons.shopping_bag_outlined,
            'I miei ordini',
            'Acquisti, spedizioni e ritiri',
            const OrdersScreen(),
          ),
          _tile(
            context,
            Icons.star_outline_rounded,
            'Le mie recensioni',
            'Feedback e reputazione',
            const ReviewsScreen(),
          ),
          _tile(
            context,
            Icons.diamond_outlined,
            'Deal+',
            'Alert avanzati e Vetrina',
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
            'Verifica, autenticità e MercDeal Report',
            const SecurityScreen(),
          ),
          const SizedBox(height: 10),
          GlowButton(
            label: 'Accedi / Registrati',
            icon: Icons.login_rounded,
            secondary: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AuthScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _stat(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: MercDealTheme.card,
        borderRadius: BorderRadius.circular(18),
      ),
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
    );
  }

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget page,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          margin: const EdgeInsets.only(bottom: 9),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: MercDealTheme.card,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: MercDealTheme.green.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: MercDealTheme.green,
                ),
              ),
              const SizedBox(width: 12),
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
                        fontSize: 11,
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
      ),
    );
  }
}
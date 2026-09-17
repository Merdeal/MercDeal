import 'package:flutter/material.dart';
import 'theme.dart';
import '../features/home/home_screen.dart';
import '../features/search/search_screen.dart';
import '../features/selling/sell_screen.dart';
import '../features/messages/messages_screen.dart';
import '../features/profile/profile_screen.dart';
import 'dart:async';

class MercDealApp extends StatelessWidget {
  const MercDealApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MercDeal',
        theme: MercDealTheme.dark(),
        home: const MercDealSplash(),
      );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  late final List<Widget> pages = const [HomeScreen(), SearchScreen(), SellScreen(), MessagesScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: index, children: pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (v) => setState(() => index = v),
          backgroundColor: const Color(0xFF08131F),
          indicatorColor: MercDealTheme.green.withValues(alpha: .16),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Cerca'),
            NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'Vendi'),
            NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Messaggi'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profilo'),
          ],
        ),
      );
}


class MercDealSplash extends StatefulWidget {
  const MercDealSplash({super.key});
  @override State<MercDealSplash> createState() => _MercDealSplashState();
}

class _MercDealSplashState extends State<MercDealSplash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1200), () {
      if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainShell()));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 92, height: 92, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), gradient: const LinearGradient(colors: [MercDealTheme.green, MercDealTheme.blue]), boxShadow: [BoxShadow(color: MercDealTheme.green, blurRadius: 35, spreadRadius: -18)]), child: const Icon(Icons.local_offer_rounded, size: 48, color: Color(0xFF06110D))),
      const SizedBox(height: 18),
      const Text('MercDeal', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
      const SizedBox(height: 5),
      const Text('Il prezzo scende. L’affare sale.', style: TextStyle(color: Colors.white54)),
    ])),
  );
}

import 'package:flutter/material.dart';

import '../features/auth/onboarding_screen.dart';
import '../features/home/home_screen.dart';
import '../features/messages/messages_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/search/search_screen.dart';
import '../features/selling/sell_screen.dart';
import 'theme.dart';

class MercDealApp extends StatelessWidget {
  const MercDealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MercDeal',
      theme: MercDealTheme.dark(),
      home: OnboardingScreen(
        onContinue: (context) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainShell()),
          );
        },
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  final pages = const [
    HomeScreen(),
    SearchScreen(),
    SellScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: MercDealTheme.navy,
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          child: _MercBottomBar(
            index: index,
            onChanged: (value) => setState(() => index = value),
          ),
        ),
      ),
    );
  }
}

class _MercBottomBar extends StatelessWidget {
  const _MercBottomBar({required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_outlined, Icons.home_rounded, 'Home'),
      (Icons.search_rounded, Icons.search_rounded, 'Cerca'),
      (Icons.add_rounded, Icons.add_rounded, 'Vendi'),
      (Icons.chat_bubble_outline_rounded, Icons.chat_bubble_rounded, 'Messaggi'),
      (Icons.person_outline_rounded, Icons.person_rounded, 'Profilo'),
    ];

    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xF5081722),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: MercDealTheme.blue.withValues(alpha: .42)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .38),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: MercDealTheme.green.withValues(alpha: .07),
            blurRadius: 30,
          ),
        ],
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          final selected = index == i;
          if (i == 2) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      width: selected ? 52 : 48,
                      height: selected ? 52 : 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MercDealTheme.green,
                        boxShadow: [
                          BoxShadow(
                            color: MercDealTheme.green.withValues(alpha: selected ? .42 : .22),
                            blurRadius: selected ? 28 : 20,
                            spreadRadius: selected ? 2 : 0,
                          ),
                        ],
                      ),
                      child: Icon(items[i].$2, color: Colors.black, size: 30),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      items[i].$3,
                      style: const TextStyle(fontSize: 9, color: Colors.white70, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            );
          }
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(i),
              borderRadius: BorderRadius.circular(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedScale(
                    scale: selected ? 1.12 : 1,
                    duration: const Duration(milliseconds: 220),
                    child: Icon(
                      selected ? items[i].$2 : items[i].$1,
                      color: selected ? MercDealTheme.green : Colors.white60,
                      size: 23,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    items[i].$3,
                    style: TextStyle(
                      fontSize: 9,
                      color: selected ? MercDealTheme.green : Colors.white60,
                      fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

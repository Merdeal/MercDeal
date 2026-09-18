import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onContinue});

  final void Function(BuildContext context) onContinue;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _ambientController;
  late final AnimationController _floatController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _ambientController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _goToMain() => widget.onContinue(context);

  void _goToAuth() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AuthScreen()),
    );
  }

  void _next() {
    if (_page == 2) {
      _goToMain();
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MercDealTheme.navy,
      body: AnimatedBuilder(
        animation: Listenable.merge([_ambientController, _floatController]),
        builder: (context, _) {
          return Stack(
            children: [
              _AmbientBackground(progress: _ambientController.value),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
                      child: Row(
                        children: [
                          _MiniBrand(),
                          const Spacer(),
                          if (_page < 2)
                            TextButton(
                              onPressed: _goToMain,
                              child: const Text(
                                'Salta',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (value) => setState(() => _page = value),
                        children: [
                          _DiscoverPage(float: _floatController),
                          _BrandPage(float: _floatController),
                          _AccessPage(onLogin: _goToAuth, onGuest: _goToMain),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
                      child: Row(
                        children: [
                          _PageDots(page: _page),
                          const Spacer(),
                          if (_page < 2)
                            _NextButton(onTap: _next)
                          else
                            const SizedBox(width: 54),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MiniBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,
          height: 34,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: MercDealTheme.surface,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: MercDealTheme.green.withValues(alpha: 0.55),
            ),
            boxShadow: [
              BoxShadow(
                color: MercDealTheme.green.withValues(alpha: 0.18),
                blurRadius: 18,
              ),
            ],
          ),
          child: Image.asset('assets/icon/app_icon.png'),
        ),
        const SizedBox(width: 9),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Merc',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
              ),
              TextSpan(
                text: 'Deal',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: MercDealTheme.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DiscoverPage extends StatelessWidget {
  const _DiscoverPage({required this.float});

  final Animation<double> float;

  @override
  Widget build(BuildContext context) {
    return _PageShell(
      eyebrow: 'IL TUO PROSSIMO AFFARE È QUI',
      title: const Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'TUTTO QUELLO CHE AMI\n'),
            TextSpan(
              text: 'A PREZZI CHE SCENDONO.',
              style: TextStyle(color: MercDealTheme.green),
            ),
          ],
        ),
      ),
      subtitle:
          'Scopri prodotti nuovi e usati, aste al ribasso e offerte che cambiano ogni giorno.',
      child: SizedBox(
        height: 390,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(child: _GlowOrb()),
            _FloatingProduct(
              asset: 'phone.png',
              left: 18,
              top: 26,
              size: 130,
              angle: -0.08,
              animation: float,
            ),
            _FloatingProduct(
              asset: 'console.png',
              right: 12,
              top: 82,
              size: 128,
              angle: 0.08,
              animation: float,
              reverse: true,
            ),
            _FloatingProduct(
              asset: 'sneaker.png',
              left: 28,
              bottom: 26,
              size: 112,
              angle: -0.16,
              animation: float,
              reverse: true,
            ),
            _FloatingProduct(
              asset: 'watch.png',
              right: 30,
              bottom: 12,
              size: 105,
              angle: 0.14,
              animation: float,
            ),
            Positioned(
              left: 90,
              right: 90,
              top: 104,
              child: _CentralDealOrb(
                label: 'PREZZO',
                value: '↓',
                caption: 'sempre più giù',
              ),
            ),
            Positioned(
              left: 108,
              bottom: 5,
              child: _Pill(
                icon: Icons.trending_down_rounded,
                text: 'PREZZI REALI',
                color: MercDealTheme.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandPage extends StatelessWidget {
  const _BrandPage({required this.float});

  final Animation<double> float;

  @override
  Widget build(BuildContext context) {
    return _PageShell(
      eyebrow: 'ENTRA NEL MONDO MERCDEAL',
      title: const Text('IL PREZZO SCENDE.\nL’AFFARE SALE.'),
      subtitle:
          'Un marketplace dinamico dove ogni discesa può diventare il tuo prossimo affare.',
      child: SizedBox(
        height: 405,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(child: _GlowOrb()),
            _FloatingProduct(
              asset: 'earbuds.png',
              left: 5,
              top: 36,
              size: 110,
              angle: -0.12,
              animation: float,
            ),
            _FloatingProduct(
              asset: 'camera.png',
              right: 5,
              top: 38,
              size: 112,
              angle: 0.10,
              animation: float,
              reverse: true,
            ),
            _FloatingProduct(
              asset: 'car.png',
              left: 10,
              bottom: 30,
              size: 118,
              angle: -0.04,
              animation: float,
              reverse: true,
            ),
            _FloatingProduct(
              asset: 'watch.png',
              right: 12,
              bottom: 34,
              size: 98,
              angle: 0.16,
              animation: float,
            ),
            Positioned.fill(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 118,
                      height: 118,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: MercDealTheme.surface.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(34),
                        border: Border.all(
                          color: MercDealTheme.green.withValues(alpha: 0.72),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MercDealTheme.green.withValues(alpha: 0.32),
                            blurRadius: 50,
                            spreadRadius: 4,
                          ),
                          BoxShadow(
                            color: MercDealTheme.blue.withValues(alpha: 0.16),
                            blurRadius: 75,
                          ),
                        ],
                      ),
                      child: Image.asset('assets/icon/app_icon.png'),
                    ),
                    const SizedBox(height: 18),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Merc',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: 'Deal',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w900,
                              color: MercDealTheme.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'IL TUO AFFARE, SEMPRE.',
                      style: TextStyle(
                        color: MercDealTheme.green,
                        letterSpacing: 3.2,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        _FeatureChip(
                          icon: Icons.trending_down_rounded,
                          label: 'Aste al ribasso',
                        ),
                        SizedBox(width: 8),
                        _FeatureChip(
                          icon: Icons.shield_rounded,
                          label: 'Acquisti sicuri',
                        ),
                        SizedBox(width: 8),
                        _FeatureChip(
                          icon: Icons.diamond_rounded,
                          label: 'Deal+',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccessPage extends StatelessWidget {
  const _AccessPage({required this.onLogin, required this.onGuest});

  final VoidCallback onLogin;
  final VoidCallback onGuest;

  @override
  Widget build(BuildContext context) {
    return _PageShell(
      eyebrow: 'PRONTO A SCOPRIRE?',
      title: const Text('PIÙ DI UN\nMARKETPLACE.'),
      subtitle:
          'Accedi per seguire gli affari, oppure entra subito senza registrazione.',
      child: SizedBox(
        height: 420,
        child: Stack(
          children: [
            Positioned.fill(child: _GlowOrb()),
            Positioned(
              top: 5,
              left: 18,
              child: _FloatingProduct(
                asset: 'phone.png',
                size: 86,
                angle: -0.12,
                animation: const AlwaysStoppedAnimation(0.0),
              ),
            ),
            Positioned(
              top: 32,
              right: 20,
              child: _FloatingProduct(
                asset: 'sneaker.png',
                size: 86,
                angle: 0.13,
                animation: const AlwaysStoppedAnimation(0.0),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _AccessButton(
                    label: 'Accedi',
                    icon: Icons.person_rounded,
                    filled: true,
                    onTap: onLogin,
                  ),
                  const SizedBox(height: 10),
                  _AccessButton(
                    label: 'Registrati',
                    icon: Icons.person_add_alt_1_rounded,
                    onTap: onLogin,
                  ),
                  const SizedBox(height: 10),
                  _AccessButton(
                    label: 'Continua senza registrazione',
                    icon: Icons.arrow_forward_rounded,
                    onTap: onGuest,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Continuando accetti i Termini di servizio\ne l’Informativa sulla privacy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageShell extends StatelessWidget {
  const _PageShell({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String eyebrow;
  final Widget title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eyebrow,
                  style: const TextStyle(
                    color: MercDealTheme.green,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.8,
                  ),
                ),
                const SizedBox(height: 9),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30,
                    height: 1.02,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.7,
                  ),
                  child: title,
                ),
                const SizedBox(height: 11),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                child,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AmbientBackground extends StatelessWidget {
  const _AmbientBackground({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final x = math.sin(progress * math.pi * 2) * 0.16;
    final y = math.cos(progress * math.pi * 2) * 0.12;
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(x, y),
            radius: 1.05,
            colors: const [Color(0xFF083A35), Color(0xFF03131D), Color(0xFF01070C)],
            stops: [0.0, 0.48, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -120 + progress * 55,
              right: -90,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MercDealTheme.blue.withValues(alpha: 0.08),
                  boxShadow: [
                    BoxShadow(
                      color: MercDealTheme.blue.withValues(alpha: 0.12),
                      blurRadius: 100,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -140,
              left: -90 + progress * 60,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MercDealTheme.green.withValues(alpha: 0.07),
                  boxShadow: [
                    BoxShadow(
                      color: MercDealTheme.green.withValues(alpha: 0.13),
                      blurRadius: 110,
                      spreadRadius: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 210,
        height: 210,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MercDealTheme.green.withValues(alpha: 0.035),
          boxShadow: [
            BoxShadow(
              color: MercDealTheme.green.withValues(alpha: 0.13),
              blurRadius: 100,
              spreadRadius: 25,
            ),
            BoxShadow(
              color: MercDealTheme.blue.withValues(alpha: 0.08),
              blurRadius: 80,
              spreadRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingProduct extends StatelessWidget {
  const _FloatingProduct({
    required this.asset,
    required this.size,
    required this.angle,
    required this.animation,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.reverse = false,
  });

  final String asset;
  final double size;
  final double angle;
  final Animation<double> animation;
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final dy = (animation.value - 0.5) * (reverse ? -12 : 12);
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Transform.translate(
        offset: Offset(0, dy),
        child: Transform.rotate(
          angle: angle,
          child: Container(
            width: size,
            height: size,
            padding: EdgeInsets.all(size * 0.08),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 0.25),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF142B39), Color(0xFF061018)],
              ),
              border: Border.all(
                color: MercDealTheme.blue.withValues(alpha: 0.24),
              ),
              boxShadow: [
                BoxShadow(
                  color: MercDealTheme.blue.withValues(alpha: 0.12),
                  blurRadius: 28,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: MercDealTheme.green.withValues(alpha: 0.08),
                  blurRadius: 35,
                ),
              ],
            ),
            child: Image.asset('assets/images/$asset', fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}

class _CentralDealOrb extends StatelessWidget {
  const _CentralDealOrb({required this.label, required this.value, required this.caption});

  final String label;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MercDealTheme.surface.withValues(alpha: 0.92),
        border: Border.all(
          color: MercDealTheme.green.withValues(alpha: 0.6),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: MercDealTheme.green.withValues(alpha: 0.18),
            blurRadius: 48,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: MercDealTheme.green,
              fontSize: 65,
              height: 0.95,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            caption,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 82,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 1),
          Icon(icon, color: MercDealTheme.green, size: 19),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 8,
              height: 1.1,
              color: Colors.white70,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Material(
        color: filled ? MercDealTheme.green : Colors.transparent,
        borderRadius: BorderRadius.circular(19),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(19),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: filled ? MercDealTheme.green : Colors.white.withValues(alpha: 0.025),
              border: Border.all(
                color: filled
                    ? MercDealTheme.green
                    : MercDealTheme.blue.withValues(alpha: 0.55),
              ),
              boxShadow: filled
                  ? [
                      BoxShadow(
                        color: MercDealTheme.green.withValues(alpha: 0.25),
                        blurRadius: 24,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: filled ? Colors.black : Colors.white,
                  size: 21,
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    color: filled ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.page});

  final int page;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final active = index == page;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(right: 7),
          width: active ? 26 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? MercDealTheme.green : Colors.white24,
            borderRadius: BorderRadius.circular(10),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: MercDealTheme.green.withValues(alpha: 0.35),
                      blurRadius: 12,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MercDealTheme.green,
          boxShadow: [
            BoxShadow(
              color: MercDealTheme.green.withValues(alpha: 0.32),
              blurRadius: 28,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.black,
          size: 27,
        ),
      ),
    );
  }
}

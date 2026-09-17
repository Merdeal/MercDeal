import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/services/backend_config.dart';
import '../../core/widgets/merc_widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool login = true;
  bool obscure = true;
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 32, 22, 30),
          children: [
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  gradient: const LinearGradient(
                    colors: [MercDealTheme.green, MercDealTheme.blue],
                  ),
                ),
                child: const Icon(
                  Icons.local_offer_rounded,
                  size: 38,
                  color: Color(0xFF06110D),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              login ? 'Bentornato su MercDeal' : 'Crea il tuo account',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 7),
            Text(
              login
                  ? 'Entra e continua a seguire i tuoi affari.'
                  : 'Compra, vendi e scopri nuovi affari.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 28),
            if (!login) ...[
              TextField(
                controller: name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome visualizzato',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 12),
            ],
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail_outline),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: password,
              obscureText: obscure,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => obscure = !obscure),
                  icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            const SizedBox(height: 18),
            GlowButton(
              label: login ? 'Accedi' : 'Crea account',
              icon: login ? Icons.login_rounded : Icons.person_add_alt_1,
              onPressed: () => _submit(context),
            ),
            const SizedBox(height: 15),
            Center(
              child: TextButton(
                onPressed: () => setState(() => login = !login),
                child: Text(
                  login
                      ? 'Non hai un account? Registrati'
                      : 'Hai già un account? Accedi',
                ),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: MercDealTheme.card,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: .06)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.shield_outlined, color: MercDealTheme.green),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      BackendConfig.isConfigured
                          ? 'Accesso protetto tramite il backend MercDeal.'
                          : 'Backend non ancora configurato: questa build usa la modalità anteprima.',
                      style: const TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (email.text.trim().isEmpty || password.text.isEmpty || (!login && name.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compila tutti i campi richiesti.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          BackendConfig.isConfigured
              ? 'Richiesta inviata al backend.'
              : 'Modalità anteprima: collega Supabase per attivare l’accesso reale.',
        ),
      ),
    );
  }
}

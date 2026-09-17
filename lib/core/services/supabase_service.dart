import 'backend_config.dart';

/// Optional Supabase bootstrap. The app remains usable as a UI preview when
/// credentials are not supplied. Production builds should provide both values
/// through Codemagic environment variables.
class SupabaseService {
  const SupabaseService._();

  static bool get isConfigured => BackendConfig.isConfigured;
}

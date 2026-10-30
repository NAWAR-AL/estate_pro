/// إدارة الحساب والصلاحيات (أدمن / مستخدم عادي).
///
/// أي إيميل موجود في [_adminEmails] بيعتبر أدمن، وغير هيك مستخدم عادي.
class RoleManager {
  RoleManager._();

  /// إيميلات الأدمن — ضيف/احذف من هنا.
  static const List<String> _adminEmails = [
    'admin@estatepro.com',
    'admin@gmail.com',
    'nawar@estatepro.com',
  ];

  static String? _email;
  static String? _name;

  /// حفظ جلسة المستخدم بعد تسجيل الدخول أو إنشاء الحساب.
  static void signIn({String? email, String? name}) {
    final normalized = (email ?? '').trim().toLowerCase();
    _email = normalized.isEmpty ? null : normalized;

    final cleanName = (name ?? '').trim();
    _name = cleanName.isEmpty ? null : cleanName;
  }

  static void signOut() {
    _email = null;
    _name = null;
  }

  static String? get email => _email;

  static String get displayName {
    if (_name != null) return _name!;
    if (_email == null) return 'Guest';

    final local = _email!.split('@').first;
    if (local.isEmpty) return 'Guest';

    return local[0].toUpperCase() + local.substring(1);
  }

  static bool get isSignedIn => _email != null;

  static bool get isAdmin {
    if (_email == null) return false;
    return _adminEmails.contains(_email);
  }
}

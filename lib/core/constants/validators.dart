/// Centralized Input Validators for Fankoush application.
/// Tailored for all project forms (Auth, Profile, E-Wallet, and Card Payments).
abstract final class Validators {
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );
  static final RegExp _nameRegExp = RegExp(r'^[a-zA-Z\u0621-\u064A\s]+$');
  static final RegExp _egPhoneRegExp = RegExp(r'^01[0125][0-9]{8}$');
  static final RegExp _cardNumberRegExp = RegExp(r'^[0-9]{16}$');
  static final RegExp _expiryDateRegExp = RegExp(
    r'^(0[1-9]|1[0-2])\/?([0-9]{2})$',
  );
  static final RegExp _cvvRegExp = RegExp(r'^[0-9]{3,4}$');

  static bool _isEmpty(String? val) => val == null || val.trim().isEmpty;

  // --- General Required Field Validator ---
  static String? validateRequired(
    String? val, [
    String fieldName = 'هذا الحقل',
  ]) {
    if (_isEmpty(val)) return 'يرجى إدخال $fieldName';
    return null;
  }

  // --- Name Validator ---
  static String? validateName(String? val) {
    if (_isEmpty(val)) return 'يرجى إدخال الاسم';
    final name = val!.trim();
    if (name.length < 3) return 'الاسم يجب ألا يقل عن 3 أحرف';
    if (!_nameRegExp.hasMatch(name)) return 'الاسم يجب أن يحتوي على أحرف فقط';
    return null;
  }

  // --- Email Validator ---
  static String? validateEmail(String? val) {
    if (_isEmpty(val)) return 'يرجى إدخال البريد الإلكتروني';
    if (!_emailRegExp.hasMatch(val!.trim())) {
      return 'صيغة البريد الإلكتروني غير صحيحة';
    }
    return null;
  }

  // --- Egyptian Phone / E-Wallet Number Validator ---
  static String? validatePhoneNumber(
    String? val, [
    String label = 'رقم الهاتف',
  ]) {
    if (_isEmpty(val)) return 'يرجى إدخال $label';
    final cleanPhone = val!.trim().replaceAll(RegExp(r'\s+'), '');
    if (!_egPhoneRegExp.hasMatch(cleanPhone)) {
      return '$label يجب أن يبدأ بـ 01 ويتكون من 11 رقماً';
    }
    return null;
  }

  // --- Wallet Number Validator (Vodafone / Orange / Etisalat Cash) ---
  static String? validateWalletNumber(String? val) {
    return validatePhoneNumber(val, 'رقم المحفظة');
  }

  // --- Password Validator ---
  static String? validatePassword(String? val) {
    if (_isEmpty(val)) return 'يرجى إدخال كلمة المرور';
    if (val!.length < 6) return 'كلمة المرور يجب ألا تقل عن 6 أحرف أو أرقام';
    return null;
  }

  // --- Confirm Password Validator ---
  static String? validateConfirmPassword(
    String? val,
    String? originalPassword,
  ) {
    if (_isEmpty(val)) return 'يرجى تأكيد كلمة المرور';
    if (val != originalPassword) return 'كلمتا المرور غير متطابقتين';
    return null;
  }

  // --- Card Payment Validators ---
  static String? validateCardNumber(String? val) {
    if (_isEmpty(val)) return 'يرجى إدخال رقم البطاقة';
    final clean = val!.trim().replaceAll(RegExp(r'\s+'), '');
    if (!_cardNumberRegExp.hasMatch(clean)) {
      return 'رقم البطاقة غير صحيح (يجب أن يتكون من 16 رقماً)';
    }
    return null;
  }

  static String? validateExpiryDate(String? val) {
    if (_isEmpty(val)) return 'يرجى إدخال تاريخ الانتهاء';
    final clean = val!.trim();
    if (!_expiryDateRegExp.hasMatch(clean)) {
      return 'صيغة التاريخ غير صحيحة (شهر/سنة مثل 12/28)';
    }
    return null;
  }

  static String? validateCVV(String? val) {
    if (_isEmpty(val)) return 'يرجى إدخال الرمز الأمني';
    final clean = val!.trim();
    if (!_cvvRegExp.hasMatch(clean)) {
      return 'الرمز الأمني يتكون من 3 أو 4 أرقام';
    }
    return null;
  }

  static String? validateCardHolderName(String? val) {
    if (_isEmpty(val)) return 'يرجى إدخال اسم صاحب البطاقة';
    if (val!.trim().length < 3) return 'الاسم قصير جداً';
    return null;
  }
}

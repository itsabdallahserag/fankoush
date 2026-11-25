/// Centralized Arabic strings for Fankoush application.
/// Extracted directly from Figma design text layers.
class AppStrings {
  AppStrings._();

  // --- App Identity ---
  static const String appName = 'فانكوش';
  static const String appSlogan = 'فانكوش 🎬';

  // --- Navigation Tabs ---
  static const String navHome = 'الرئيسية';
  static const String navPlans = 'باقتي';
  static const String navNotifications = 'الإشعارات';
  static const String navProfile = 'حسابي';

  // --- Common Actions & Buttons ---
  static const String continueAction = 'متابعة';
  static const String nextAction = 'التالي';
  static const String startNow = 'يلا نبدأ';
  static const String cancel = 'إلغاء';
  static const String notNow = 'مش دلوقتي';
  static const String allow = 'سماح';
  static const String skip = 'تخطي';
  static const String skipIntro = 'تخطي المقدمة';
  static const String skipForNow = 'تخطي الآن';
  static const String saveChanges = 'حفظ التغييرات';
  static const String tryFree = 'جرّب مجانًا';
  static const String tryFankoushFree = 'جرّب فانكوش مجانًا';
  static const String proceedToPayment = 'متابعة للدفع';
  static const String back = 'الرجوع';
  static const String homePage = 'الصفحة الرئيسية';
  static const String close = 'إغلاق';

  // --- Onboarding ---
  static const String onboardingPrefix1 = 'قول اللي ';
  static const String onboardingHighlight1 = 'في بالك';
  static const String onboardingSubtitle1 =
      'قول أي كلام، وفانكوش هيرد عليك بإفيه جامد!';
  static const String onboardingPrefix2 = 'القفشة الحلوة ';
  static const String onboardingHighlight2 = 'تتشارك';
  static const String onboardingSubtitle2 =
      'اسمع رد فانكوش وشارك تسجيلك و القفشة مع صحابك !';

  // --- Auth (Login & Register) ---
  static const String loginTitle = 'نورت فانكوش تاني! 🎬';
  static const String loginSubtitle = 'سجّل دخولك وكمّل قفشاتك.';
  static const String registerTitle = 'يلا ندخلك جوا القفشات! 🎬';
  static const String registerSubtitle =
      'اعمل حسابك وخلي الضحك يبدأ مع فانكوش.';
  static const String nameLabel = 'الاسم';
  static const String nameHint = 'ادخل اسمك';
  static const String emailLabel = 'البريد الإلكتروني';
  static const String emailHint = 'example@email.com';
  static const String countryLabel = 'الدولة';
  static const String countryHint = 'اختر الدولة';
  static const String passwordLabel = 'كلمة المرور';
  static const String passwordHint = 'ادخل كلمة المرور';
  static const String createPasswordHint = 'أنشئ كلمة مرور';
  static const String confirmPasswordLabel = 'تأكيد كلمة المرور';
  static const String confirmPasswordHint = 'تأكيد كلمة المرور';
  static const String rememberMe = 'تذكرني';
  static const String forgotPassword = 'نسيت كلمة المرور؟';
  static const String loginButton = 'تسجيل الدخول';
  static const String registerButton = 'إنشاء الحساب';
  static const String dontHaveAccount = 'لسه معندكش حساب؟';
  static const String createAccount = 'إنشاء حساب';
  static const String alreadyHaveAccount = 'عندك حساب بالفعل؟';
  static const String loginError = 'حدث خطأ ما أثناء تسجيل الدخول';
  static const String registerError = 'حدث خطأ ما أثناء إنشاء الحساب';

  // --- Home Screen ---
  static const String attempts = 'محاولات';
  static const String defaultAttemptsCount = '3 محاولات';
  static const String homeSpeechBubble =
      'قول أي حاجة... وفانكوش هيرد عليك بإفيه! 😂';
  static const String pressToStartRecording = 'اضغط لبدء التسجيل';
  static const String orUploadAudio = 'أو ارفع مقطع صوتي';

  // --- Mic Permission Dialog ---
  static const String micPermissionTitle = 'عايزين نسمعك';
  static const String micPermissionDesc =
      'التطبيق محتاج إذن استخدام الميكروفون عشان تسجل الإفيه اللي فاكره ونطلعه لك في ثانية.';

  // --- Recording Audio Screen ---
  static const String recordTitle = 'قول اللي في بالك.. سامعينك!';
  static const String recordingInProgress = 'جاري التسجيل...';
  static const String pressToEndRecording = 'اضغط لإنهاء التسجيل';
  static const String maxRecordingDuration = 'الحد الأقصى للتسجيل: ';
  static const String secondsUnit = ' ثانية';

  // --- Review Audio Screen ---
  static const String yourRecording = 'ده تسجيلك!';
  static const String reviewSubtitle = 'اسمعه ولو حابب سجل من جديد';
  static const String reRecord = 'سجل من جديد';
  static const String deleteRecording = 'حذف التسجيل';
  static const String findEfieh = 'يلا نلاقي الإفيه!';

  // --- Finding & Result Screen ---
  static const String fankoshPreparingReply = 'فانكوش بيحضّرك الرد!';
  static const String smartFankosh = 'فانكوش الذكي';
  static const String identifying = 'جارٍ التعرف';
  static const String waitTitle = 'استنى..';
  static const String preparingAwesomeReply = 'بنحضرلك رد جامد ! 🎬';
  static const String searchingForEfieh = 'بندور على الإفيه المناسب..';
  static const String searchingInProgress = 'جارٍ البحث';
  static const String sayAnythingHint = 'قول أي حاجة...';
  static const String caughtEfiehTitle = 'أيوووه! قفشت الإفيه! 😍';
  static const String listenToThisSubtitle = 'استنى بقى… اسمع دي! 😂';
  static const String takeThisEfieh = 'خد الإفيه ده عندك!';
  static const String audioQuality = 'HQ • 320kbps';
  static const String didYouLikeFankoshReply = 'عجبك رد فانكوش؟ 😂';
  static const String shareVoiceAndFankoshReply =
      'شارك كلامك ورد فانكوش مع صحابك!';
  static const String yourVoicePlusFankosh = 'صوتك + رد فانكوش';
  static const String shareEfiehAction = 'شارك القفشة';
  static const String zeroAttempts = '0 محاولات';
  static const String freeEfiehatFinished = 'القفشات ببلاش خلصت!';
  static const String outOfAttemptsSubtitle1 = 'بس لسه عندنا ضحك كتير!';
  static const String outOfAttemptsSubtitle2 = 'اختار باقتك وكمّل مع فانكوش.';
  static const String moreEfiehat = 'قفشات أكثر';
  static const String moreAttempts = 'محاولات أكثر';
  static const String continuousLaughter = 'ضحك مكمّل';
  static const String discoverPlans = 'اكتشف الباقات';

  // --- Attempts Details Sheet ---
  static const String yourAttemptsInFankosh = ' محاولاتك في فانكوش  ⚡';
  static const String remainingFreeAttemptsPrefix = 'فاضلك';
  static const String remainingFreeAttemptsSuffix = 'محاولات مجانية';
  static const String available = 'متاحة';
  static const String used = 'مستخدمة';

  // --- Birthday Screen & Dialog ---
  static const String fankoshWantsBirthdayTitle =
      'فانكوش عايز يعرف عيد ميلادك! 🎂';
  static const String fankoshWantsBirthdaySubtitle =
      'ضيف تاريخ ميلادك عشان نفاجئك بتهنئة مخصوص في يومك!';
  static const String addMyBirthday = 'أضيف تاريخ ميلادي';
  static const String chooseBirthDate = 'اختار تاريخ ميلادك';
  static const String yearHeader = 'السنة';
  static const String monthHeader = 'الشهر';
  static const String dayHeader = 'اليوم';
  static const String saveDate = 'حفظ التاريخ';
  static const String findingEfiehTitle = 'بنفتكرلك إفيه جامد... 🎬';
  static const String findingEfiehSubtitle =
      'ثواني وفانكوش هيرد عليك بأحسن قفشة!';
  static const String efiehResultTitle = 'لقينالك الإفيه! 🎬';
  static const String stopAudio = 'إيقاف الصوت';
  static const String listenMovieAudio = 'اسمع الإفيه بصوت الفيلم';
  static const String shareEfieh = 'مشاركة الإفيه';
  static const String saveToFavorites = 'حفظ في المفضلة';
  static const String recordAnotherEfieh = 'سجل إفيه تاني 🎙️';

  // --- Plans & Subscription ---
  static const String plansTitle = 'اختار باقتك وكمّل القفشات! 🎬';
  static const String plansSubtitle =
      'جرّب فانكوش مجانًا، أو اختار باقتك واستمتع بقفشات أكتر!';
  static const String mostPopular = 'الأكثر اختيارًا';
  static const String bestValue = 'الأوفر';
  static const String egp = 'جنيه';
  static const String attemptUnit = 'محاولة';
  static const String validFor = 'صالحة لمدة';
  static const String dayUnit = 'يوم';
  static const String planLite = 'فانكوش لايت';
  static const String planPlus = 'فانكوش بلس';
  static const String planPro = 'فانكوش برو';
  static const String planLiteFooter = 'بحث أسرع وخيارات أكثر ⚡';
  static const String planPlusFooter = 'بحث أسرع وإفيهات أكتر 😂';
  static const String planProFooter = 'بحث أسرع وإفيهات غير محدودة 🚀';

  // --- Payment Method ---
  static const String paymentMethodTitle = 'طريقة الدفع';
  static const String choosePaymentMethod = 'اختر وسيلة الدفع المناسبة:';
  static const String inclusiveTax = 'شامل الضريبة';
  static const String mobileWallet = 'محفظة إلكترونية (فودافون كاش / إنستاباي)';
  static const String mobileWalletSubtitle = 'دفع فوري برقم المحفظة';
  static const String bankCard = 'بطاقة دفع بنكية (فيزا / ماستركارد / ميزة)';
  static const String bankCardSubtitle = 'دفع آمن بالبطاقة البنكية';
  static const String confirmPayment = 'متابعة الدفع';

  // --- Notifications ---
  static const String markAllAsRead = 'تحديد الكل كمقروء';
}

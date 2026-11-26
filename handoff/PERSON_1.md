# Person 1 — المصادقة

* **الفرع**: `feature/firebase-auth` — يُنشأ يدويًا من رأس `dev` بعد نزول التغيير التحضيري.
* **الأساس**: `62c32ae` قبل التحضيري.
* **الحالة المرئية المرجعية**: `screenshots/04-sign-in-empty.png`، `screenshots/05-sign-in-validation.png`، `screenshots/06-create-account.png`، `screenshots/18-settings-ar.png`.

## قبل البدء

تأكد من نزول التحضيري: `AuthRepo` و`AuthSession` و`AppError` والمفاتيح اللغوية والـ fakes موجودة بتوقيعات نهائية. لا تلمس أي ملف من قائمة «الملفات المحجوزة» في `../design/planning/HANDOFF.md`.

## ملفاتك حصرًا

* `lib/features/auth/data/repos/firebase_auth_repo.dart` — جديد، ينفّذ `AuthRepo`.
* `lib/features/auth/data/repos/google_auth_strategy.dart` — جديد، استراتيجية Google منفصلة عن الجلسة المشتركة.
* `lib/features/login/**` — بما ذلك ملف widget جديد لزر Google.
* `lib/features/sign_up/**`.
* `lib/features/splash/splash_screen.dart`.
* `lib/core/routes/app_routes.dart`.
* `lib/nesba_app.dart`.
* `lib/features/settings/ui/settings_screen.dart` — سطر تسجيل الخروج فقط؛ بطاقة الهدف استُخرجت في التحضيري.
* `test/features/login/**` و`test/features/sign_up/**` و`test/features/splash/**`.

**ممنوع**: `pubspec.yaml`، `pubspec.lock`، `main.dart`، DI، `firebase_options.dart`، `lang/**`، `lib/core/language/**`، `lib/core/firebase/**`، `test/helpers/fakes/**`، ملفات Person 2–4، `settings_screen.dart` إلا لسطر تسجيل الخروج، `goal_card.dart`.

## المهام — كل مهمة commit واحد

1. `inject the auth repository into the auth cubits`
   - استبدل الاعتماد على التنفيذ الوهمي بـ `AuthRepo` من التحضيري.
   - احتفظ بالتحقق الحالي من البريد وطول كلمة المرور كما هو.
   - اختبار: الـ cubit يستقبل الـ repo من المنشئ ولا يستدعي Firebase مباشرة.

2. `map firebase auth errors through the shared error type`
   - `wrong-password` و`user-not-found` → بيانات غير صحيحة.
   - `email-already-in-use` و`weak-password` → نفس الحقل الحالي بمفتاح معتمد.
   - `network-request-failed` و`too-many-requests` و`unverified-email` → قيم `AppError` المعتمدة.
   - لا تعرض نص الاستثناء الخام في الواجهة ولا في الـ log.

3. `show auth failures on sign in and sign up`
   - امسح حالة التحميل، أبقِ النص المكتوب، لا تنتقل إلى الشاشة الرئيسية.
   - أضف مستمع أخطاء لشاشة إنشاء الحساب — لا يوجد حاليًا.
   - استخدم مفاتيح معتمدة فقط؛ لا تضف نصًا جديدًا.

4. `add google sign in as a separate strategy`
   - ملف استراتيجية داخل `lib/features/auth/data/repos/`.
   - زر داخل ملف widget جديد تحت `login/ui/widgets/`.
   - الجلسة المشتركة تملك استدعاء SDK؛ الاستراتيجية تُمرّر فقط.
   - إلغاء اختيار الحساب عودة صامتة لتسجيل الدخول بلا رسالة خطأ.

5. `follow the real session on cold start`
   - Splash ينتظر حالة `unknown` صريحة ثم يختار الرئيسية أو تسجيل الدخول.
   - Onboarding يحتفظ بسلوكه للمرة الأولى ولا يعيد مستخدمًا مسجّلًا إلى_login.
   - التوجيه يعتمد على حالة الجلسة لا على `onboardingDone` وحدها.

6. `add sign out and clear user scoped state`
   - أضف سطر تسجيل الخروج في الإعدادات.
   - أغلق المستمع الحي، امسح الـ overlay وذاكرة الهدف والوجبات وأي عملية بدأت بمعرّف المستخدم القديم.
   - غطِّ حالة تسجيل الخروج دون اتصال بالشبكة.

7. `create the user document once after sign in`
   - استدعِ المساعد idempotent المشترك من التحضيري.
   - لا تكتب حقل الهدف هنا؛ Person 4 يملكه.

8. `cover auth with tests`
   - حالات النجاح والفشل لكل مزوّد، الإلغاء، البدء البارد، تسجيل الخروج ثم الدخول بحساب آخر.
   - لا اختبار يتصل بمشروع Firebase حقيقي.

## بوابة الإنهاء

`flutter analyze` و`flutter test` و`dart format --output=none --set-exit-if-changed .` و`flutter build apk --debug` كلها نظيفة. فحص يدوي على المحاكي يغطي الحالات في الصور أعلاه. لقطة محلية لكل تغيير مرئي داخل `../design/screenshots/<feature>/` باسم رسالة الـ commit. لا push ولا PR ولا دمج.

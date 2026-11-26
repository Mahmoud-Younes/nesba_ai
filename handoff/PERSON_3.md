# Person 3 — المراجعة ومستودع الوجبات

* **الفرع**: `feature/firebase-review-meals` — يُنشأ يدويًا من رأس `dev` بعد التحضيري.
* **الأساس**: `62c32ae` قبل التحضيري.
* **الصور المرجعية**: `screenshots/14-review-day.png`، `screenshots/15-review-week.png`، `screenshots/20-review-day-light.png`، `screenshots/21-review-week-light.png`.

## قبل البدء

يجب أن تكون قد وصلت من التحضيري: واجهة `MealsRepo` المشتركة، `AppError`، مخطط الوجبة، مفتاح اليوم والمنطقة الزمنية، نافذة الأيام السبعة، وحالات الكتابة المحفوظة. أنت تملك التنفيذ لا الواجهة. لا تلمس الملفات المحجوزة في `../design/planning/HANDOFF.md`.

## ملفاتك حصرًا

* `lib/features/review/data/repos/review_repo.dart` — التوقيع النهائي غير المتزامن.
* `lib/features/review/data/repos/firebase_review_repo.dart` — جديد.
* `lib/features/home/data/firebase_meals_repo.dart` — جديد، تنفيذ `MealsRepo` المشترك والمصدر الحي للوجبات.
* `lib/features/review/logic/**` و`lib/features/review/ui/**`.
* `lib/features/home/ui/home_screen.dart` — إزالة إعادة التحميل عند تغيير التبويب، وإزالة استيراد الملف الوهمي الذي يُحذف في التنظيف.
* `test/features/review/**` و`test/features/home/shell_contract_test.dart`.

**ممنوع**: DI، `pubspec`، `main.dart`، اللغات، `lib/core/firebase/**`، `test/helpers/fakes/**`، ملفات Person 1 و2 و4، `settings_screen.dart`، `goal_card.dart`.

## المهام — كل مهمة commit واحد

1. `make review delete and restore asynchronous id operations`
   - معرّف المستند بدل فهرس القائمة.
   - إعادة المحاولة تُعيد الكتابة الحقيقية لا مؤقتًا وهميًا.
   - التراجع يعتمد على بيانات الخادم لا على نسخة قديمة من الصف.

2. `implement the firestore review repository`
   - يقرأ مصدر الوجبات الحي عبر المخطط المشترك.
   - معرّف المستخدم يُحل من الجلسة في كل عملية.

3. `derive the seven day view from real meal data`
   - دالة تجميع واحدة لليوم والأسبوع باستخدام مفتاح اليوم والمنطقة الزمنية المثبّتين.
   - نافذة الأيام السبعة تشمل اليوم حسب قرار التحضيري.

4. `derive sync badges from persisted write state`
   - مصدر واحد للحالة: `pending` و`ok` و`failed`.
   - الحالة تصمد بعد إعادة التشغيل؛ إعادة المحاولة تُعيد الإرسال.

5. `remove tab arrival reloads from the home shell`
   - التحميل الأول بعد الدخول يأتي من المصدر الحي.
   - لا إعادة قراءة عند كل تغيير تبويب.

6. `show write failure states in review`
   - رفض الصلاحية وعدم توفر الخدمة وفشل إعادة المحاولة تُعرض بنصوص معتمدة.
   - حدّث اختبار الـ shell لمصدر واحد بكاتبين متزامنين.

7. `update review tests against the shared fakes`
   - الحذف، التراجع، إعادة المحاولة، كاتبان متزامنان، مستخدم بلا وجبات.
   - لا اتصال بمشروع حقيقي.

## بوابة الإنهاء

الأوامر الأربعة المشتركة نظيفة. فحص يدوي: حفظ من سجل الوجبات، ظهوره في اليوم والأسبوع، حذف، تراجع، فشل إعادة محاولة، دخول بحساب آخر، وحالة صفر وجبات. لقطة محلية لكل حالة مرئية داخل `../design/screenshots/<feature>/` باسم الـ commit. لا push ولا PR ولا دمج.

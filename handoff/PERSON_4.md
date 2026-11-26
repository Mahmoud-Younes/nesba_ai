# Person 4 — الاقتراحات وهدف اليوم

* **الفرع**: `feature/firebase-swaps-goal` — يُنشأ يدويًا من رأس `dev` بعد التحضيري.
* **الأساس**: `62c32ae` قبل التحضيري.
* **الصور المرجعية**: `screenshots/16-swaps.png`، `screenshots/22-swaps-light.png`، `screenshots/17-settings-en.png`، `screenshots/18-settings-ar.png`.

## قبل البدء

يجب أن تكون قد وصلت من التحضيري: `GoalRepo` و`MealsRepo` و`AppError` والمفاتيح اللغوية והـ fakes، واستُخرجت بطاقة الهدف إلى `lib/features/settings/ui/widgets/goal_card.dart`. الأزواج الثلاثة معتمدة كمحتوى ثابت من مالك المحتوى. لا تلمس الملفات المحجوزة في `../design/planning/HANDOFF.md`.

## ملفاتك حصرًا

* `lib/features/swaps/data/repos/swap_repo.dart`.
* `lib/features/swaps/data/repos/curated_swap_repo.dart` — جديد، الاسم المحايد بدل الاسم الوهمي.
* `lib/features/swaps/logic/swap_cubit.dart` و`lib/features/swaps/ui/**`.
* `lib/features/settings/ui/widgets/goal_card.dart` — تملكه بعد استخراجه في التحضيري.
* `lib/features/settings/data/repos/firebase_goal_repo.dart` — جديد، ينفّذ `GoalRepo`.
* `test/features/swaps/**` و`test/features/settings/goal_card_test.dart`.

**ممنوع**: `settings_screen.dart`، DI، `pubspec`، `main.dart`، اللغات، `lib/core/firebase/**`، `test/helpers/fakes/**`، ملفات Persons 1–3.

## المهام — كل مهمة commit واحد

1. `replace the mock swap source with curated content`
   - الأزواج الثلاثة المعتمدة من قائمة المحتوى، بلا تأخير وهمي.
   - لا استدعاء Gemini إضافي ولا مجموعة Firestore جديدة.

2. `implement swap apply through the meals interface`
   - حقول الوجبة الناتجة من قرار التحضيري.
   - كل الكتابة عبر `MealsRepo`؛ لا استدعاء Firestore مباشرة.

3. `show swap write failures with approved copy`
   - `AppError` إلى مفتاح معتمد، مسح التحميل، إبقاء البطاقة ظاهرة.

4. `move the daily goal behind the goal repository`
   - Firestore هو المصدر؛ التفضيل المحلي cache بمفتاح المستخدم ويُمسح عند تسجيل الخروج.
   - البطاقة لا تستدعي Firebase مباشرة.

5. `read the goal in log and review through one source`
   - عبر واجهة `GoalRepo` المشتركة فقط؛ لا تعديل ملفات Person 2 أو 3.

6. `update swaps and goal tests against the shared fakes`
   - نجاح وفشل التبديل، قراءة الهدف قبل أول snapshot، وعدم تسريب هدف مستخدم سابق.

## بوابة الإنهاء

الأوامر الأربعة المشتركة نظيفة. فحص يدوي: قائمة الاقتراحات، تبديل ناجح، تبديل فائض بالحصة، تحديد هدف، إعادة تشغيل بنفس الهدف، ثم دخول بحساب آخر دون تسريب. لقطة محلية لكل حالة مرئية داخل `../design/screenshots/<feature>/` باسم الـ commit. لا push ولا PR ولا دمج.

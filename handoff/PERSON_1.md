# الشخص 1 — المصادقة والبروفايل

* **الفرع**: `feature/firebase-auth`.
* **الأساس**: `b6ee41f` وهو رأس `dev` بعد نزول العمل التحضيري.

## بوابتان قبل التوزيع

1. **تم**: فحص كل `.set(` على `users/{uid}`. وُجد موضع واحد في `lib/core/firebase/user_document.dart:16` محمي بـ `if (snapshot.exists) return`، وسيُضاف له `SetOptions(merge: true)` في العمل التحضيري.
2. **لم تتم بعد**: يقرأ شخص واحد من الفريق، خارج الأربعة، النصوص الجديدة العربية اليوم. لا تُوزَّع الملفات قبل قراءته.

## مالك العمل التحضيري والجدول

* **المالك**: الشخص الأول — صاحب `الشخص 1`، وله صلاحية تعديل كامل المشروع. ينفّذ العمل التحضيري قبل الأفرع الأربعة.
* **قاعدة Firebase**: إذا احتاج تعديلًا في حساب Firebase أو فتحه أو الكونسول، يرجع إلى مالك الحساب `Mahmoud-Younes`؛ لا يغيّره منفردًا.
* **الموعد**: نهاية مساء السبت 28 نوفمبر 2026 لنزول العمل التحضيري على `dev`.
* الفروع تُنشأ من رأس `dev` الحالي `b6ee41f`.
* **إن لم ينزل بحلول مساء السبت**: يُؤخذ القرار فورًا بالعودة إلى الخطة البديلة: حساب السعرات والهدف، واختيار الموانع، وتنبيه عند تسجيل وجبة فيها مانع. وتُؤجَّل الاقتراحات الموجّهة بالبروفايل. لا يُؤجَّل القرار إلى ما بعد الموعد.

## العمل التحضيري — ينفّذه مالك تحضيري واحد خارج الأربعة

ينزل قبل الأفرع الأربعة. سلّم بالاسم:

* `UserProfile` وقارئ للقراءة فقط `ProfileRepository.read()` و`watch()`.
* `goal_state.dart` — دالة واحدة تُرجع حالة الهدف: `unset` أو `calculated` أو `manual`. تستخدمها أنت والشخص 4 بدل تكرار القاعدة.
* `goal_cache_key.dart` — دالة واحدة تبني مفتاح كاش الهدف المرتبط بـ uid. تستخدمها أنت عند الخروج والشخص 4 عند القراءة، بلا استيراد من فرع آخر.
* `meal_alternatives.dart` — حقل `alternatives` في نموذج الوجبة يحتفظ بالبدائل الثلاثة خامًا مع `contains` لكل بديل. `contains` مطلوب والمصفوفة الفارغة صالحة.
* `swap_constraints_contract.dart` — التوقيع النهائي الذي ينادي منه الشخص 4 دون انتظار فرع الشخص 2.
* `goal_writer.dart` — دالة تكتب `dailyGoalKcal` و`source` داخل `runTransaction`. أنت والشخص 4 تستدعيانها، ولا أحد يكتب الحقل مباشرة.
* مفاتيح النص بالعربية والإنجليزية، وتسجيل DI، والاختبارات المزدوجة، وقواعد Firestore.

## ما تحتاج معرفته

نِسْبَة تطبيق Flutter/Android لتقدير وجبات الطعام، عربي أولًا وRTL. الحلقة: يصف المستخدم وجبة، يُحلّل الذكاء الاصطناعي السعرات والمكونات، يصحّح المستخدم النتيجة، تُحفظ الوجبة، ثم تظهر في «راجع». الأرقام تقديرية والمستخدم هو من يصحّحها. لا وعظ ولا ادعاءات طبية ولا نص يوحي بضمان خلوّ الطعام من مسببات الحساسية. ثلاثة تبويبات: «سجّل» و«راجع» و«اقتراحات».

قيود ثابتة: Firebase على Spark فقط بلا Blaze، ومفتاح Gemini ليس داخل التطبيق ولا في المستودع. التحقق من البريد برابط Firebase. لكل ملف صاحب واحد، ولا رفع ولا طلب دمج ولا دمج.

### القرارات التي تخصّك

* **أول استخدام** هو أول مرة يفتح فيها المستخدم تبويب «سجّل» بعد الدخول بلا بروفايل وبلا علامة `profileSkipped` مرتبطة بـ uid. أنت تبني نافذة البروفايل، والشخص 2 يفتحها من شاشة «سجّل». التخطي يكتب العلامة المرتبطة بـ uid، فلا تظهر النافذة مرة أخرى.
* البروفايل اختياري وقابل للتعديل من الإعدادات، وليس جزءًا من onboarding.
* حقل هدف واحد nullable باسم `dailyGoalKcal` مع `source: calculated | manual`. الغياب أو الصفر أو غياب `source` حالة `unset` يمكن كتابتها. اليدوي الصريح لا يُستبدل، ولا إعادة حساب تلقائية.
* كل كتابة على الحقل تتم عبر `goal_writer.dart` في العمل التحضيري داخل transaction، لا قراءة ثم كتابة عندك.
* Mifflin-St Jeor بالكجم والسم والسنوات، معاملات 1.2 / 1.375 / 1.55 / 1.725، الخسارة −15% من TDEE، زيادة العضل +10%، الثبات بلا تعديل، والحد الأدنى 1200 للإناث و1500 للذكور.
* **يُعطَّل خيار الخسارة فقط** لمن هو تحت 18 أو BMI أقل من 18.5. الثبات وزيادة العضل متاحان، لأن صاحب BMI منخفض قد يريد زيادة العضل. حدود الإدخال: الوزن 20–300 كجم، الطول 100–250 سم، العمر 13–100 سنة.
* زر «أعد حساب هدفي» في شاشة البروفايل عندك فقط، ويظهر لـ `calculated` فقط. بطاقة الهدف عند الشخص 4 تعرض التقدير والمصدر بلا زر.
* قائمتان منفصلتان: «حساسية أو مانع صحي» من الفئات التسع تُفلتر، و«لا أفضّله» نص حر يُرسل مع التحليل ويُعرض بأنه غير مفحوص.
* الأرقام العربية-الهندية واللاتينية مقبولة في الوزن والطول وتُطبَّع عند الإدخال.
* `ensureUserDoc` في العمل التحضيري يزيل بذرة الصفر ويضيف `SetOptions(merge: true)`؛ أنت تستدعي المساعد فقط.

### النصوص التي تحتاجها

| العربية | English |
|---|---|
| الوزن (كجم) · الطول (سم) · العمر (سنوات) | Weight (kg) · Height (cm) · Age (years) |
| الجنس: أنثى / ذكر | Sex: Female / Male |
| خامل / خفيف / متوسط / عالٍ | Sedentary / Light / Moderate / High |
| خسارة الدهون / زيادة العضل / الثبات | Fat loss / Muscle gain / Maintenance |
| احسب هدفي · تخطِّ الآن · تعديل البروفايل · حفظ | Calculate for me · Skip for now · Edit profile · Save |
| هدفك اليومي · تقدير يمكنك تعديله | Your daily goal · An estimate you can edit |
| محسوب / يدوي | calculated / manual |
| أعد حساب هدفي | Recalculate my goal |
| حساسية أو مانع صحي · لا أفضّله · غير مفحوص | Allergy or health restriction · I prefer not to have it · Not checked |
| جلوتين / ألبان / بيض / مكسرات / فول سوداني / سمسم / سمك / قشريات / صويا | Gluten / Dairy / Eggs / Tree nuts / Peanuts / Sesame / Fish / Shellfish / Soy |
| الخسارة غير متاحة لمن هو تحت 18 أو BMI أقل من 18.5 | Fat loss is not available under 18 or below a BMI of 18.5 |
| تعديل القيود | Edit restrictions |

لا تضف نصًا جديدًا؛ المفاتيح تُضاف في العمل التحضيري باللغتين، ولا تلمس ملفات اللغات.

## الملفات المحجوزة على الأشخاص 2 و3 و4

أنت وحدك تملك صلاحية تعديل أي ملف لتنفيذ العمل التحضيري. بعد نزوله تعمل في فرعك، ولا تلمس ملفات الأشخاص 2 و3 و4 إلا بقرار صريح من مالك الحساب.

`pubspec.yaml` و`pubspec.lock` و`lib/main.dart` و`lib/core/di/injection_container.dart` و`lib/firebase_options.dart` وكل ما تحت `lib/core/firebase/**` و`lang/**` و`lib/core/language/**` و`test/helpers/fakes/**`، وكل ملفات الأشخاص 2 و3 و4.

## ملفاتك حصرًا

* `lib/features/auth/data/repos/firebase_auth_repo.dart` — جديد، ينفّذ `AuthRepo`.
* `lib/features/auth/data/repos/google_auth_strategy.dart` — جديد.
* `lib/features/login/**` و`lib/features/sign_up/**` و`lib/features/splash/splash_screen.dart`.
* `lib/features/onboarding/data/calorie_calculator.dart` — جديد، يملك المعادلة والمعاملات والحدود.
* `lib/features/onboarding/data/firebase_profile_writer.dart` — جديد، يملك كتابات البروفايل عدا حقل الهدف.
* `lib/features/onboarding/logic/**` و`lib/features/onboarding/widgets/**` — جديد، بما فيها نافذة البروفايل.
* `lib/features/settings/ui/settings_screen.dart` — سطرا تسجيل الخروج و«تعديل البروفايل» فقط.
* `lib/core/routes/app_routes.dart` — مسار نافذة البروفايل التي يفتحها الشخص 2.
* `test/features/login/**` و`test/features/sign_up/**` و`test/features/splash/**` و`test/features/onboarding/**`.

## المهام — كل مهمة التزام واحد

1. `inject the auth repository into the auth cubits`
   - الـ cubit يستقبل `AuthRepo` من المنشئ ولا يستدعي Firebase مباشرة.
2. `map firebase auth errors through the shared error type`
   - كل أكواد Firebase إلى `AppError`، بلا نص استثناء خام.
3. `show auth failures on sign in and sign up`
   - امسح التحميل، أبقِ النص المكتوب، لا تنتقل للرئيسية عند الفشل.
4. `add google sign in as a separate strategy`
   - الجلسة المشتركة تملك SDK؛ إلغاء اختيار الحساب عودة صامتة.
5. `follow the real session on cold start`
   - Splash ينتظر `unknown` ثم يختار الرئيسية أو الدخول. لا توجيه حسب البروفايل.
6. `add sign out and clear user scoped state`
   - امسح مفتاح كاش الهدف عبر الدالة المشتركة في العمل التحضيري، ولا تمس اللغة أو الإعدادات العامة.
7. `create the user document once after sign in`
   - استدعِ `ensureUserDoc`، ولا تكتب الهدف هنا.
8. `add the calorie calculator`
   - دالة نقية تُرجع `GoalValue`، وتطبّق المعادلة والمعاملات والتعديلات والحدود وحدود الإدخال، وتُعطّل الخسارة فقط تحت 18 أو BMI أقل من 18.5.
9. `add the profile prompt and screen`
   - نافذة تُفتح من «سجّل» عند أول استخدام، اختيارية، قابلة للتعديل من الإعدادات، بقائمتين منفصلتين وتطبيع الأرقام. التخطي يكتب علامة `profileSkipped` المرتبطة بـ uid عبر مسارك.
10. `write the profile through the shared contracts`
    - اكتب البروفايل عبر المساعدات المشتركة، واستخدم `goal_writer.dart` لحقل الهدف. لا قراءة ثم كتابة عندك. انقل `daily_goal_kcal` القديم مرة بـ `source: manual` ثم احذفه.
11. `show the recalculate button`
    - يظهر في شاشة البروفايل لـ `calculated` فقط، ويستدعي الحاسبة ثم الكاتب المشترك.
12. `cover auth and profile with tests`
    - نجاح وفشل كل مزوّد، الإلغاء، البدء البارد، حساب آخر، المعادلة، BMI، تحت 18، الأرقام العربية، حدود الإدخال، يدوي مقابل محسوب، وبقاء اليدوي بعد تعديل الوزن. لا اختبار يتصل بـ Firebase.

## بوابة الإنهاء

`flutter analyze` و`flutter test` و`dart format --output=none --set-exit-if-changed .` و`flutter build apk --debug` نظيفة. فحص يدوي على المحاكي، ولقطة شاشة لكل تغيير مرئي باسم رسالة الـ التزام. لا رفع ولا طلب دمج ولا دمج.

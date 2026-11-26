# Person 2 — التحليل وسجل الوجبات

* **الفرع**: `feature/firebase-log-ai` — يُنشأ يدويًا من رأس `dev` بعد التحضيري.
* **الأساس**: `62c32ae` قبل التحضيري.
* **الصور المرجعية**: `screenshots/07-log-idle.png` إلى `screenshots/13-log-return.png`.

## قبل البدء

يجب أن تكون قد وصلت من التحضيري: `MealsRepo` و`AppError` ومخطط الوجبة وجدول الأخطاء إلى النصوص ومفتاح اليوم والمنطقة الزمنية وحجز الحصة قبل استدعاء Gemini. لا تلمس الملفات المحجوزة في `../design/planning/HANDOFF.md`.

## ملفاتك حصرًا

* `lib/features/log/data/repos/log_repo.dart` — أبقِ واجهة الـ cubit كما هي.
* `lib/features/log/data/repos/firebase_log_repo.dart` — جديد.
* `lib/features/log/data/ai/gemini_meal_analyzer.dart` — جديد، يملك ثابت اسم النموذج والـ prompt.
* `lib/features/log/data/models/ai_analysis_dto.dart` — جديد، مخطط الاستجابة والتحويل إلى النموذج الحالي.
* `lib/features/log/logic/**` و`lib/features/log/ui/**`.
* `test/features/log/**`.

تستخدم `MealsRepo` عبر الواجهة المشتركة فقط؛ التنفيذ عند Person 3 ويُربط في commit الدمج النهائي. **ممنوع**: DI، `pubspec`، `main.dart`، اللغات، `lib/core/firebase/**`، `test/helpers/fakes/**`، ملفات الأشخاص 1 و3 و4.

## المهام — كل مهمة commit واحد

1. `implement the firestore log repository`
   - قراءة وجبات اليوم عبر المخطط المشترك.
   - حل معرّف المستخدم من الجلسة لكل عملية لا عند الإنشاء.
   - توليد معرّف الوجبة قبل الكتابة؛ نفس المعرّف يُستخدم للحفظ والتراجع.

2. `add the gemini meal analyzer`
   - prompt واحد يتضمن لغة التطبيق المختارة لا لغة الجهاز.
   - طلب إخراج JSON منظم بالحقول والأنواع المثبّتة في التحضيري.
   - رفض القيم الخاطئة القابلة للتحليل مثل السعرات السالبة ونوع وجبة غير معروف.
   - تحويل الاستجابة إلى نموذج النتيجة الحالي دون تعديل الواجهة المرئية.

3. `map analysis failures to the shared error type`
   - الحصة، المهلة، الشبكة، الاستجابة المشوهة، وغير المعروف.
   - لا يظهر نص الاستثناء الخام للمستخدم.

4. `keep the log cubit error safe`
   - غلّف كل استدعاء للمستودع.
   - امسح `isSaving` وعلامة العملية الجارية في كل مسار including الفشل.
   - احتفظ بتوقيتات التحميل والـ timeout والتراجع الحالية كما في `states-hardening.md`.

5. `keep the draft after a failed analysis`
   - الفشل يُبقي النص المكتوب في الذاكرة في هذه المرحلة.
   - حفظ المسودة بعد إعادة التشغيل خارج النطاق وموثق كفجوة.

6. `show the existing analysis error states`
   - بطاقة الحصة وبطاقة المهلة والخطأ العام بنصوص معتمدة فقط.
   - لا مفاتيح لغوية جديدة من هذا الفرع.

7. `update log tests against the shared fakes`
   - نجاح، حصة، مهلة، استجابة مشوهة، فشل حفظ، تراجع.
   - لا اختبار يتصل بخدمة حقيقية.

## بوابة الإنهاء

الأوامر الأربعة المشتركة نظيفة. فحص يدوي: كتابة وجبة، تحليل ناجح، فشل حصة، مهلة، حفظ، تراجع، ثم إعادة تشغيل للتأكد من بقاء الوجبة. لقطة محلية لكل حالة مرئية داخل `../design/screenshots/<feature>/` باسم الـ commit. لا push ولا PR ولا دمج.

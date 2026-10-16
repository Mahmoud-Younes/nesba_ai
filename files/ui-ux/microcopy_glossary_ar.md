# Arabic Glossary & Microcopy (Proposed)

> **Status: PROPOSED — needs review by a native Arabic speaker on the team** (and ideally one nutrition-literate reviewer).
> Date: 2026-10-15
> Why this file exists: competitors showed machine-translated and inconsistent Arabic ("وحدات الماكرو", "مغذيات كبيرة", mixed spellings). One reviewed glossary avoids that.

## 1. Writing principles

- Short, clear, Modern Standard Arabic in simple words (MSA-lite). Colloquial Egyptian only if the team decides on a casual voice for the AI chat.
- **Prefer gender-neutral phrasing** (nouns and "يمكنك…") instead of masculine/feminine imperatives.
- Never shame. Describe the number, then offer the next step.
- One idea per message; one action per empty state.
- Same term for the same thing everywhere (see glossary).
- Latin digits (0-9). Units: جم, مل, سعرة.

## 2. Glossary

| English | Use (Arabic) | Avoid | Notes |
|---|---|---|---|
| Calories | السعرات الحرارية | ك كالوري | Short form / unit: سعرة |
| Remaining | المتبقي | — | Main hero label |
| Daily goal | هدف اليوم | — | |
| Consumed / eaten | المستهلك | — | |
| Burned | المحروق | حرق (as a noun label) | |
| Net | الصافي | — | |
| Macronutrients | المغذيات الكبرى | وحدات الماكرو، مغذيات كبيرة | Machine-translations seen in a competitor |
| Micronutrients | المغذيات الدقيقة | — | |
| Protein | البروتين | — | |
| Carbohydrates | الكربوهيدرات | — | |
| Fat | الدهون | — | |
| Fiber | الألياف | — | |
| Sugar | السكر | — | |
| Sodium | الصوديوم | — | |
| Breakfast | الفطور | — | Colloquial option: الفطار (team decision) |
| Lunch | الغداء | — | |
| Dinner | العشاء | — | |
| Snack | وجبة خفيفة | — | |
| Water | الماء | — | |
| Weight | الوزن | — | |
| Steps | الخطوات | — | |
| Streak | أيام متتالية | — | |
| Today | اليوم | — | Tab label |
| Recipes | الوصفات | — | Tab label |
| Progress | التقدّم | — | Tab label |
| Account | حسابي | — | Tab label |
| Log a meal | تسجيل وجبة | — | Central action |
| Describe the meal | وصف الوجبة | imperative forms | Neutral noun form |
| Serving / portion | حصة | — | |
| Gram / milliliter | جم / مل | غ | |
| Estimate | تقدير | — | |
| Confidence | درجة الثقة | — | Levels: عالية / متوسطة / منخفضة |
| Recommended | موصى به | — | |
| Reports | التقارير | — | |
| Daily energy need (TDEE) | احتياجك اليومي من السعرات | — | Info text can mention "TDEE" |
| Save / Edit / Delete / Cancel / Retry | حفظ / تعديل / حذف / إلغاء / إعادة المحاولة | — | |

## 3. Microcopy samples (draft)

| Situation | Text |
|---|---|
| Log input placeholder | وصف الوجبة… مثال: طبق كشري كبير مع سلطة |
| Today, empty | لا توجد وجبات مسجّلة اليوم. يمكنك البدء من زر التسجيل. |
| Result sheet title | تقدير الوجبة |
| Result sheet hint | يمكنك مراجعة الكميات وتعديلها قبل الحفظ. |
| Low-confidence item | تقدير هذه الحصة غير مؤكد. هل الكمية صحيحة؟ |
| Over goal | تجاوزت هدف اليوم بحوالي {n} سعرة. الاستمرارية أهم من يوم واحد. |
| AI error | تعذّر تحليل الوصف الآن. حفظنا النص، ويمكنك إعادة المحاولة. |
| Offline | لا يوجد اتصال. تم حفظ الوصف وسيتم تحليله عند عودة الاتصال. |
| Estimates disclaimer | القيم تقديرية ولا تغني عن استشارة مختص تغذية. |
| Reports, empty | ستظهر الرسوم بعد تسجيل أول وجبة. |
| Target explanation | هدفك = احتياجك اليومي من السعرات حسب نشاطك، مع تعديل بسيط لتحقيق هدفك. |

## 4. To decide with the team

- MSA-lite vs light Egyptian dialect (global, or only in AI chat).
- الفطور vs الفطار.
- Whether to show kcal or سعرة in compact UI (space).
- Who reviews Arabic text before each release.

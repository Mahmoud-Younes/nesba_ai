import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/widgets/feedback/error_card.dart';
import 'package:nesba_ai/core/widgets/feedback/skeleton_card.dart';
import 'package:nesba_ai/core/widgets/nes_app_bar.dart';
import 'package:nesba_ai/features/swaps/logic/swap_cubit.dart';
import 'package:nesba_ai/features/swaps/ui/widgets/meal_context_banner.dart';
import 'package:nesba_ai/features/swaps/ui/widgets/swap_pair_card.dart';
import 'package:nesba_ai/features/swaps/ui/widgets/swaps_empties.dart';

/// S08 «اقتراحات» frame (screen-specs §2.8): source-declaring section
/// header + side-by-side pair cards, failure keeps the previous cache.
/// [mealContextDescription] turns it into the S09 meal-context variant
/// (banner + hidden general section, verdict-triggered deep-link).
class SwapsScreen extends StatelessWidget {
  const SwapsScreen({this.mealContextDescription, super.key});

  final String? mealContextDescription;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SwapCubit>()..load(),
      child: BlocBuilder<SwapCubit, SwapState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: NesAppBar(title: context.translate(LangKeys.swapsTitle)),
            body: SafeArea(child: _body(context, state)),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, SwapState state) {
    if (state.isLoading) {
      return _skeleton(context);
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mealContextDescription != null)
            // S09: context banner above the list; the general section
            // header hides while the meal-specific pairs show (§2.9).
            _fadeIn(
              context,
              400,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: MealContextBanner(
                  mealDescription: mealContextDescription!,
                  onBackToMeal: () {
                    // TODO(log): back to the log gate with the live
                    // result card (G-10) — lands with shell wiring (21).
                  },
                ),
              ),
            ),
          if (state.errorMsg != null) ...<Widget>[
            SizedBox(height: 12.h),
            _fadeIn(context, 400, _errorCard(context)),
          ],
          if (state.swaps.isEmpty)
            SwapsEmpties(
              // TODO(log): CTA routes to the log gate (ticket 21).
              onCta: () {},
            )
          else if (mealContextDescription == null)
            ..._cardsSection(context, state)
          else
            ..._mealContextPairs(context, state),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // Skips the entrance animation when the OS asks for reduced motion.
  Widget _fadeIn(BuildContext context, int duration, Widget child) =>
      MediaQuery.disableAnimationsOf(context)
      ? child
      : CustomFadeInUp(duration: duration, child: child);

  // First read only (states §1.5 loading): two pair-card footprints.
  Widget _skeleton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: <Widget>[
          const SkeletonCard(),
          SizedBox(height: 12.h),
          const SkeletonCard(),
        ],
      ),
    );
  }

  // Every failure renders the server card; the previous swaps stay
  // visible below it (§2.8: المخبأ السابق يبقى ظاهرًا).
  Widget _errorCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ErrorCard(
        icon: Icons.error_outline,
        title: context.translate(LangKeys.errServerTitle),
        body: context.translate(LangKeys.errServerBody),
        actions: <(String, VoidCallback)>[
          (
            // err_server_actions is the combined «retry / cancel» label —
            // the split retry text borrows err_offline_action until the
            // deck splits the key (log_screen precedent).
            context.translate(LangKeys.errOfflineAction),
            () => context.read<SwapCubit>().load(),
          ),
        ],
      ),
    );
  }

  // TODO(filter-chips): the «وصفات بديلة»/«بدائل سناكس» sections run as
  // two top filter chips, not sub-tabs (§2.8 IA decision) — no live keys
  // in the deck yet and solid copy is not allowed, so the chip row lands
  // when those keys exist.

  // «من وجباتك الأخيرة» (declares the suggestions source) + one pair card
  // per row, staggered in.
  List<Widget> _cardsSection(BuildContext context, SwapState state) {
    return <Widget>[
      SizedBox(height: 12.h),
      _fadeIn(
        context,
        400,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextApp(
            text: context.translate(LangKeys.swapsSectionHeader),
            theme: context.textStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.semiBold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
      SizedBox(height: 16.h),
      ..._pairCards(context, state),
    ];
  }

  // The pair cards themselves — shared by the general section (S08) and
  // the meal-context variant (S09, no section header).
  List<Widget> _pairCards(BuildContext context, SwapState state) {
    return <Widget>[
      for (int i = 0; i < state.swaps.length; i++)
        _fadeIn(
          context,
          400 + 100 * i,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: SwapPairCard(
                pair: state.swaps[i],
                isBookmarked: state.bookmarked.contains(i),
                onSwap: () => context.read<SwapCubit>().applySwap(i),
                onBookmark: () => context.read<SwapCubit>().toggleBookmark(i),
              ),
            ),
          ),
        ),
    ];
  }

  // S09 pairs — no «من وجباتك الأخيرة» header while the banner shows.
  List<Widget> _mealContextPairs(BuildContext context, SwapState state) {
    return <Widget>[
      SizedBox(height: 16.h),
      ..._pairCards(context, state),
    ];
  }
}

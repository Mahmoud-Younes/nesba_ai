import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nesba_ai/core/common/animations/animate_do.dart';
import 'package:nesba_ai/core/di/injection_container.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';
import 'package:nesba_ai/core/routes/app_routes.dart';
import 'package:nesba_ai/core/widgets/feedback/error_card.dart';
import 'package:nesba_ai/core/widgets/nes_screen_body.dart';
import 'package:nesba_ai/core/widgets/nes_section_card.dart';
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
/// TODO(s09-contract): spec §2.9 loads a mealId via deep-link with
/// meal-specific pairs — the description-string simplification and the
/// deleted-meal fallback (silent return + neutral snackbar) land with the
/// verdict wiring (ticket 20 follow-up).
class SwapsScreen extends StatelessWidget {
  const SwapsScreen({this.mealContextDescription, this.onGoToLog, super.key});

  final String? mealContextDescription;

  /// Shell-injected jump to the log gate (banner + empties CTA).
  final VoidCallback? onGoToLog;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SwapCubit>()..load(),
      child: BlocBuilder<SwapCubit, SwapState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: NesAppBar(
              onSettingsTap: () => context.pushName(AppRoutes.settings),
              title: context.translate(LangKeys.swapsTitle),
            ),
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
    return NesScreenBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (mealContextDescription != null) ...<Widget>[
            // S09: context banner above the list; the general section
            // header hides while the meal-specific pairs show (§2.9).
            _fadeIn(
              context,
              400,
              MealContextBanner(
                mealDescription: mealContextDescription!,
                // Back to the log gate — the meal stays live in the
                // IndexedStack (G-10).
                onBackToMeal: () => onGoToLog?.call(),
              ),
            ),
            verticalSpace(AppSpacing.s16),
          ],
          if (state.errorMsg != null) ...<Widget>[
            _fadeIn(context, 400, _errorCard(context)),
            verticalSpace(AppSpacing.s16),
          ],
          if (state.swaps.isEmpty)
            SwapsEmpties(
              // The empties CTA jumps to the log gate.
              onCta: onGoToLog,
            )
          else ...<Widget>[
            if (mealContextDescription == null) ...<Widget>[
              _fadeIn(
                context,
                400,
                NesSectionHeading(
                  text: context.translate(LangKeys.swapsSectionHeader),
                ),
              ),
              verticalSpace(AppSpacing.s8),
            ],
            ..._pairCards(context, state),
          ],
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
    return NesScreenBody(
      child: Column(
        children: <Widget>[
          const SkeletonCard(),
          verticalSpace(AppSpacing.s12),
          const SkeletonCard(),
        ],
      ),
    );
  }

  // Every failure renders the server card; the previous swaps stay
  // visible below it (§2.8: المخبأ السابق يبقى ظاهرًا).
  Widget _errorCard(BuildContext context) {
    return ErrorCard(
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
    );
  }

  // TODO(filter-chips): the «وصفات بديلة»/«بدائل سناكس» sections run as
  // two top filter chips, not sub-tabs (§2.8 IA decision) — no live keys
  // in the deck yet and solid copy is not allowed, so the chip row lands
  // when those keys exist.

  // The pair cards themselves — shared by the general section (S08) and
  // the meal-context variant (S09, which hides the section header).
  List<Widget> _pairCards(BuildContext context, SwapState state) {
    return <Widget>[
      for (int i = 0; i < state.swaps.length; i++) ...<Widget>[
        if (i > 0) verticalSpace(AppSpacing.s12),
        _fadeIn(
          context,
          400 + 100 * i,
          SwapPairCard(
            pair: state.swaps[i],
            isBookmarked: state.bookmarked.contains(
              state.swaps[i]['id'] as String? ?? 'pair-$i',
            ),
            onSwap: () => context.read<SwapCubit>().applySwap(i),
            onBookmark: () => context.read<SwapCubit>().toggleBookmark(
              state.swaps[i]['id'] as String? ?? 'pair-$i',
            ),
          ),
        ),
      ],
    ];
  }
}

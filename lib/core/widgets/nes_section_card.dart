import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/common/widgets/text_app.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/helpers/spacing.dart';
import 'package:nesba_ai/core/style/fonts/app_type_scale.dart';
import 'package:nesba_ai/core/style/fonts/font_weight_helper.dart';
import 'package:nesba_ai/core/style/theme/app_radius.dart';

/// The card every block of content sits in: `surfaceContainer` tint,
/// corner 12, 16dp inner padding (Bustan §1.4, tint-first — elevation 0,
/// depth comes from the surface ladder, never a shadow).
///
/// [title] renders a section heading *above* the card, matching the
/// "Nutrition snapshot" pattern; leave it off for a bare card.
class NesSectionCard extends StatelessWidget {
  const NesSectionCard({
    required this.child,
    this.title,
    this.padding,
    this.color,
    super.key,
  });

  final Widget child;

  /// Heading drawn above the card, not inside it.
  final String? title;

  final EdgeInsetsGeometry? padding;

  /// Defaults to `surfaceContainer`. Pass `surfaceContainerLow` for a card
  /// nested inside another card, so the two stay distinguishable.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    // Material, not a decorated Container: ListTile, InkWell and Switch
    // paint their ink on the nearest Material ancestor, so a coloured box
    // between them and it hides every ripple inside the card — Flutter
    // asserts on exactly that. It is also how the reference builds cards.
    final Widget card = Material(
      color: color ?? scheme.surfaceContainer,
      borderRadius: BorderRadius.circular(AppRadius.medium.r),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: padding ?? EdgeInsets.all(AppSpacing.cardInner.w),
        child: SizedBox(width: double.infinity, child: child),
      ),
    );

    if (title == null) return card;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        NesSectionHeading(text: title!),
        verticalSpace(AppSpacing.s8),
        card,
      ],
    );
  }
}

/// The heading that sits above a card — or above a run of cards, where
/// one [NesSectionCard] cannot carry it.
class NesSectionHeading extends StatelessWidget {
  const NesSectionHeading({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextApp(
      text: text,
      theme: context.textStyle.copyWith(
        fontSize: AppTypeScale.titleLarge.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

/// Label above a control inside a card ("Meal Description", "Your craving").
///
/// Pairs with [NesSectionCard]: the card is the group, this names the field
/// within it without borrowing the section heading's weight.
class NesFieldLabel extends StatelessWidget {
  const NesFieldLabel({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextApp(
      text: text,
      theme: context.textStyle.copyWith(
        fontSize: AppTypeScale.titleMedium.sp,
        fontWeight: FontWeightHelper.semiBold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

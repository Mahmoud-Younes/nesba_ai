import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/features/page_two/logic/page_two_cubit.dart';

/// One circle per palette color; the selected one grows
/// and gets a check icon.
class ColorPaletteRow extends StatelessWidget {
  const ColorPaletteRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageTwoCubit, PageTwoState>(
      builder: (context, state) {
        final cubit = context.read<PageTwoCubit>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            PageTwoCubit.palette.length,
            (index) {
              final isSelected = cubit.selectedColorIndex == index;
              return GestureDetector(
                onTap: () {
                  cubit.changeColor(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  height: (isSelected ? 56 : 44).r,
                  width: (isSelected ? 56 : 44).r,
                  decoration: BoxDecoration(
                    color: PageTwoCubit.palette[index],
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(
                            color: context.color.textColor!,
                            width: 3,
                          )
                        : null,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                        )
                      : null,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

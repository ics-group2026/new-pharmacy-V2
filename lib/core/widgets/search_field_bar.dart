import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_translations.dart';

/// Search bar shared by the Home app bar (display-only) and the Search
/// screen (editable) so a [Hero] wrapping either instance animates between
/// the exact same shape, styling and position.
class SearchFieldBar extends StatelessWidget {
  const SearchFieldBar({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.interactive = true,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  /// False renders the bar as a static, tappable placeholder (Home) rather
  /// than an editable field (Search).
  final bool interactive;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: interactive ? null : onTap,
        borderRadius: BorderRadius.circular(28.r),
        child: Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 20.r,
                color: colorScheme.onSurface.withValues(alpha: 0.45),
              ),
              10.horizontalSpace,
              Expanded(
                child: interactive
                    ? TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onChanged: onChanged,
                        autofocus: autofocus,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          filled: false,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: AppTranslations.t('common.search_hint'),
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: colorScheme.onSurface.withValues(alpha: 0.45),
                          ),
                        ),
                      )
                    : Text(
                        AppTranslations.t('common.search_hint'),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: colorScheme.onSurface.withValues(alpha: 0.45),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

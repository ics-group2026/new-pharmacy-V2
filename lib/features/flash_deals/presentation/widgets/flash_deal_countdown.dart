import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_translations.dart';

/// Live "time left" pill that ticks once a second until [endsAt] passes.
///
/// Under a day it counts down HH:MM:SS to convey urgency; beyond that it
/// degrades to days/hours so the pill stays narrow.
class FlashDealCountdown extends StatefulWidget {
  const FlashDealCountdown({
    super.key,
    required this.endsAt,
    this.onSurface = false,
  });

  final DateTime endsAt;

  /// Renders light-on-dark, for sitting on top of a deal image.
  final bool onSurface;

  @override
  State<FlashDealCountdown> createState() => _FlashDealCountdownState();
}

class _FlashDealCountdownState extends State<FlashDealCountdown> {
  Timer? _timer;
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = _timeLeft();
    if (!_remaining.isNegative && _remaining != Duration.zero) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    }
  }

  @override
  void didUpdateWidget(FlashDealCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.endsAt != widget.endsAt) {
      _timer?.cancel();
      _remaining = _timeLeft();
      if (!_hasEnded) {
        _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Duration _timeLeft() => widget.endsAt.toLocal().difference(DateTime.now());

  bool get _hasEnded => _remaining.inSeconds <= 0;

  void _tick() {
    final remaining = _timeLeft();
    if (remaining.inSeconds <= 0) _timer?.cancel();
    if (mounted) setState(() => _remaining = remaining);
  }

  String get _label {
    if (_hasEnded) return AppTranslations.t('flash_deals.ended');

    final days = _remaining.inDays;
    if (days > 0) {
      final hours = _remaining.inHours % 24;
      return '${days}d ${hours}h';
    }

    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(_remaining.inHours)}:${two(_remaining.inMinutes % 60)}:'
        '${two(_remaining.inSeconds % 60)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Over an image, a dark scrim reads on any artwork; on the section band it
    // needs the solid urgency accent to stand out against the green.
    final background = widget.onSurface
        ? Colors.black.withValues(alpha: 0.55)
        : (_hasEnded ? Colors.black54 : AppColors.flash);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _hasEnded ? Icons.timer_off_outlined : Icons.timer_outlined,
            size: 12.r,
            color: Colors.white,
          ),
          4.horizontalSpace,
          Text(
            _label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              // Tabular figures stop the pill jittering as the seconds tick.
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

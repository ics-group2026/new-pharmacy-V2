import 'package:flutter/widgets.dart';

/// Focuses [focusNode] once the enclosing route's push animation (the Hero
/// flight into this screen) has finished, so the keyboard doesn't open
/// mid-animation and cause jank. If the route is already settled (no
/// animation, or it already completed), focuses immediately.
void attachHeroAutofocus(BuildContext context, FocusNode focusNode) {
  final animation = ModalRoute.of(context)?.animation;
  if (animation == null || animation.isCompleted) {
    focusNode.requestFocus();
    return;
  }

  void listener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      focusNode.requestFocus();
      animation.removeStatusListener(listener);
    }
  }

  animation.addStatusListener(listener);
}

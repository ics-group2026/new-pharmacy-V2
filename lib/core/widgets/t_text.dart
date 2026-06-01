import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../utils/app_translations.dart';

class TText extends StatelessWidget {
  const TText(
    this.key_, {
    super.key,
    this.args,
    this.namedArgs,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  final String key_;
  final List<String>? args;
  final Map<String, String>? namedArgs;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    context.locale; // register as EasyLocalization dependent so TText rebuilds on locale change
    return Text(
      AppTranslations.t(key_, args: args, namedArgs: namedArgs),
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

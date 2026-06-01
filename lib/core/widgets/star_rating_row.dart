import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarRatingRow extends StatelessWidget {
  const StarRatingRow({super.key, required this.rating, this.size});

  final double rating;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final starSize = size ?? 12.r;
    const starColor = Color(0xFFFFC107);
    final emptyColor = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (i) {
          if (i < rating.floor()) {
            return Icon(Icons.star_rounded, color: starColor, size: starSize);
          } else if (i < rating) {
            return Icon(Icons.star_half_rounded, color: starColor, size: starSize);
          }
          return Icon(Icons.star_rounded, color: emptyColor, size: starSize);
        }),
        3.horizontalSpace,
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 10.sp,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

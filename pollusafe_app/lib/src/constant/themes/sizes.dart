import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// [INFO]
// Constant for sizes to be used in the app with respecting 8 pixel rules
class SizeApp {
  // [INFO]
  // Sizes that related with width
  static final w2 = 2.0.w;
  static final w4 = 4.0.w;
  static final w8 = 8.0.w;
  static final w12 = 12.0.w;
  static final w16 = 16.0.w;
  static final w20 = 20.0.w;
  static final w24 = 24.0.w;
  static final w28 = 28.0.w;
  static final w32 = 32.0.w;
  static final w36 = 36.0.w;
  static final w40 = 40.0.w;
  static final w48 = 48.0.w;
  static final w52 = 52.0.w;
  static final w56 = 56.0.w;
  static final w64 = 64.0.w;
  static final w72 = 72.0.w;
  static final w80 = 80.0.w;
  static final w96 = 96.0.w;

  // [INFO]
  // Sizes that related with height
  static final h4 = 4.0.h;
  static final h8 = 8.0.h;
  static final h12 = 12.0.h;
  static final h16 = 16.0.h;
  static final h20 = 20.0.h;
  static final h24 = 24.0.h;
  static final h28 = 28.0.h;
  static final h32 = 32.0.h;
  static final h36 = 36.0.h;
  static final h40 = 40.0.h;
  static final h48 = 48.0.h;
  static final h52 = 52.0.h;
  static final h56 = 56.0.h;
  static final h64 = 64.0.h;
  static final h72 = 72.0.h;
  static final h80 = 80.0.h;
  static final h96 = 96.0.h;

  /// [INFO]
  /// Sizes for custom width or height outside the 8 pixel rules
  static customWidth(double value) => value.w;
  static customHeight(double value) => value.h;
}

/// [INFO]
/// Constant for gaps to be used in the app with respecting 8 pixel rules
class Gap {
  /// [INFO]
  /// Gaps that related with width
  static const w4 = SizedBox(width: 4);
  static const w8 = SizedBox(width: 8);
  static const w12 = SizedBox(width: 12);
  static const w16 = SizedBox(width: 16);
  static const w20 = SizedBox(width: 20);
  static const w24 = SizedBox(width: 24);
  static const w28 = SizedBox(width: 28);
  static const w32 = SizedBox(width: 32);
  static const w36 = SizedBox(width: 36);
  static const w40 = SizedBox(width: 40);
  static const w48 = SizedBox(width: 48);
  static const w52 = SizedBox(width: 52);
  static const w56 = SizedBox(width: 56);
  static const w64 = SizedBox(width: 64);
  static const w72 = SizedBox(width: 72);
  static const w80 = SizedBox(width: 80);

  /// [INFO]
  /// Gaps that related with height
  static const h4 = SizedBox(height: 4);
  static const h8 = SizedBox(height: 8);
  static const h12 = SizedBox(height: 12);
  static const h16 = SizedBox(height: 16);
  static const h20 = SizedBox(height: 20);
  static const h24 = SizedBox(height: 24);
  static const h28 = SizedBox(height: 28);
  static const h32 = SizedBox(height: 32);
  static const h36 = SizedBox(height: 36);
  static const h40 = SizedBox(height: 40);
  static const h48 = SizedBox(height: 48);
  static const h52 = SizedBox(height: 52);
  static const h56 = SizedBox(height: 56);
  static const h64 = SizedBox(height: 64);
  static const h72 = SizedBox(height: 72);
  static const h80 = SizedBox(height: 80);

  /// [INFO]
  /// Gaps for custom width or height outside the 8 pixel rules
  static customGapWidth(double value) => SizedBox(width: value);
  static customGapHeight(double value) => SizedBox(height: value);
}

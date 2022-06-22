import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants.dart';
//提供监控信息
final isDarkProvider = StateProvider<bool>((ref) => false);
final backgroundProvider = StateProvider<Color>((ref) => backgroundC[0]);
final shadowProvider = StateProvider<Color>((ref) => shadowC[0]);
final lightShadowProvider = StateProvider<Color>((ref) => lightShadowC[0]);
final textProvider = StateProvider<Color>((ref) => textC[0]);

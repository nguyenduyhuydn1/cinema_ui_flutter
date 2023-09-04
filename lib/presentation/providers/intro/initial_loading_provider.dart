import 'package:cinema_ui_flutter/presentation/providers/intro/intro_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingIntroProvider = Provider.autoDispose<bool>((ref) {
  final data1 = ref.watch(introProvider1).movies.isEmpty;
  final data2 = ref.watch(introProvider2).movies.isEmpty;
  final data3 = ref.watch(introProvider3).movies.isEmpty;
  if (data1 || data2 || data3) return true;
  return false;
});

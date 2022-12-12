import 'package:easy_localization/easy_localization.dart';

extension InternalLocalization on String {
  String get translate {
    return this.tr();
  }
}
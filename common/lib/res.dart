import 'dart:math';

import 'package:common/utils/network_exceptions.dart';
import 'package:common/utils/data_exception.dart';
import 'package:common/styles.dart';
import 'package:common/ui/svg_assets.dart';
import 'package:flutter/material.dart';

class HCommonStrings {
  static String httpErrorClient = 'Не удалось отправить запрос';

  static String httpErrorNoInternet = 'Отсутствует подключение к сети';

  static String httpErrorJsonDecode = 'Неверный формат данных';

  static String httpErrorUnknown = 'Неизвестная ошибка';

  static String httpErrorTitle(HttpException e) => 'Ошибка. ' + e.userMessage;

  static String httpErrorDetails(HttpException e) =>
      'Попробуйте повторить операцию позже, если не поможет, то обратитесь в поддержку.';

  static String apiErrorTitle(HHttpApiError e) => 'Ошибка. ' + e.userMessage;

  static String apiErrorDetails(HHttpApiError e) =>
      'Попробуйте повторить операцию изменив параметры, если не поможет, то обратитесь в поддержку.';

  static String dataErrorTitle(InconsistentDataException e) =>
      'Ошибка. Неверный формат данных.';

  static String dataErrorDetails(InconsistentDataException e) =>
      'Попробуйте повторить операцию позже, если не поможет, то обратитесь в поддержку.';

  static String unknownErrorTitle(dynamic e) => 'Ошибка. ' + e.toString();

  static String unknownErrorDetails(dynamic e) =>
      'Произошла неизвестная ошибка. Повторите операцию, если не поможет, то обратитесь в поддержку.';

  static String syncWillRetryDetails(Duration? delay) =>
      'Через ${delay!.inSeconds} секунд мы попробуем повторить операцию';

  HCommonStrings._();
}

class HImages {

  static const iconFavorite = GASvgAsset('assets/star.svg');

  static const iconFavoriteActive = GASvgAsset('assets/star_filled.svg');

  static const iconNext = GASvgAsset('assets/next.svg');

  static const iconBack = GASvgAsset('assets/back.svg');
}

class HDimens {
  static const pageHorizontalMargin = 16.0;

  static const inputBorderRadius = 10.0;

  static const inputBorderActiveWidth = 0.5;

  static const listTileIconSize = 24.0;

  static const hugeTileIconIconSize = 60.0;

  HDimens._();
}

class HButtonsRes {
  static const textFontSize = 17.0;

  static const textFontWeight = FontWeight.w400;
}

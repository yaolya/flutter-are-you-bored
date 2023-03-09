import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final _t = Translations("en_us") +
      {
        "en_us": "Are You Bored?",
        "ru_ru": "Не знаете, чем заняться?",
      } +
      {
        "en_us": "Saved Activities",
        "ru_ru": "Сохраненные занятия",
      } +
      {
        "en_us": "Get an activity",
        "ru_ru": "Начать",
      } +
      {
        "en_us": "Save activity",
        "ru_ru": "Сохранить",
      } +
      {
        "en_us": "Get next",
        "ru_ru": "Показать другое",
      } +
      {
        "en_us": "Tap a button to get an activity",
        "ru_ru": "Нажмите, чтобы начать выбор занятия",
      } +
      {
        "en_us": "Home",
        "ru_ru": "Выбор занятия",
      } +
      {
        "en_us": "Saved activities",
        "ru_ru": "Сохраненные",
      };

  String get i18n => localize(this, _t);
}

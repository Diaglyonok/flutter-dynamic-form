import '../model/auto_calculate_field.dart';
import '../model/dynamic_form_models.dart';

class DynamicFormUtils {
  static bool checkErrors(Field field, Map<String, String>? errors) {
    return errors != null && errors[field.fieldId] != null;
  }

  static String? Function(T)? getMultivalidator<T>(List<Function(T)?>? validators) {
    if (validators == null) {
      return null;
    }

    return (T value) {
      String? result;

      for (int i = 0; i < validators.length; i++) {
        if (validators[i] == null) {
          continue;
        }
        result = validators[i]!(value);
        if (result != null) break;
      }

      return result;
    };
  }

  static bool checkShouldShow({
    required Field field,
    required Map<String, CompositeValue> values,
  }) {
    if (field.dependsOn == null || field.dependsOn!.isEmpty) {
      return true;
    }

    var result = true;

    for (var i = 0; i < field.dependsOn!.length; i++) {
      final dependsOnValue = field.dependsOn![i];
      result = result &&
          (dependsOnValue.conditionValueNonEmpty == true &&
                  (values[dependsOnValue.fieldId]?.value.isNotEmpty ?? false) ||
              values[dependsOnValue.fieldId]?.value == dependsOnValue.conditionValue ||
              values[dependsOnValue.fieldId]?.extra == dependsOnValue.conditionExtra &&
                  dependsOnValue.conditionExtra != null);
    }

    return result;
  }

  static CompositeValue? getAutoUpdateValue({
    required Field field,
    required Map<String, CompositeValue> values,
  }) {
    if (field is! AutoCalculateField) {
      return null;
    }

    return field.calculate(values);
  }
}

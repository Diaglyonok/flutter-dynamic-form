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
      final valueField = values[dependsOnValue.fieldId];

      result = result &&
          (dependsOnValue.checkNullValue ? valueField != null : true) &&
          dependsOnValue.condition(valueField?.value ?? '', valueField?.extra);
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

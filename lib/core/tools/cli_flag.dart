class CliFlag {
  final String? abbreviation;
  final bool allowMultiple;
  final String defaultValue;
  final String name;
  final bool required;

  CliFlag({
    this.abbreviation,
    this.allowMultiple = false,
    this.defaultValue = '',
    required this.name,
    this.required = false,
  });

  List<String> getValue({required List<String> input}) {
    final int index;
    if (abbreviation != null && input.contains(abbreviation)) {
      index = input.indexOf(abbreviation!);
    } else {
      if (input.contains(name)) {
        index = input.indexOf(name);
      } else {
        if (required) {
          return [defaultValue];
        }
        throw Exception('required flag missing [$name]');
      }
    }

    if (allowMultiple) {
      return input[index + 1].split(',');
    }

    return [input[index + 1]];
  }

  bool isPresent({required List<String> input}) {
    return ((abbreviation != null && input.contains(abbreviation)) ||
        input.contains(name));
  }
}

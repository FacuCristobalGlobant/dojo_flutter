import 'package:dojo_flutter/constants/measures.dart';
import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    super.key,
    required this.displayText,
    required this.isSelected,
    required this.onPressed,
  });

  final String displayText;
  final bool isSelected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.all(
            Radius.circular(
              Measures.small,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Measures.xSmall),
          child: Text(
            displayText,
            style: isSelected
                ? TextStyle(
                    backgroundColor: Colors.white,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                : TextStyle(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GenderSelect extends StatefulWidget {
  const GenderSelect({Key? key, required this.onSaved}) : super(key: key);

  final FormFieldSetter<Map<String, bool>> onSaved;

  @override
  State<GenderSelect> createState() => _GenderSelectState();
}

class _GenderSelectState extends State<GenderSelect> {
  void updateState(Map<String, bool> genderState, String gender) {
    genderState.forEach((key, value) => genderState[key] = false);

    setState(() {
      genderState[gender] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      initialValue: {
        "female": true,
        "male": false,
        "other": false,
      },
      builder: (FormFieldState<Map<String, bool>> state) {
        return Row(
          children: [
            Expanded(
              child: GenderButton(
                onPressed: () => updateState(state.value!, "female"),
                icon: Icons.female,
                active: state.value!["female"]!,
              ),
            ),
            Expanded(
              child: GenderButton(
                onPressed: () => updateState(state.value!, "male"),
                icon: Icons.male,
                active: state.value!["male"]!,
              ),
            ),
            Expanded(
              child: GenderButton(
                onPressed: () => updateState(state.value!, "other"),
                icon: Icons.transgender,
                active: state.value!["other"]!,
              ),
            ),
          ],
        );
      },
      onSaved: widget.onSaved,
    );
  }
}

class GenderButton extends StatelessWidget {
  const GenderButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.active,
  }) : super(key: key);

  final Function onPressed;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        color: active
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.background,
        child: IconButton(
          onPressed: () => onPressed(),
          icon: Icon(
            icon,
            color: active
                ? Theme.of(context).colorScheme.onSecondary
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

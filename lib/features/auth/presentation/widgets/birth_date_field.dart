
import 'package:flutter/material.dart';

class BirthDateField extends FormField<DateTime> {
  BirthDateField({
    super.key,
    required ValueChanged<DateTime> onDateSelected,
    DateTime? selectedDate,
  }) : super(
          initialValue: selectedDate,
          validator: (value) {
            if (value == null) {
              return 'Debes seleccionar tu fecha de nacimiento';
            }

            return null;
          },
          builder: (state) {
            final date = state.value;
            final hasError = state.hasError;
            final errorColor =
                Theme.of(state.context).colorScheme.error;

            final dateText = date == null
                ? ''
                : '${date.day.toString().padLeft(2, '0')}/'
                    '${date.month.toString().padLeft(2, '0')}/'
                    '${date.year}';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final now = DateTime.now();

                    final pickedDate = await showDatePicker(
                      context: state.context,
                      initialDate: date ?? now,
                      firstDate: DateTime(1900),
                      lastDate: now,
                    );

                    if (pickedDate != null) {
                      state.didChange(pickedDate);
                      onDateSelected(pickedDate);
                    }
                  },
                  child: InputDecorator(
                    isEmpty: date == null,
                    decoration: InputDecoration(
                      labelText: 'Fecha de nacimiento',
                      hintText: 'Selecciona tu fecha de nacimiento',
                      prefixIcon: const Icon(
                        Icons.calendar_today_outlined,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: hasError
                              ? errorColor
                              : Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: hasError
                              ? errorColor
                              : Theme.of(state.context)
                                  .colorScheme.primary,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      dateText,
                      style: TextStyle(
                        color: hasError
                            ? errorColor
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),

                if (state.errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      top: 6,
                    ),
                    child: Text(
                      state.errorText!,
                      style: TextStyle(
                        color: errorColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}

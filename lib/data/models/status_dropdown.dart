import 'package:flutter/material.dart';

class StatusDropdown extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;
  final List<String> statusList;
  final Widget dropdownIcon;
  final String hint;

  const StatusDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.statusList,
    required this.dropdownIcon,
    this.hint = 'Select status',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: dropdownIcon, // your custom icon
          dropdownColor: Color(0xff2a2a2d),
          style: const TextStyle(color: Colors.white),
          hint: Text(hint, style: const TextStyle(color: Colors.white)),
          selectedItemBuilder: (context) {
            return statusList.map((status) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              );
            }).toList();
          },
          items: statusList.map((status) {
            return DropdownMenuItem<String>(
              value: status,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                  Icon(
                    value == status
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: value == status ? Colors.cyanAccent : Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

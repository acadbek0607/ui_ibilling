import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_ibilling/data/models/notifier.dart';
import 'package:ui_ibilling/data/models/status_dropdown.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({super.key});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  String? selectedStatus;
  String? selectedType;

  final List<String> statusList = ['Физическое', 'Юридическое'];
  final List<String> list = [
    'Paid',
    'In process',
    'Rejected by IQ',
    'Rejected by PayMe',
  ];

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController innController = TextEditingController();

  bool get isAllFilled {
    return selectedStatus != null &&
        selectedType != null &&
        fullNameController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty &&
        innController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Лицо"),
          SizedBox(height: 6.0),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
            child: StatusDropdown(
              value: selectedType,
              onChanged: (newValue) {
                setState(() {
                  selectedType = newValue;
                });
              },
              statusList: statusList,
              dropdownIcon: SvgPicture.asset('assets/svg/drop_down.svg'),
            ),
          ),
          SizedBox(height: 16.0),
          Text("Fisher's full name"),
          SizedBox(height: 6.0),
          TextField(
            controller: fullNameController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text("Address of the organization"),
          SizedBox(height: 6.0),
          TextField(
            controller: addressController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text("ИНН"),
          SizedBox(height: 6.0),
          TextField(
            controller: innController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Help"),
                      content: const Text("This is some helpful information."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset('assets/svg/help.svg'),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text("Status of the contacts"),
          SizedBox(height: 6.0),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0)),
            child: StatusDropdown(
              value: selectedStatus,
              onChanged: (newValue) {
                setState(() {
                  selectedStatus = newValue;
                });
              },
              statusList: list,
              dropdownIcon: SvgPicture.asset('assets/svg/drop_down.svg'),
            ),
          ),
          SizedBox(height: 16.0),
          if (isAllFilled)
            ElevatedButton(
              onPressed: () => selectedPageNotifier.value = 0,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                backgroundColor: Color(0xff008F7F),
              ),
              child: Text(
                'Save contact',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_ibilling/data/models/notifier.dart';
import 'package:ui_ibilling/data/models/status_dropdown.dart';

class NewInvoicePage extends StatefulWidget {
  const NewInvoicePage({super.key});

  @override
  State<NewInvoicePage> createState() => _NewInvoicePageState();
}

class _NewInvoicePageState extends State<NewInvoicePage> {
  String? selectedStatus;
  final List<String> selectedList = [
    'Paid',
    'In process',
    'Rejected by IQ',
    'Rejected by PayMe',
  ];

  final TextEditingController serviceController = TextEditingController();
  final TextEditingController costController = TextEditingController();

  bool get isAllFilled {
    return selectedStatus != null &&
        serviceController.text.trim().isNotEmpty &&
        costController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Service name"),
          SizedBox(height: 6.0),
          TextField(
            controller: serviceController,
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
          Text("Cost of invoice"),
          SizedBox(height: 6.0),
          TextField(
            controller: costController,
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
          Text("Status of the invoice"),
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
              statusList: selectedList,
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
                'Save invoice',
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

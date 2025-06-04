import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_ibilling/data/models/classes.dart';
import '../../data/models/notifier.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final DateFormat dateFormat = KDataFormat.dateFormat;

  bool paid = false;
  bool inProcess = false;
  bool rejectedByIQ = false;
  bool rejectedByPayme = false;

  DateTime? fromDate;
  DateTime? toDate;

  // Pick date helper
  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final initialDate = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  void _applyFilters() {
    selectedPageNotifier.value = 0;
  }

  void _cancelFilters() {
    setState(() {
      paid = false;
      inProcess = false;
      rejectedByIQ = false;
      rejectedByPayme = false;
      fromDate = null;
      toDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text(
            "Status",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),
          Row(
            children: [
              Flexible(
                child: CheckboxListTile(
                  value: paid,
                  onChanged: (val) => setState(() => paid = val!),
                  title: Text(
                    'Paid',
                    style: TextStyle(
                      color: paid ? Colors.white : Colors.white70,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.white,
                ),
              ),
              Flexible(
                child: CheckboxListTile(
                  value: rejectedByIQ,
                  onChanged: (val) => setState(() => rejectedByIQ = val!),
                  title: Text(
                    'Rejected by IQ',
                    style: TextStyle(
                      color: rejectedByIQ ? Colors.white : Colors.white70,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: CheckboxListTile(
                  value: inProcess,
                  onChanged: (val) => setState(() => inProcess = val!),
                  title: Text(
                    'In process',
                    style: TextStyle(
                      color: inProcess ? Colors.white : Colors.white70,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.white,
                ),
              ),
              Flexible(
                child: CheckboxListTile(
                  value: rejectedByPayme,
                  onChanged: (val) => setState(() => rejectedByPayme = val!),
                  title: Text(
                    'Rejected by Payme',
                    style: TextStyle(
                      color: rejectedByPayme ? Colors.white : Colors.white70,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
          const Text(
            "Date",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, true),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'From',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      fromDate != null
                          ? dateFormat.format(fromDate!)
                          : 'Select',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.minimize_rounded, weight: 2, size: 8),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context, false),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'To',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      toDate != null ? dateFormat.format(toDate!) : 'Select',
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _cancelFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.withAlpha(125),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('Apply filters'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

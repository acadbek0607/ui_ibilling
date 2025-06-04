import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/svg.dart';
import 'package:ui_ibilling/data/models/classes.dart';
import '../../../data/models/invoice_data.dart';
import '../../../data/models/notifier.dart';
import 'calendar.dart';
import 'invoice_card.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  bool isSelected = true;
  final int itemsPerPage = 3;
  int currentMax = 3;
  List<InvoiceData> allInvoices = [];

  List<InvoiceData> get displayedInvoices =>
      allInvoices.take(currentMax).toList();

  @override
  void initState() {
    loadInvoices();
    super.initState();
  }

  Future<void> loadInvoices() async {
    final String response = await rootBundle.loadString(
      'assets/json/contacts.json',
    );
    final List<dynamic> data = jsonDecode(response);
    setState(() {
      allInvoices = data
          .map((invoice) => InvoiceData.fromJson(invoice))
          .toList();
    });
    allInvoicesNotifier.value = allInvoices;
  }

  loadMore() {
    setState(() {
      currentMax += itemsPerPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(color: Color(0xFF1E1E20), child: Calendar()),
        SizedBox(height: 32),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSelected = true;
                          });
                        },
                        style: Kstyle.buttonStyle.copyWith(
                          backgroundColor: isSelected
                              ? WidgetStateProperty.all<Color>(
                                  Color(0xFF00A795),
                                )
                              : WidgetStateProperty.all<Color>(
                                  Color(0xFF00A795).withAlpha(0),
                                ),
                        ),
                        child: Text(
                          'Contacts',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSelected = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          backgroundColor: !isSelected
                              ? Color(0xFF008F7F)
                              : Colors.transparent,
                        ),
                        child: Text(
                          'Invoice',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                displayedInvoices.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/s_contacts.svg',
                              height: 88,
                              width: 88,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'No contacts are made',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: displayedInvoices.length + 1,
                          itemBuilder: (context, index) {
                            if (index < displayedInvoices.length) {
                              final invoice = displayedInvoices[index];
                              return InvoiceCard(
                                data: invoice,
                                onTap: () {
                                  selectedInvoiceNotifier.value = invoice;
                                  selectedPageNotifier.value =
                                      lastMainTabNotifier.value;
                                },
                              );
                            } else if (displayedInvoices.length <
                                allInvoices.length) {
                              return TextButton(
                                onPressed: loadMore,
                                child: Text('LoadMore'),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

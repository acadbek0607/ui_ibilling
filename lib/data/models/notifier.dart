import 'package:flutter/material.dart';
import 'invoice_data.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<int> lastMainTabNotifier = ValueNotifier(0);
ValueNotifier<InvoiceData?> selectedInvoiceNotifier = ValueNotifier(null);
ValueNotifier<List<InvoiceData>> allInvoicesNotifier = ValueNotifier([]);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);

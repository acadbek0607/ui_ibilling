import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/invoice_data.dart';
import '../../data/models/notifier.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  static const List<String> title = [
    "Contacts",
    "History",
    "New",
    "Saved",
    "Profile",
  ];

  static String getTitle(int index, [InvoiceData? selectedInvoice]) {
    if (index == 5 && selectedInvoice != null) {
      return selectedInvoice.invoiceNumber.toString();
    }
    return title[index];
  }

  @override
  Widget build(BuildContext context) {
    int getSelectedIndex(int page) {
      if (page == 8 || page == 9) {
        return 2; // Treat NewContact & NewInvoice as part of "New"
      }
      if (page <= 4) return page;
      return lastMainTabNotifier.value;
    }

    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        final selectedIndex = getSelectedIndex(selectedPage);
        return NavigationBar(
          indicatorColor: Colors.transparent,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          destinations: List.generate(5, (index) {
            final isSelected = selectedIndex == index;
            final iconName = [
              'contacts',
              'history',
              'new',
              'saved',
              'profile',
            ][index];
            return NavigationDestination(
              icon: SvgPicture.asset(
                'assets/svg/${isSelected ? 's_' : ''}$iconName.svg',
              ),
              label: title[index],
            );
          }),
          onDestinationSelected: (int value) {
            lastMainTabNotifier.value = value;
            selectedPageNotifier.value = value;
            selectedInvoiceNotifier.value = null;
          },
          selectedIndex: selectedIndex,
        );
      },
    );
  }
}

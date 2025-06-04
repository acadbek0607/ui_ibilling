import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_ibilling/data/models/notifier.dart';

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: Container(
          // color: Color(0xff2a2a2d),
          margin: EdgeInsets.symmetric(horizontal: 24.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Color(0xff2a2a2d),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'What you want to create?',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Ubuntu',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 28.0),
              FilledButton(
                onPressed: () => selectedPageNotifier.value = 8,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  backgroundColor: Color(0xff4E4E4E),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/contact.svg'),
                    SizedBox(width: 12.0),
                    Text(
                      'Contract',
                      style: TextStyle(
                        color: Color(0xffE7E7E7),
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              FilledButton(
                onPressed: () {
                  selectedPageNotifier.value = 9;
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  backgroundColor: Color(0xff4E4E4E),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/svg/invoice.svg'),
                    SizedBox(width: 12.0),
                    Text(
                      'Invoice',
                      style: TextStyle(
                        color: Color(0xffE7E7E7),
                        fontFamily: 'Ubuntu',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

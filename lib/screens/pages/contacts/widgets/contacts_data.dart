import 'package:flutter/material.dart';

class ContactsData extends StatelessWidget {
  const ContactsData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              Text('Kesk 3, Varnja, 60305'),
              Text('Priest: Peeter'),
              Text('+372 5555 5555'),
              Text('varnja.issanda.kirik@gmail.com'),
            ],
          ),
        ),
      ],
    );
  }
}

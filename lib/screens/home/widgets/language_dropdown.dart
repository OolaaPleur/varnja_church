import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varnja_church/l10n/l10n.dart';

import '../../../constants/constants.dart';
import '../../settings/language_cubit/language_cubit.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLanguage = context.read<LanguageCubit>().state.languageCode;
    final dropdownItems = getDropdownItems(context.l10n);

    return DropdownButton<LanguageItem>(
      padding: EdgeInsets.all(4),
      value: dropdownItems.firstWhere((item) => item.languageCode == currentLanguage),
      onChanged: (LanguageItem? newValue) {
        if (newValue != null) {
          context.read<LanguageCubit>().changeLanguage(Locale(newValue.languageCode));
        }
      },
      items: dropdownItems.map<DropdownMenuItem<LanguageItem>>((LanguageItem item) {
        return DropdownMenuItem<LanguageItem>(
          value: item,
          child: Row(
            children: [
              SizedBox(width: 8),
              CountryFlag.fromCountryCode(item.countryCode, width: 20, height: 20,),
              SizedBox(width: 8),
              Text(item.name),
            ],
          ),
        );
      }).toList(),
    );
  }

}

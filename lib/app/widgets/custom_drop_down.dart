import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  String? selectedLanguage;
  List<Languages> languages;

  final Function(String) onSelected;

  CustomDropDown(
      {super.key,
      required this.onSelected,
      required this.languages,
      this.selectedLanguage});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.selectedLanguage ?? ' ';
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      padding: const EdgeInsets.only(left: 15, right: 15),
      value: selectedLanguage,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      isExpanded: true,
      onChanged: (String? newLang) {
        setState(() {
          selectedLanguage = newLang;
        });
        widget.onSelected(newLang!);
      },
      items: widget.languages.map((Languages lang) {
        return DropdownMenuItem<String>(
          value: lang.code,
          child: Text(lang.name),
        );
      }).toList(),
    );
  }
}
class Languages {
  final String name;
  final String code;

  const Languages(this.name, this.code);
}
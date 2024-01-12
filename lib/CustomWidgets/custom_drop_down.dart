import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final void Function(String)? onChanged;
  final String? selectString;
  CustomDropdown(
      {required this.items, this.onChanged, required this.selectString});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final TextEditingController _typeAheadController = TextEditingController();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    ScreenScaler sScaler = ScreenScaler()..init(context);
    return TypeAheadField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        controller: _typeAheadController,
        decoration: InputDecoration(
          labelText: widget.selectString,
          labelStyle: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: const Color(0xFF57636C),
            fontSize: sScaler.getTextSize(11),
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFF1F4F8),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF4B39EF),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFE0E3E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFE0E3E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color(0xFFF1F4F8),
          suffixIcon: InkWell(
            focusNode: FocusNode(skipTraversal: true),
            child: const Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF57636C),
              size: 30,
            ),
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return widget.items.where(
            (item) => item.toLowerCase().contains(pattern.toLowerCase()));
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        setState(() {
          selectedValue = suggestion;
          _typeAheadController.text = suggestion;
          if (widget.onChanged != null) {
            widget.onChanged!(suggestion);
          }
        });
      },
      noItemsFoundBuilder: (context) {
        return const ListTile(
          title: Text('No items found'),
        );
      },
    );
  }
}




// Way to use this Custom Drop Down -- >


// Declare List and selectedValue -> 
  // List<String> items = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];
  // late String? selectedValue;



// Now Use CustomeWidget - >

  // Padding(
  //   padding: const EdgeInsetsDirectional.fromSTEB(
  //       32, 32, 32, 32),
  //   child: SizedBox(
  //       width: 370,
  //       child: CustomDropdown(
  //         items: items,
  //         selectString: "Cutomer",
  //         onChanged: (selectedItem) {
  //           selectedValue = selectedItem;
  //         },
  //       )),
  // ),
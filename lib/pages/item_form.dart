import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({super.key});

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: _itemNameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Amount',
              ),
              keyboardType:
                  TextInputType.number, // Set the keyboard type to numeric
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9]')), // Allow only numeric input
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: DateTimeFormField(
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'Select A Date',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('Item name: ${_itemNameController.text}');
              print('Item amount: ${_amountController.text}');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}

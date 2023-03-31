import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SmallFisheryGrantApplicationPage extends StatefulWidget {
  const SmallFisheryGrantApplicationPage({Key? key}) : super(key: key);

  @override
  _SmallFisheryGrantApplicationPageState createState() =>
      _SmallFisheryGrantApplicationPageState();
}

class _SmallFisheryGrantApplicationPageState
    extends State<SmallFisheryGrantApplicationPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _phoneNumber = '';
  String _selectedScheme = '';
  String _reasons = '';
  String _bankName = '';
  String _accountNumber = '';
  String _ifscCode = '';

  void _submitForm() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      final application = {
        'name': _name,
        'phone_number': _phoneNumber,
        'selected_scheme': _selectedScheme,
        'reasons': _reasons,
        'bank_name': _bankName,
        'account_number': _accountNumber,
        'ifsc_code': _ifscCode,
      };
      await FirebaseFirestore.instance
          .collection('grant_applications')
          .add(application);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Grant application submitted!')),
      );
      form.reset();
      setState(() {
        _selectedScheme = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply for Grant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) => _phoneNumber = value!,
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedScheme.isNotEmpty ? _selectedScheme : null,
                  decoration: InputDecoration(labelText: 'Scheme'),
                  onChanged: (value) {
                    setState(() {
                      _selectedScheme = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a scheme';
                    }
                    return null;
                  },
                  items: <String>[
                    'The Tides of Change',
                    'Scheme 2',
                    'Scheme 3',
                    'Scheme 4',
                  ].map((scheme) {
                    return DropdownMenuItem<String>(
                      value: scheme,
                      child: Text(scheme),
                    );
                  }).toList(),
                  selectedItemBuilder: (BuildContext context) {
                    return <String>[
                      'Scheme 1',
                      'Scheme 2',
                      'Scheme 3',
                      'Scheme 4',
                    ].map<Widget>((String value) {
                      return Text(value);
                    }).toList();
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Reasons'),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide reasons for the grant';
                    }
                    return null;
                  },
                  onSaved: (value) => _reasons = value!,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Bank Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter bank name';
                    }
                    return null;
                  },
                  onSaved: (value) => _bankName = value!,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Account Number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter account number';
                    }
                    return null;
                  },
                  onSaved: (value) => _accountNumber = value!,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'IFSC Code'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter IFSC code';
                    }
                    return null;
                  },
                  onSaved: (value) => _ifscCode = value!,
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

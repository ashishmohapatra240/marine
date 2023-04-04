import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminAddEventPage extends StatefulWidget {
  const AdminAddEventPage({Key? key}) : super(key: key);

  @override
  _AdminAddEventPageState createState() => _AdminAddEventPageState();
}

class _AdminAddEventPageState extends State<AdminAddEventPage> {
  final _formKey = GlobalKey<FormState>();

  late String _eventName;
  late String _description;
  late String _eventType = 'Marine Festivals';
  late int _costPerPerson;
  late String _availableTime;
  late String _location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Add Event'.text.make(),
      ),
      body: VStack(
        [
          Form(
            key: _formKey,
            child: VStack(
              [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Event Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name for the event';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _eventName = value;
                    });
                  },
                ),
                16.heightBox,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description for the event';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
                ),
                16.heightBox,
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Event Type',
                  ),
                  value: _eventType,
                  items: [
                    DropdownMenuItem(
                      value: 'Marine Festivals',
                      child: Text('Marine Festivals'),
                    ),
                    DropdownMenuItem(
                      value: 'Water Sports',
                      child: Text('Water Sports'),
                    ),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a type for the event';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _eventType = value.toString();
                    });
                  },
                ),
                16.heightBox,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Cost per Person',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a cost per person for the event';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _costPerPerson = int.parse(value);
                    });
                  },
                ),
                16.heightBox,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Available Time',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the available time for the event';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _availableTime = value;
                    });
                  },
                ),
                16.heightBox,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location for the event';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _location = value;
                    });
                  },
                ),
                32.heightBox,
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final event = {
                        'eventName': _eventName,
                        'description': _description,
                        'eventType': _eventType,
                        'costPerPerson': _costPerPerson,
                        'availableTime': _availableTime,
                        'location': _location,
                      };
                      await FirebaseFirestore.instance
                          .collection('events')
                          .add(event);
                      context.showToast(msg: 'Event added successfully');
                      Navigator.pop(context);
                    }
                  },
                  child: 'Add Event'.text.make(),
                ),
              ],
              crossAlignment: CrossAxisAlignment.stretch,
            ),
          ),
        ],
        alignment: MainAxisAlignment.center,
      ).p16(),
    );
  }
}

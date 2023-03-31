import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        title: Text('Add Event'),
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
                  decoration: InputDecoration(labelText: 'Event Name'),
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
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
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
                SizedBox(height: 16.0),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Event Type'),
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
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cost per Person'),
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
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Available Time'),
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
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Location'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location for the event';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _location = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance.collection('events').add({
                        'name': _eventName,
                        'description': _description,
                        'eventType': _eventType,
                        'costPerPerson': _costPerPerson,
                        'availableTime': _availableTime,
                        'location': _location,
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Event added successfully')));
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed to add event: $error')));
                      });
                    }
                  },
                  child: Text('Add Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

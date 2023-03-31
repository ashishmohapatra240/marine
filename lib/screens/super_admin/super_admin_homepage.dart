import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuperAdminPage extends StatelessWidget {
  String routeName = '/super_admin_homepage';

  SuperAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Small Fishery Responses'),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('responses').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final responses = snapshot.data!.docs;
          return ListView.builder(
            itemCount: responses.length,
            itemBuilder: (context, index) {
              final response = responses[index];
              final name = response['name'] as String?;
              final email = response['email'] as String?;
              final phone = response['phone'] as String?;
              final income = response['income'];
              final location = response['location'] as String?;
              final verified = response['verified'] as bool?;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    title: Text(name ?? 'N/A'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(email ?? 'N/A'),
                        Text(phone ?? 'N/A'),
                        Text(income != null ? 'Income: $income' : 'N/A'),
                        Text(location ?? 'N/A'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              await response.reference
                                  .update({'verified': true});
                            },
                            child: Text('Accept'),
                            style: ElevatedButton.styleFrom(
                                elevation: 0, primary: Color(0xFF4264EC))),
                        SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () async {
                            await response.reference.delete();
                          },
                          child: Text('Deny'),
                          style: OutlinedButton.styleFrom(
                            primary: Color(0xFF4264EC),
                            side: BorderSide(color: Color(0xFF4264EC)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

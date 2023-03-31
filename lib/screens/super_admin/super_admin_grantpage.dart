import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuperAdminGrantPage extends StatefulWidget {
  const SuperAdminGrantPage({Key? key}) : super(key: key);

  @override
  _SuperAdminGrantPageState createState() => _SuperAdminGrantPageState();
}

class _SuperAdminGrantPageState extends State<SuperAdminGrantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grant Applications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('grant_applications')
                    .orderBy('name')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final documents = snapshot.data!.docs;
                  if (documents.isEmpty) {
                    return Center(
                      child: Text('No grant applications found'),
                    );
                  }

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final application = documents[index].data();

                      return Card(
                        child: ListTile(
                          title: Text(
                              (application as Map<String, dynamic>)['name']),
                          subtitle: Text((application
                              as Map<String, dynamic>)['phone_number']),
                          trailing: Text((application
                              as Map<String, dynamic>)['selected_scheme']),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

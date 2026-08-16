import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_course/screens/Auth.dart';
import 'package:supabase_course/screens/create.dart';
import 'package:supabase_course/services/AuthSupa.dart';
import 'package:supabase_course/services/note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> notes = [];

  loadData() async {
    notes = await Note().read();

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                try {
                  await Authsupa().logOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Auth()),
                  );
                } on Exception catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              icon: Icon(Icons.logout, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RefreshIndicator(
          onRefresh: () => loadData(),
          child: ListView.separated(
            itemCount: notes.length,
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                tileColor: const Color.fromARGB(255, 1, 55, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                title: Text(
                  note['title'],
                  style: TextStyle(color: Colors.white),
                ),
                leading: note['image_path'] != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                          Note().getImageUrl(note['image_path']),
                        ),
                      )
                    : SizedBox.shrink(),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Create(note: note),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () async {
                        await Note().delete(note['id']);
                        await loadData();
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 6, 139, 228),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => Create()));
        },
      ),
    );
  }
}

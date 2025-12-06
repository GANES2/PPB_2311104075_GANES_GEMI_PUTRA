import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'form_tambah.dart';
import 'form_edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> datamahasiswa;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() {
    datamahasiswa = DatabaseHelper().read();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLite Biodata Mahasiswa"),
        backgroundColor: Colors.amber[700],
      ),
      body: FutureBuilder(
        future: datamahasiswa,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada data mahasiswa"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final m = data[index];

              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.grey.shade50,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar Aesthetic
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.amber.shade700,
                                Colors.orange.shade400,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              m['nama'][0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 18),

                        // Text Section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // NAMA
                              Text(
                                m['nama'],
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade900,
                                ),
                              ),

                              const SizedBox(height: 8),
                              Divider(color: Colors.grey.shade300, thickness: 1),

                              const SizedBox(height: 10),

                              // NIM
                              Row(
                                children: [
                                  Icon(Icons.badge_rounded,
                                      size: 22, color: Colors.amber.shade700),
                                  const SizedBox(width: 10),
                                  Text("NIM: ${m['nim']}",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey.shade800)),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // ALAMAT
                              Row(
                                children: [
                                  Icon(Icons.location_on_rounded,
                                      size: 22, color: Colors.red.shade400),
                                  const SizedBox(width: 10),
                                  Text("Alamat: ${m['alamat']}",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey.shade800)),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // HOBI
                              Row(
                                children: [
                                  Icon(Icons.favorite_rounded,
                                      size: 22, color: Colors.pink.shade400),
                                  const SizedBox(width: 10),
                                  Text("Hobi: ${m['hobi']}",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey.shade800)),
                                ],
                              ),

                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () {
                                      // Navigate to edit form
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => FormEdit(mahasiswa: m),
                                        ),
                                      ).then((_) => refreshData());
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      await DatabaseHelper().delete(m['id']);
                                      refreshData();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[700],
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormTambah()),
          );
          refreshData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

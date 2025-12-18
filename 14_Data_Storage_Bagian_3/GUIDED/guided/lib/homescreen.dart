import 'controller.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _isLoading = false;
  List _post = [];
  String? idPutData = "";

  final ApiService _apiService = ApiService();

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController inputNama = TextEditingController();
    TextEditingController inputNIM = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("CRUD API Demo"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info ID Update
              if (idPutData?.isNotEmpty ?? false)
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "ID Data yang di update: $idPutData",
                    style: TextStyle(color: Colors.blue.shade700),
                  ),
                ),

              // Input Nama
              Text("Nama", style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              TextField(
                controller: inputNama,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
              SizedBox(height: 12),

              // Input NIM
              Text("NIM", style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 4),
              TextField(
                controller: inputNIM,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Tombol Kirim/Update
              Row(
                children: [
                  Expanded(
                    child: (idPutData?.isEmpty ?? true)
                        ?
                          // Button kirim data
                          ElevatedButton(
                            onPressed: () async {
                              if (inputNama.text.isEmpty ||
                                  inputNIM.text.isEmpty) {
                                _showSnackbar(
                                  'Nama dan NIM tidak boleh kosong',
                                );
                                return;
                              }
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                await _apiService.postData(
                                  inputNama.text,
                                  inputNIM.text,
                                );
                                await _apiService.fetchData();
                                setState(() {
                                  _post = _apiService.post;
                                });
                                _showSnackbar('Data berhasil ditambahkan');
                                inputNama.clear();
                                inputNIM.clear();
                              } catch (e) {
                                _showSnackbar('Error: $e');
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text("Kirim Data"),
                          )
                        :
                          // Button update data
                          ElevatedButton(
                            onPressed: () async {
                              if (inputNama.text.isEmpty ||
                                  inputNIM.text.isEmpty) {
                                _showSnackbar(
                                  'Nama dan NIM tidak boleh kosong',
                                );
                                return;
                              }
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                await _apiService.updateData(
                                  idPutData ?? "",
                                  inputNama.text,
                                  inputNIM.text,
                                );
                                await _apiService.fetchData();
                                setState(() {
                                  _post = _apiService.post;
                                  idPutData = "";
                                });
                                _showSnackbar('Data berhasil diperbarui');
                                inputNama.clear();
                                inputNIM.clear();
                              } catch (e) {
                                _showSnackbar('Error: $e');
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              "Update Data",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ),
                  SizedBox(width: 12),
                  // Button get data
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        await _apiService.fetchData();
                        setState(() {
                          _post = _apiService.post;
                        });
                        _showSnackbar('Data telah berhasil diambil');
                      } catch (e) {
                        _showSnackbar('Error: $e');
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                    ),
                    child: Text("GET", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),

              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 8),

              // List Data
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _post.isEmpty
                  ? Center(
                      child: Text(
                        "Tekan tombol GET untuk mengambil data",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _post.length,
                        itemBuilder: (context, index) {
                          final item = _post[index];
                          final name = item["name"] ?? "N/A";
                          final nim = item["nim"] ?? "N/A";

                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.only(bottom: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  // Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          nim,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Tombol Aksi
                                  Row(
                                    children: [
                                      // Button untuk ke mode edit
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            idPutData =
                                                item["id"]?.toString() ?? "";
                                          });
                                          inputNama.text = name;
                                          inputNIM.text = nim;
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                      // Button untuk delete data
                                      IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          try {
                                            await _apiService.deleteData(
                                              item["id"]?.toString() ?? "",
                                            );
                                            await _apiService.fetchData();
                                            setState(() {
                                              _post = _apiService.post;
                                            });
                                            _showSnackbar(
                                              'Data berhasil dihapus',
                                            );
                                          } catch (e) {
                                            _showSnackbar('Error: $e');
                                          } finally {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
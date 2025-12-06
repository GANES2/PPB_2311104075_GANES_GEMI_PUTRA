import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> Connection() async {
  await Supabase.initialize(
    url: 'https://iybtovtitcxaonucptbc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml5YnRvdnRpdGN4YW9udWNwdGJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2NDk5MjYsImV4cCI6MjA3OTIyNTkyNn0.lw_AwdETTzBXm-pPEDfssnV4ihx_8JdB31x7D6Crt0M',
  );
}

final db = Supabase.instance.client;
String table = 'public';

// INSERT
Future<void> insertData(Map<String, dynamic> row) async {
  try {
    await db.from(table).insert(row);
    print("Data berhasil dikirim");
  } catch (e) {
    print(e);
  }
}

// READ
Future<List> getData() async {
  final response = await db.from(table).select();
  print(response.toList());
  return response;
}

// UPDATE
Future<void> updateData(Map<String, dynamic> row) async {
  try {
    await db.from(table).update(row).eq('id', row['id']);
  } catch (e) {
    print(e);
  }
}

// DELETE
Future<void> deleteData(int id) async {
  try {
    await db.from(table).delete().eq('id', id);
  } catch (e) {
    print(e);
  }
}
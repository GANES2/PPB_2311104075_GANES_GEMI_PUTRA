import 'package:get/get.dart';
import '../models/note_model.dart';

class NoteController extends GetxController {
  // List catatan yang reaktif
  final RxList<Note> notes = <Note>[].obs;

  // Tambah catatan baru
  void addNote({
    required String title,
    required String description,
  }) {
    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );

    notes.add(note);
  }

  // Hapus catatan berdasarkan id
  void removeNoteById(int id) {
    notes.removeWhere((note) => note.id == id);
  }
}

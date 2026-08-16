import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class Note {
  final supa = Supabase.instance.client;
  void create(String title, String content, String? image_path) async {
    await supa.from('notes').insert({
      'title': title,
      'content': content,
      'image_path': image_path,
    });
  }

  Future<List<Map<String, dynamic>>> read() async {
    return supa.from('notes').select();
  }

  void update(
    String id,
    String title,
    String content,
    String? image_path,
  ) async {
    await supa
        .from('notes')
        .update({'title': title, 'content': content, 'image_path': image_path})
        .eq('id', id);
  }

  Future<void> delete(String id) async {
    print('delete');
    await supa.from('notes').delete().eq('id', id);
  }

  Future<String> uploadImage(File file) async {
    String uuid = Uuid().v4();
    String ext = file.path.split('.').last;
    final path = 'public/$uuid.$ext';
    final res = supa.storage.from('notes').update(path, file);
    return path;
  }

  String getImageUrl(String imagePath) {
    return supa.storage.from('notes').getPublicUrl(imagePath);
  }
}

import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  late SupabaseClient supabase;

  Future<void> initialize() async {
    await Supabase.initialize(
        url: 'https://cpfwppzdycqcoggvhzms.supabase.co',
        anonKey:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNwZndwcHpkeWNxY29nZ3Zoem1zIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYwODQ2NTAsImV4cCI6MjA1MTY2MDY1MH0.11_IUxyGaOXRfBB_AjeHmd29cST6-f6aFq02vcPSLQE');
    supabase = Supabase.instance.client;
  }

  /// Uploads a file to the specified storage bucket and returns the public URL
  Future<String?> uploadFile({
    required String bucketName,
    required String filePath,
    required String fileName,
  }) async {
    try {
      final file = File(filePath);

      // Upload the file
      final filePathInBucket =
          await supabase.storage.from(bucketName).upload(fileName, file);

      // Generate the public URL
      final publicUrl =
          supabase.storage.from(bucketName).getPublicUrl(filePathInBucket);

      return publicUrl;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }
}

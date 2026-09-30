import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'package:order_rider/data/models/user_profile.dart';
import 'package:order_rider/data/local/database.dart';

class AuthRepository {
  final AppDatabase _db;
  final SupabaseClient? _supabase;

  AuthRepository(this._db, this._supabase);

  Future<UserProfile> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final id = const Uuid().v4();

    await _db.into(_db.users).insert(
          UsersCompanion.insert(
            id: id,
            name: name,
            email: Value(email),
          ),
        );

    if (_supabase != null) {
      try {
        await _supabase.auth.signUp(email: email, password: password);
        await _supabase.from('profiles').insert({
          'id': id,
          'name': name,
          'email': email,
        });
      } catch (_) {}
    }

    return UserProfile(id: id, name: name, email: email);
  }

  Future<UserProfile?> login({
    required String email,
    required String password,
  }) async {
    final local = await (_db.select(_db.users)
          ..where((t) => t.email.equals(email)))
        .getSingleOrNull();

    if (local != null) {
      return UserProfile(
        id: local.id,
        name: local.name,
        email: local.email,
        phone: local.phone,
        avatarPath: local.avatarPath,
        carNumber: local.carNumber,
        carType: local.carType,
        fuelType: local.fuelType,
        fuelEfficiency: local.fuelEfficiency,
        fuelPrice: local.fuelPrice,
        currency: local.currency,
      );
    }

    if (_supabase != null) {
      try {
        final res = await _supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
        if (res.user != null) {
          final profile = await _supabase
              .from('profiles')
              .select()
              .eq('id', res.user!.id)
              .single();
          return UserProfile.fromJson(profile);
        }
      } catch (_) {}
    }
    return null;
  }

  Future<void> logout() async {
    if (_supabase != null) await _supabase.auth.signOut();
  }

  Future<void> updateProfile(UserProfile profile) async {
    await (_db.update(_db.users)..where((t) => t.id.equals(profile.id)))
        .write(
      UsersCompanion(
        name: Value(profile.name),
        email: Value(profile.email),
        phone: Value(profile.phone),
        avatarPath: Value(profile.avatarPath),
        carNumber: Value(profile.carNumber),
        carType: Value(profile.carType),
        fuelType: Value(profile.fuelType),
        fuelEfficiency: Value(profile.fuelEfficiency),
        fuelPrice: Value(profile.fuelPrice),
        currency: Value(profile.currency),
      ),
    );

    if (_supabase != null) {
      try {
        await _supabase.from('profiles').upsert(profile.toJson());
      } catch (_) {}
    }
  }
}

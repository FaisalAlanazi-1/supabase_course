import 'package:supabase_flutter/supabase_flutter.dart';

class Authsupa {
  final supaAuth = Supabase.instance.client.auth ; 

  Future < void> signUp(String email , String pass) async{ 
  await  supaAuth.signUp(password: pass , email: email) ; 
  }
   Future < void> logIn(String email , String pass) async{ 
  await  supaAuth.signInWithPassword(password: pass , email: email) ; 
  }
  Future < void> logOut() async{ 
  await  supaAuth.signOut();
  }
}

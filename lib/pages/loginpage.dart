import 'package:flutter/material.dart';
import 'package:tugas1/utils/auth_logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // PERBAIKAN: Namanya disesuaikan jadi usernameController agar sinkron dengan AuthLogic
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // UX: Turunkan keyboard saat proses login berjalan
      FocusScope.of(context).unfocus();

      bool isSuccess = AuthLogic.login(_usernameController.text, _passwordController.text);

      if (isSuccess) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Username atau Password salah!"),
            // Gunakan warna error dari skema Material 3, bukan hardcode merah
            backgroundColor: Theme.of(context).colorScheme.error, 
            behavior: SnackBarBehavior.floating, // Snackbar modern tidak nempel di bawah
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Warna background sudah otomatis mengikuti tema di main.dart
      body: Center(
        child: SingleChildScrollView( // Mencegah overflow saat keyboard muncul
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400), // Agar tidak jelek kalau dibuka di tablet/web
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch, // Bikin tombol melebar penuh
                children: [
                  Icon(
                    Icons.lock_person_rounded, 
                    size: 80, 
                    color: Theme.of(context).colorScheme.primary, // Ambil biru dari tema
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Selamat Datang", 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Silakan login untuk melanjutkan tugas kelompok",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Perhatikan betapa bersihnya input ini karena styling-nya 
                  // sudah diambil alih oleh ThemeData di main.dart
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next, // UX: Tombol 'Next' di keyboard
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: "Username",
                    ),
                    validator: (value) => value == null || value.trim().isEmpty 
                        ? "Username tidak boleh kosong" 
                        : null,
                  ),
                  const SizedBox(height: 16),
                  
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    textInputAction: TextInputAction.done, // UX: Tombol 'Done' di keyboard
                    onFieldSubmitted: (_) => _login(), // Bisa enter untuk login
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: "Password",
                    ),
                    validator: (value) => value == null || value.trim().isEmpty 
                        ? "Password tidak boleh kosong" 
                        : null,
                  ),
                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: _login,
                    child: const Text("MASUK"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
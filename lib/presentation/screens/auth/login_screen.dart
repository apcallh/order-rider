import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order_rider/app/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _k = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _load = false;
  bool _ob = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _k,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/images/app_icon.png',
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.primaryBlue,
                          child: const Icon(Icons.local_shipping,
                              color: Colors.white, size: 50),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'مرحباً بعودتك',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'سجل دخولك لمتابعة عملك',
                  style: TextStyle(color: AppColors.textSecondaryDark),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (v) => v == null || !v.contains('@')
                      ? 'أدخل بريداً صحيحاً'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _pass,
                  obscureText: _ob,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon:
                          Icon(_ob ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _ob = !_ob),
                    ),
                  ),
                  validator: (v) => v == null || v.length < 6
                      ? 'كلمة المرور قصيرة'
                      : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _load
                      ? null
                      : () async {
                          if (!_k.currentState!.validate()) return;
                          setState(() => _load = true);
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          if (mounted) context.go('/dashboard');
                        },
                  child: _load
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('تسجيل الدخول'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ليس لديك حساب؟',
                        style: TextStyle(color: AppColors.textSecondaryDark)),
                    TextButton(
                      onPressed: () => context.go('/register'),
                      child: const Text('إنشاء حساب'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

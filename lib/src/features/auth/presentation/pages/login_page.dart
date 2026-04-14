import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:clean_arch_base/src/core/di/injection_container.dart';
import 'package:clean_arch_base/src/core/router/app_route_paths.dart';
import 'package:clean_arch_base/src/core/theme/app_colors.dart';
import 'package:clean_arch_base/src/core/theme/app_text_styles.dart';
import 'package:clean_arch_base/src/features/auth/presentation/bloc/login_bloc.dart';
import 'package:clean_arch_base/src/features/auth/presentation/bloc/login_event.dart';
import 'package:clean_arch_base/src/features/auth/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: 'emilys');
    _passwordController = TextEditingController(text: 'emilyspass');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => sl<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.appTitleLogin, style: context.h6),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) {
            if (state.status == LoginStatus.success) {
              context.go(AppRoutePaths.products);
            }
          },
          builder: (BuildContext context, LoginState state) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          AppStrings.sampleCredentialsHint,
                          style: context.bodySm,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: AppStrings.username,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? AppStrings.username
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: AppStrings.password,
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? AppStrings.password
                              : null,
                        ),
                        const SizedBox(height: 16),
                        if (state.status == LoginStatus.failure)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              state.errorMessage,
                              style: context.bodyMd.copyWith(
                                color: AppColors.danger,
                              ),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: state.status == LoginStatus.loading
                              ? null
                              : () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    context.read<LoginBloc>().add(
                                      LoginSubmitted(
                                        username: _usernameController.text
                                            .trim(),
                                        password: _passwordController.text
                                            .trim(),
                                      ),
                                    );
                                  }
                                },
                          child: state.status == LoginStatus.loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(AppStrings.signIn),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

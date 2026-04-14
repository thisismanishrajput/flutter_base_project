import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:clean_arch_base/src/core/di/injection_container.dart';
import 'package:clean_arch_base/src/core/router/app_route_paths.dart';
import 'package:clean_arch_base/src/core/theme/app_colors.dart';
import 'package:clean_arch_base/src/core/theme/app_text_styles.dart';
import 'package:clean_arch_base/src/core/theme/theme_cubit.dart';
import 'package:clean_arch_base/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:clean_arch_base/src/features/products/presentation/bloc/product_bloc.dart';
import 'package:clean_arch_base/src/features/products/presentation/bloc/product_event.dart';
import 'package:clean_arch_base/src/features/products/presentation/bloc/product_state.dart';
import 'package:clean_arch_base/src/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => sl<ProductBloc>()..add(const FetchProducts()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.appTitleProducts, style: context.h6),
          actions: <Widget>[
            IconButton(
              tooltip: AppStrings.toggleTheme,
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              icon: Icon(
                context.watch<ThemeCubit>().state == ThemeMode.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
            ),
            IconButton(
              tooltip: AppStrings.logout,
              onPressed: () async {
                await sl<LogoutUsecase>().call();
                if (context.mounted) {
                  context.go(AppRoutePaths.login);
                }
              },
              icon: const Icon(Icons.logout_outlined),
            ),
            IconButton(
              onPressed: () => context.push(AppRoutePaths.settings),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (BuildContext context, ProductState state) {
            switch (state.status) {
              case ProductStatus.initial:
              case ProductStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ProductStatus.failure:
                return _ErrorView(message: state.errorMessage);
              case ProductStatus.success:
                if (state.products.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noProductsFound,
                      style: context.bodyMd,
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProductBloc>().add(const FetchProducts());
                  },
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(product: state.products[index]);
                    },
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.bodyMd.copyWith(color: AppColors.danger),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<ProductBloc>().add(const FetchProducts());
              },
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../themes/themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark30,
      appBar: AppBar(
        title: const Text(
          'Nileon',
          style: TextStyle(
            color: AppColors.dark10,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.dark10,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.dark10,
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 80,
              ),
              SizedBox(height: 24),
              Text(
                'Cadastro realizado com sucesso!',
                style: TextStyle(
                  color: AppColors.dark100,
                  fontSize: 24,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Bem-vindo ao Nileon!',
                style: TextStyle(
                  color: AppColors.dark80,
                  fontSize: 16,
                  fontFamily: 'Manrope',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mallika/gen/assets.gen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: Assets.images.imgLogin.image(
              fit: BoxFit.cover,
            ),
            expandedHeight: 250,
            bottom: PreferredSize(
              preferredSize: const Size(
                double.infinity,
                30,
              ),
              child: Container(
                width: double.infinity,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              Container(
                margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                child: const Text(
                  'Mallika',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

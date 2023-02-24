import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mallika/gen/assets.gen.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget buttonSubmit() {
      return Container(
        margin: const EdgeInsets.all(14),
        child: ElevatedButton(
          onPressed: () {
            context.pop();
          },
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Color(0xFFFF8527)),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16),
            ),
            shadowColor: const MaterialStatePropertyAll(null),
            elevation: const MaterialStatePropertyAll(0),
            foregroundColor: const MaterialStatePropertyAll(null),
            overlayColor: const MaterialStatePropertyAll(null),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: Text(
            'Submit',
            style: GoogleFonts.abel(fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: Assets.images.imgLogin.image(
              fit: BoxFit.cover,
            ),
            expandedHeight: 250,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
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
            delegate: SliverChildListDelegate([
              const SizedBox(height: 32),
              Text(
                'Enter Code!',
                style: GoogleFonts.abhayaLibre(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'We have send the OTP code to your SMS!',
                style: GoogleFonts.aBeeZee(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Pinput(
                controller: _pinController,
                mainAxisAlignment: MainAxisAlignment.center,
                length: 6,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  log('value is $value');
                },
                onCompleted: (value) {
                  log('value is $value');
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  textStyle: GoogleFonts.aBeeZee(
                    fontSize: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFFF8527),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              buttonSubmit(),
            ]),
          ),
        ],
      ),
    );
  }
}

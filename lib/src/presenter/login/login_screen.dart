import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mallika/gen/assets.gen.dart';
import 'package:mallika/src/data/models/country_code_model.dart';
import 'package:mallika/src/presenter/login/bloc/login_screen_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '';

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    context.read<LoginScreenBloc>().add(LoginScreenInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<LoginScreenBloc>().add(LoginScreenInitialEvent());
      Timer(const Duration(seconds: 3), () {
        final user = Supabase.instance.client.auth.currentSession;
        if (user != null) {
          context.pushReplacement('/main');
        }
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  Widget headerTitle() {
    return Container(
      margin: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Column(
        children: [
          Text(
            'Mallika',
            style: GoogleFonts.abhayaLibre(
              fontSize: 39,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Everyone can be a chef',
            style: GoogleFonts.aBeeZee(
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }

  Widget inputPhoneNumber(List<CountryCodeModel> countryCodes) {
    return Container(
      margin: const EdgeInsets.only(
        top: 24,
        right: 14,
        left: 14,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: const Color(0xFFE1E2E3),
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: DropdownSearch<String>(
              popupProps: PopupProps.bottomSheet(
                showSelectedItems: true,
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    labelText: 'Search country or code',
                    border: const OutlineInputBorder(),
                    hintStyle: GoogleFonts.aBeeZee(),
                  ),
                ),
                fit: FlexFit.loose,
              ),
              items: countryCodes.map((countryCode) {
                return "${countryCode.countryName} | +${countryCode.phoneCode}";
              }).toList(),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: 'Please choose country code',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.aBeeZee(),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedCountryCode = value.toString().split(' | ').last;
                });
              },
              selectedItem: _selectedCountryCode,
              autoValidateMode: AutovalidateMode.always,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Phone Number',
                border: InputBorder.none,
                hintStyle: GoogleFonts.aBeeZee(
                  color: const Color(0xFFB3B4BA),
                ),
              ),
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              style: GoogleFonts.aBeeZee(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonSendOTP() {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
      child: ElevatedButton(
        onPressed: () {
          if (_phoneController.text.isNotEmpty) {
            context.read<LoginScreenBloc>().add(
                  LoginScreenSendOTPEvent(
                    countryCode: _selectedCountryCode,
                    phoneNumber: _phoneController.text,
                  ),
                );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter phone number')),
            );
          }
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
          'Send OTP',
          style: GoogleFonts.abel(fontSize: 16),
        ),
      ),
    );
  }

  Widget dividerSocialButton() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 36,
        horizontal: 48,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                color: Color(0xFFB3B4BA),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'OR',
            style: GoogleFonts.aBeeZee(
              color: const Color(0xFFB3B4BA),
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 1,
              decoration: const BoxDecoration(
                color: Color(0xFFB3B4BA),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget socialSignInAppleButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE1E2E3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Assets.images.icApple.image(
                width: 36,
                height: 36,
              ),
              Expanded(
                child: Text(
                  'Continue with Apple',
                  style: GoogleFonts.aBeeZee(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget socialSignInGoogleButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: () {
          context.read<LoginScreenBloc>().add(LoginScreenSignInGoogleEvent());
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFE1E2E3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Assets.images.icGoogle.image(
                width: 36,
                height: 36,
              ),
              Expanded(
                child: Text(
                  'Continue with Google',
                  style: GoogleFonts.aBeeZee(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget termsCondition() {
    return Container(
      margin: const EdgeInsets.only(
        top: 36,
        left: 14,
        right: 14,
        bottom: 48,
      ),
      child: Column(
        children: [
          Text(
            'By continuing, you agree to our',
            style: GoogleFonts.aBeeZee(
              fontSize: 14,
            ),
          ),
          Text(
            'Terms of Service · Privacy Policy · Content Policy',
            style: GoogleFonts.aBeeZee(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginScreenBloc, LoginScreenState>(
      listener: (context, state) {
        if (state is LoginScreenStandBy) {
          setState(() {
            _selectedCountryCode = "+${state.countryCodes.first.phoneCode}";
          });
        } else if (state is LoginScreenSuccessSendOTP) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP is sended')),
          );
          context.push('/otp');
        } else if (state is LoginScreenSuccessSocialSignIn) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Success')),
          );
        } else if (state is LoginScreenFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
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
                  headerTitle(),
                  if (state is LoginScreenStandBy) ...[
                    inputPhoneNumber(state.countryCodes),
                  ],
                  buttonSendOTP(),
                  dividerSocialButton(),
                  if (Platform.isIOS) ...[
                    socialSignInAppleButton(),
                    const SizedBox(height: 14),
                  ],
                  socialSignInGoogleButton(),
                  termsCondition(),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}

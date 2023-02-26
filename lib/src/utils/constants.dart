import 'package:mallika/gen/assets.gen.dart';
import 'package:mallika/src/data/models/onboarding_model.dart';

const String prefFirstLaunch = "FIRST_LAUNCH";
List<OnboardingModel> defaultOnboardingModel = [
  OnboardingModel(
    title: 'Make recipes your own',
    description:
        'With Mallika recipe editor, you can easily edit recipes, save adju,stments to ingredients, and add additional steps or tips to your preparation.',
    imagePath: Assets.images.imgOnboarding1.path,
  ),
  OnboardingModel(
    title: 'All in one place',
    description:
        'Storing your recipes in Mallika allows you to quickly search, find, and select what you want to cook.',
    imagePath: Assets.images.imgOnboarding2.path,
  ),
  OnboardingModel(
    title: 'Cook from your favorite device',
    description:
        'Mallika stores your recipes in the Cloud so you can access them on any device through our website or Android/iOS app.',
    imagePath: Assets.images.imgOnboarding3.path,
  )
];

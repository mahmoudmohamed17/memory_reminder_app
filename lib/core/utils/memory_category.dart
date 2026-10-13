import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_strings.dart';

enum MemoryCategory {
  medical(
    icon: Icons.medical_services_outlined,
    label: AppStrings.categoriesMedical,
    categoryColors: AppCategoryColors.medical,
  ),
  financial(
    icon: Icons.attach_money_outlined,
    label: AppStrings.categoriesFinancial,
    categoryColors: AppCategoryColors.financial,
  ),
  family(
    icon: Icons.family_restroom,
    label: AppStrings.categoriesFamily,
    categoryColors: AppCategoryColors.family,
  ),
  friends(
    icon: Icons.people_outline,
    label: AppStrings.categoriesFriends,
    categoryColors: AppCategoryColors.friends,
  ),
  personal(
    icon: Icons.person_outline,
    label: AppStrings.categoriesPersonal,
    categoryColors: AppCategoryColors.personal,
  ),
  other(
    icon: Icons.other_houses_outlined,
    label: AppStrings.categoriesOther,
    categoryColors: AppCategoryColors.other,
  );

  const MemoryCategory({required this.icon, required this.label, required this.categoryColors});

  /// The icon that visually represents this category.
  final IconData icon;

  /// Human-readable display name (e.g. for chips / pickers).
  final String label;

  /// The semantic colors associated with this category.
  final AppCategoryColors categoryColors;

  
}

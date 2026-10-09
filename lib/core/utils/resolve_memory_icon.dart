import 'package:flutter/material.dart';

import '../../features/home/domain/models/memory_item_model.dart';

IconData resolveMemoryIcon(MemoryCategory category) {
  switch (category) {
    case MemoryCategory.medical:
      return Icons.medical_services_outlined;
    case MemoryCategory.financial:
      return Icons.attach_money_outlined;
    case MemoryCategory.family:
      return Icons.family_restroom;
    case MemoryCategory.friends:
      return Icons.people_outline;
    case MemoryCategory.personal:
      return Icons.person_outline;
    case MemoryCategory.other:
      return Icons.other_houses_outlined;
  }
}
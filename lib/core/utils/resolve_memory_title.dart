import '../../features/home/domain/models/memory_item_model.dart';
import 'app_strings.dart';

String resolveMemoryTitle(MemoryCategory c) {
  switch (c) {
    case MemoryCategory.medical:
      return AppStrings.categoriesMedical;
    case MemoryCategory.financial:
      return AppStrings.categoriesFinancial;
    case MemoryCategory.family:
      return AppStrings.categoriesFamily;
    case MemoryCategory.friends:
      return AppStrings.categoriesFriends;
    case MemoryCategory.personal:
      return AppStrings.categoriesPersonal;
    case MemoryCategory.other:
      return AppStrings.categoriesOther;
  }
}

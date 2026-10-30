import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../cubits/add_memory_cubit.dart';
import '../wigdets/greeting_widget.dart';
import '../wigdets/home_header.dart';
import '../wigdets/home_search_field.dart';
import '../wigdets/memories_list.dart';
import '../wigdets/memory_creation_bottom_sheet.dart';
import '../wigdets/voice_searching_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            spacing: 10.h,
            children: [
              const HomeHeader(),
              Expanded(
                child: ListView(
                  children: [
                    16.verticalSpace,
                    const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: GreetingWidget(),
                    ),
                    16.verticalSpace,
                    const HomeSearchField(),
                    16.verticalSpace,
                    const VoiceSearchingButton(),
                    16.verticalSpace,
                    const MemoriesList(),
                    64.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (_) => BlocProvider(
              create: (_) => getIt<AddMemoryCubit>(),
              child: const MemoryCreationBottomSheet(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

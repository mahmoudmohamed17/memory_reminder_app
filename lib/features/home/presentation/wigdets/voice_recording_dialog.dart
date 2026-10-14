import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waveform_flutter/waveform_flutter.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/extensions.dart';

class VoiceRecordingDialog extends StatefulWidget {
  const VoiceRecordingDialog({super.key});

  @override
  State<VoiceRecordingDialog> createState() => _VoiceRecordingDialogState();
}

class _VoiceRecordingDialogState extends State<VoiceRecordingDialog> {
  final Stream<Amplitude> _stream = createRandomAmplitudeStream();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 18.h,
          children: [
            _header(context),
            _button(context),
            SizedBox(
              height: 46.h,
              child: AnimatedWaveList(
                stream: _stream,
                barBuilder: (animation, amplitude) {
                  return WaveFormBar(
                    amplitude: amplitude,
                    animation: animation,
                    color: context.colorScheme.primary,
                  );
                },
              ),
            ),
            Text(
              context.tr(AppStrings.voiceListening),
              style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6,
          children: [
            Icon(
              Icons.lock,
              size: 12,
              color: context.colorScheme.secondary,
            ),
            Text(
              context.tr(AppStrings.secureLocal),
              style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.secondary),
            ),
          ],
        ),
        8.verticalSpace,
        Text(
          context.tr(AppStrings.voiceTitle),
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        Text(
          context.tr(AppStrings.voiceDescription),
          style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.outline),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 84.r,
          backgroundColor: context.colorScheme.primary.withValues(alpha: 0.10),
        ),
        CircleAvatar(
          radius: 64.r,
          backgroundColor: context.colorScheme.primary.withValues(alpha: 0.25),
        ),
        CircleAvatar(
          radius: 48.r,
          backgroundColor: context.colorScheme.primary,
          child: Icon(
            Icons.mic,
            color: context.colorScheme.onPrimary,
            size: 48.sp,
          ),
        ),
      ],
    );
  }
}

Stream<Amplitude> createRandomAmplitudeStream() {
  return Stream.periodic(
    const Duration(milliseconds: 70),
    (count) => Amplitude(
      current: Random().nextDouble() * 100,
      max: 100,
    ),
  );
}

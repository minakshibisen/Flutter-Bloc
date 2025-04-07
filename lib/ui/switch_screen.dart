import 'package:bloc_flutter/bloc/switch/switch_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Switch Screen',
          style: Theme
              .of(context)
              .textTheme
              .headlineLarge,
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notification',
              ),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Switch(
                    value: state.isSwitch,
                    onChanged: (newValue) {
                      context.read<SwitchBloc>().add(EnableDisableNotification());
                    },
                  );
                },
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Container(
                    height: 200,
                   color: Colors.red.withOpacity(state.isSlider),
                  );
                },
              ),
              Text(
                'Slider',
              ),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Slider(
                    value: state.isSlider,
                    onChanged: (value) {
                      context.read<SwitchBloc>().add(SliderEvent(slider: value));
                    },
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/bloc/authentication_bloc.dart';
import '../../logs/bloc/logs_bloc.dart';
import '../../logs/view/logs_list.dart';
import '../../logs/widgets/swipe_detector.dart';
import '../../selector/cubit/selector_cubit.dart';
import '../../selector/view/selector_view.dart';
import '../cubit/home_cubit.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthenticationBloc(httpClient: http.Client())
            ..add(AuthenticationStatusChanged(
                AuthenticationStatus.authenticated)),
        ),
        BlocProvider(create: (_) => SelectorCubit()),
        BlocProvider(
            create: (context) => LogsBloc(
                httpClient: http.Client(),
                auth: context.read<AuthenticationBloc>(),
                dateSelector: context.read<SelectorCubit>())),
        BlocProvider(create: (_) => HomeCubit())
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      appBar: AppBar(title: Text('LogViewer Demo')),
      body: Column(
        children: [SelectorView(), Expanded(child: SwipeDetector())],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.home,
              icon: const Icon(Icons.home),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}

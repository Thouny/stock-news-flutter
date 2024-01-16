import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/features/user/presentation/blocs/greeting_bloc.dart';

class GreetingWidget extends StatelessWidget {
  static const keyPrefix = 'Greeting';

  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineSmall;
    return BlocBuilder<GreetingBloc, GreetingState>(
      builder: (context, state) {
        if (state is LoadedGreetingState) {
          return Text(
            key: const Key('$keyPrefix-Text'),
            state.greeting,
            style: textStyle,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

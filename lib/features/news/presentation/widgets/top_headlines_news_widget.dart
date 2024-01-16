import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/core/utils/link_handler.dart';
import 'package:stock_news_flutter/features/news/presentation/bloc/news_bloc.dart';

class TopHealinesNewsWidget extends StatelessWidget {
  static const keyPrefix = 'TopHeadlinesNews';

  final LinkHandler linkHandler;

  const TopHealinesNewsWidget({
    super.key,
    required this.linkHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key(TopHealinesNewsWidget.keyPrefix),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Headlines News',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Expanded(
          child: _TopHeadlinesNewsListView(linkHandler: linkHandler),
        ),
      ],
    );
  }
}

class _TopHeadlinesNewsListView extends StatelessWidget {
  final LinkHandler linkHandler;

  const _TopHeadlinesNewsListView({required this.linkHandler});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is LoadedNewsState) {
          return ListView.separated(
            key: const Key('${TopHealinesNewsWidget.keyPrefix}-ListView'),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: state.news.length,
            itemBuilder: (context, index) {
              final news = state.news[index];
              return ListTile(
                title: Text(news.source.name),
                subtitle: Text(news.title),
                trailing: _buildImage(news.urlToImage),
                onTap: () {
                  if (news.url.isEmpty) return;
                  linkHandler.openLink(news.url, context);
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 1, color: Colors.grey);
            },
          );
        } else if (state is ErrorNewsState) {
          return Center(
            child: Text(
              state.message,
              key: const Key('${TopHealinesNewsWidget.keyPrefix}-ErrorText'),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              key: Key('${TopHealinesNewsWidget.keyPrefix}-LoadingIndicator'),
            ),
          );
        }
      },
    );
  }

  Widget _buildImage(String imageUrl) {
    return Container(
      height: 70,
      width: 70,
      color: Colors.grey,
      child: imageUrl.isNotEmpty
          ? Image.network(imageUrl, fit: BoxFit.cover)
          : null,
    );
  }
}

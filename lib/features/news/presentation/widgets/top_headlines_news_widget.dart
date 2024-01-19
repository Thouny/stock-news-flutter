import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_news_flutter/core/theme/border_radius.dart';
import 'package:stock_news_flutter/core/theme/colors.dart';
import 'package:stock_news_flutter/core/theme/padding.dart';
import 'package:stock_news_flutter/core/utils/link_handler.dart';
import 'package:stock_news_flutter/core/utils/responsive_utils.dart';
import 'package:stock_news_flutter/features/news/domain/entities/news_entity.dart';
import 'package:stock_news_flutter/features/news/presentation/bloc/news_bloc.dart';

class TopHealinesNewsWidget extends StatelessWidget {
  static const keyPrefix = 'TopHeadlinesNews';

  final LinkHandler linkHandler;

  const TopHealinesNewsWidget({super.key, required this.linkHandler});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key(TopHealinesNewsWidget.keyPrefix),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's news",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: PaddingValues.small),
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
          return GridView.builder(
            key: const Key('${TopHealinesNewsWidget.keyPrefix}-GridView'),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveUtils.isIpad ? 2 : 1,
              crossAxisSpacing: PaddingValues.xSmall,
              mainAxisSpacing: PaddingValues.xSmall,
            ),
            itemCount: state.news.length,
            itemBuilder: (context, index) {
              final news = state.news[index];
              return _NewsCard(
                news: news,
                onTap: () {
                  if (news.url.isEmpty) return;
                  linkHandler.openLink(news.url);
                },
              );
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
}

class _NewsCard extends StatelessWidget {
  final NewsEntity news;
  final VoidCallback? onTap;

  const _NewsCard({super.key, required this.news, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(BorderRadiusValues.mediumBorderRadius),
                ),
                color: SNColors.grey.shade500,
              ),
              height: 120,
              child: news.urlToImage.isNotEmpty
                  ? Image.network(news.urlToImage, fit: BoxFit.fitWidth)
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(PaddingValues.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news.source.name),
                  const SizedBox(height: PaddingValues.xxSmall),
                  Text(
                    news.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

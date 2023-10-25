import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/color_scheme.dart';
import 'package:flutter_template/assets/text/text_extention.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen_widget_model.dart';
import 'package:flutter_template/features/photos/widgets/photos_grid.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';
import 'package:union_state/union_state.dart';

/// Main widget for PhotosScreen feature.
@RoutePage(
  name: AppRouteNames.photosScreen,
)
class PhotosScreen extends ElementaryWidget<IPhotosScreenWidgetModel> {
  /// Create an instance [PhotosScreen].
  const PhotosScreen({
    Key? key,
    WidgetModelFactory wmFactory = photosScreenWmFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPhotosScreenWidgetModel wm) {
    return Scaffold(
      body: UnionStateListenableBuilder<List<PhotosModel>>(
        unionStateListenable: wm.dataState,
        builder: (context, data) {
          return CustomScrollView(
            slivers: [
              const _PhotosAppBar(),
              PhotosGrid(data),
            ],
          );
        },
        loadingBuilder: (_, lastData) => _LoadingBuilderView(lastData),
        failureBuilder: (context, exception, lastData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(exception.toString()),
                ),
              );
          });
          return CustomScrollView(
            physics:
                lastData != null ? null : const NeverScrollableScrollPhysics(),
            slivers: [
              const _PhotosAppBar(),
              PhotosGrid(lastData),
            ],
          );
        },
      ),
    );
  }
}

class _LoadingBuilderView extends StatelessWidget {
  const _LoadingBuilderView(this.lastData);

  final List<PhotosModel>? lastData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomScrollView(
        slivers: [
          const _PhotosAppBar(),
          PhotosGrid(lastData),
          SliverFillRemaining(
            child: lastData != null && lastData!.isNotEmpty
                ? const SizedBox(
                    height: 80,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _PhotosAppBar extends StatelessWidget {
  const _PhotosAppBar();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SliverAppBar(
      pinned: true,
      expandedHeight: mediaQuery.size.height * 0.1,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxHeight = constraints.biggest.height;
              final isNotExpanded =
                  maxHeight == mediaQuery.padding.top + kToolbarHeight;

              return _FlexibleSpaceBar(isNotExpanded: isNotExpanded);
            },
          ),
        ),
      ),
    );
  }
}

class _FlexibleSpaceBar extends StatelessWidget {
  const _FlexibleSpaceBar({required this.isNotExpanded});

  final bool isNotExpanded;

  @override
  Widget build(BuildContext context) {
    final scheme = AppColorScheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return FlexibleSpaceBar(
      centerTitle: isNotExpanded,
      expandedTitleScale: 1.2,
      titlePadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      title: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment:
            isNotExpanded ? Alignment.bottomCenter : Alignment.bottomLeft,
        child: Text(
          context.l10n.photosScreenTitle,
          style: textTheme.bold20.copyWith(
            color: scheme.onBackground,
          ),
        ),
      ),
    );
  }
}

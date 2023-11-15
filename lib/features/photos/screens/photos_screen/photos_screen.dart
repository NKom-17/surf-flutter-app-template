import 'dart:io';
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
import 'package:flutter_template/util/evn/test_environment_detector.dart';
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
        builder: (_, data) {
          return _BuilderView(
            data,
            scrollController: wm.scrollController,
            openDetailsPhoto: wm.openDetailsPhoto,
          );
        },
        loadingBuilder: (_, lastData) {
          return _BuilderView(
            lastData,
            scrollController: wm.scrollController,
            openDetailsPhoto: wm.openDetailsPhoto,
            isLoadingBuilder: true,
          );
        },
        failureBuilder: (_, exception, lastData) {
          return _BuilderView(
            lastData,
            scrollController: wm.scrollController,
            openDetailsPhoto: wm.openDetailsPhoto,
            isFailureBuilder: true,
            exception: exception,
          );
        },
      ),
    );
  }
}

class _BuilderView extends StatelessWidget {
  const _BuilderView(
    this.data, {
    required this.scrollController,
    required this.openDetailsPhoto,
    this.isLoadingBuilder = false,
    this.isFailureBuilder = false,
    this.exception,
  });

  final List<PhotosModel>? data;
  final ScrollController scrollController;
  final void Function(PhotosModel model) openDetailsPhoto;
  final bool isLoadingBuilder;
  final bool isFailureBuilder;
  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    final hasData = data != null && data!.isNotEmpty;

    return isFailureBuilder && !hasData
        ? Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                exception == null
                    ? context.l10n.unknownErrorMessage
                    : exception is SocketException
                        ? context.l10n.networkErrorMessage
                        : exception.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : CustomScrollView(
            controller: scrollController,
            physics: hasData ? null : const NeverScrollableScrollPhysics(),
            slivers: [
              const _PhotosAppBar(),
              if (!isLoadingBuilder && !isFailureBuilder && data!.isEmpty)
                const _EmptyPhotosListWidget()
              else
                PhotosGrid(data, openDetailsPhoto),
              if (isLoadingBuilder) _LoadingIndicator(hasData: hasData)
            ],
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
              final isNotExpanded = maxHeight == mediaQuery.padding.top + kToolbarHeight;

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
        alignment: isNotExpanded ? Alignment.bottomCenter : Alignment.bottomLeft,
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

class _LoadingIndicator extends StatefulWidget {
  const _LoadingIndicator({required this.hasData});

  final bool hasData;

  @override
  State<_LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<_LoadingIndicator> {
  late final bool isTestEnv;

  @override
  void initState() {
    super.initState();
    isTestEnv = TestEnvironmentDetector.isTestEnvironment;
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: widget.hasData
          ? SizedBox(
              height: 80,
              child: Center(
                child: CircularProgressIndicator(value: isTestEnv ? 0.7 : null),
              ),
            )
          : Center(
              child: CircularProgressIndicator(value: isTestEnv ? 0.7 : null),
            ),
    );
  }
}

class _EmptyPhotosListWidget extends StatelessWidget {
  const _EmptyPhotosListWidget();

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.of(context);

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Text(
          context.l10n.emptyPhotosListText,
          style: textTheme.medium16,
        ),
      ),
    );
  }
}

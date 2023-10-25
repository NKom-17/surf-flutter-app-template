// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    PhotosRouter.name: (routeData) {
      final args = routeData.argsAs<PhotosRouterArgs>(orElse: () => const PhotosRouterArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PhotosScreen(
          key: args.key,
          wmFactory: args.wmFactory,
        ),
      );
    }
  };
}

/// generated route for
/// [PhotosScreen]
class PhotosRouter extends PageRouteInfo<PhotosRouterArgs> {
  PhotosRouter({
    Key? key,
    WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(BuildContext) wmFactory =
        photosScreenWmFactory,
    List<PageRouteInfo>? children,
  }) : super(
          PhotosRouter.name,
          args: PhotosRouterArgs(
            key: key,
            wmFactory: wmFactory,
          ),
          initialChildren: children,
        );

  static const String name = 'PhotosRouter';

  static const PageInfo<PhotosRouterArgs> page = PageInfo<PhotosRouterArgs>(name);
}

class PhotosRouterArgs {
  const PhotosRouterArgs({
    this.key,
    this.wmFactory = photosScreenWmFactory,
  });

  final Key? key;

  final WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(BuildContext)
      wmFactory;

  @override
  String toString() {
    return 'PhotosRouterArgs{key: $key, wmFactory: $wmFactory}';
  }
}

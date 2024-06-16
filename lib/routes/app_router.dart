import 'package:auto_route/auto_route.dart';
import 'package:dart_plus_app/presentation/view/home_page.dart';
import 'package:flutter/cupertino.dart';

import '../domain/interfaces/models/media.dart';
import '../presentation/view/catalogo_page.dart';
import '../presentation/view/details_page.dart';
import '../presentation/view/favorites_page.dart';
import '../presentation/view/login_page.dart';
import '../presentation/view/register_page.dart';
import '../presentation/view/see_all_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MyHomeRoute.page,),
        AutoRoute(page: SeeAllRoute.page),
        AutoRoute(page: DetailsRoute.page),
        AutoRoute(page: CatalogoRoute.page),
        AutoRoute(page: FavoritesRoute.page),
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: RegisterRoute.page),
      ];
}

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/app/core/data/remote/service/product_serivce.dart';
import 'package:ecommerce/app/core/data/repository/session_repository_impl.dart';
import 'package:ecommerce/app/core/domain/repository/session_repository.dart';
import 'package:ecommerce/app/core/domain/use_case/logout_use_case.dart';
import 'package:ecommerce/app/form_product/data/repository/form_product_repository_impl.dart';
import 'package:ecommerce/app/form_product/domain/repository/form_product_repository.dart';
import 'package:ecommerce/app/form_product/domain/use_case/add_product_use_case.dart';
import 'package:ecommerce/app/form_product/domain/use_case/update_product_use_case.dart';
import 'package:ecommerce/app/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:ecommerce/app/home/data/repository/home_repository_implementation.dart';
import 'package:ecommerce/app/home/domain/repository/home_repository.dart';
import 'package:ecommerce/app/home/domain/use_case/delete_product_use_case.dart';
import 'package:ecommerce/app/home/domain/use_case/get_products_use_case.dart';
import 'package:ecommerce/app/home/presentation/bloc/home_bloc.dart';
import 'package:ecommerce/app/login/data/repository/login_repository_impl.dart';
import 'package:ecommerce/app/login/domain/repository/login_repository.dart';
import 'package:ecommerce/app/login/domain/use_case/login_usecase.dart';
import 'package:ecommerce/app/login/presentation/bloc/login_bloc.dart';

final class DependencyInjection {
  DependencyInjection._();

  static final serviceLocator = GetIt.instance;

  static setup() {
    serviceLocator.registerSingleton<Dio>(Dio());
    serviceLocator.registerFactory<ProductService>(
        () => ProductService(dio: serviceLocator.get()));
    serviceLocator
        .registerFactory<SessionRepository>(() => SessionRepositoryImp());
    serviceLocator.registerFactory<LogoutUseCase>(
        () => LogoutUseCase(sessionRepository: serviceLocator.get()));

    serviceLocator.registerFactory<LoginRepository>(() => LoginRepositoryImp());
    serviceLocator.registerFactory(
        () => LoginUseCase(loginRepository: serviceLocator.get()));
    serviceLocator.registerFactory<LoginBloc>(
        () => LoginBloc(serviceLocator.get<FirebaseAuth>()));
    serviceLocator.registerFactory<HomeRepository>(() =>
        HomeRepositoryImplementation(productService: serviceLocator.get()));

    serviceLocator.registerFactory<GetProductsUseCase>(
        () => GetProductsUseCase(homeRepository: serviceLocator.get()));
    serviceLocator.registerFactory<DeleteProductsUseCase>(
        () => DeleteProductsUseCase(homeRepository: serviceLocator.get()));
    serviceLocator.registerFactory<HomeBloc>(() => HomeBloc(
        getProductsUseCase: serviceLocator.get(),
        deleteProductsUseCase: serviceLocator.get(),
        logoutUseCase: serviceLocator.get()));

    serviceLocator.registerFactory<FormProductRepository>(
        () => FormProductRepositoryImpl(productService: serviceLocator.get()));
    serviceLocator.registerFactory<AddProductUseCase>(
        () => AddProductUseCase(formProductRepository: serviceLocator.get()));
    serviceLocator.registerFactory<UpdateProductUseCase>(() =>
        UpdateProductUseCase(formProductRepository: serviceLocator.get()));
    serviceLocator.registerFactory<FormProductBloc>(() => FormProductBloc(
        addProductUseCase: serviceLocator.get(),
        updateProductUseCase: serviceLocator.get()));

    // Register FirebaseAuth
    serviceLocator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  }
}

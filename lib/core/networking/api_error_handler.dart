// import 'package:dio/dio.dart';

// import 'api_constant.dart';
// import 'api_error_model.dart';

// enum DataSource {
//   NO_CONTENT,
//   BAD_REQUEST,
//   FORBIDDEN,
//   UNAUTORISED,
//   NOT_FOUND,
//   INTERNAL_SERVER_ERROR,
//   CONNECT_TIMEOUT,
//   CANCEL,
//   RECIEVE_TIMEOUT,
//   SEND_TIMEOUT,
//   CACHE_ERROR,
//   NO_INTERNET_CONNECTION,
//   DEFAULT
// }
// class ResponseCode{
//   static const int SUCCESS = 200;
//   static const int NO_CONTENT  = 201;
//   static const int BAD_REQUEST = 400;
//   static const int UNAUTORISED = 401;
//   static const int FORBIDDEN = 403;
//   static const int INTERNAL_SERVER_ERROR = 500;
//   static const int NOT_FOUND = 404;
//   static const int API_LOGIC_ERROR = 422;

//   //LOCAL_STATUS_CODE
//   static const int CONNECT_TIMEOUT= -1 ;
//   static const int CANCEL= -2 ;
//   static const int RECIEVE_TIMEOUT= -3 ;
//   static const int SEND_TIMEOUT= -4 ;
//   static const int CACHE_ERROR= -5 ;
//   static const int NO_INTERNET_CONNECTION= -6 ;
//   static const int DEFAULT= -7 ;
// } 
// class ResponseMessages{
//   static const String NO_CONTENT=ApiErrors.noContent;
//   static const String BAD_REQUEST=ApiErrors.noContent;
//   static const String UNAUTORISED=ApiErrors.noContent;
//   static const String FORBIDDEN=ApiErrors.noContent;
//   static const String INTERNAL_SERVER_ERROR=ApiErrors.noContent;
//   static const String NOT_FOUND=ApiErrors.noContent;
//   static const String CONNECT_TIMEOUT=ApiErrors.noContent;
//   static const String CANCEL=ApiErrors.noContent;
//   static const String RECIEVE_TIMEOUT=ApiErrors.noContent;
//   static const String SEND_TIMEOUT=ApiErrors.noContent;
//   static const String CACHE_ERROR=ApiErrors.noContent;
//   static const String NO_INTERNET_CONNECTION=ApiErrors.noContent;
//   static const String DEFAULT=ApiErrors.noContent;
// }
// extension DataSourceExtension on DataSource {
//   ApiErrorModel getFailure(){
//     switch(this){
//       case DataSource.NO_CONTENT:
//      // return ApiErrorModel(code:ResponseCode.NO_CONTENT,messages:ResponseMessages.NO_CONTENT);
//       case DataSource.BAD_REQUEST:
//       //      return ApiErrorModel(code:ResponseCode.BAD_REQUEST,messages:ResponseMessages.BAD_REQUEST);

//       case DataSource.UNAUTORISED:
//       //      return ApiErrorModel(code:ResponseCode.UNAUTORISED,messages:ResponseMessages.UNAUTORISED);

//       case DataSource.FORBIDDEN:
//      //       return ApiErrorModel(code:ResponseCode.FORBIDDEN,messages:ResponseMessages.FORBIDDEN);

//       case DataSource.INTERNAL_SERVER_ERROR:
//       //      return ApiErrorModel(code:ResponseCode.INTERNAL_SERVER_ERROR,messages:ResponseMessages.INTERNAL_SERVER_ERROR);

//       case DataSource.NOT_FOUND:
//       //      return ApiErrorModel(code:ResponseCode.NOT_FOUND,messages:ResponseMessages.NOT_FOUND);

//       case DataSource.CONNECT_TIMEOUT:
//       //      return ApiErrorModel(code:ResponseCode.CONNECT_TIMEOUT,messages:ResponseMessages.CONNECT_TIMEOUT);

//       case DataSource.CANCEL:
//       //      return ApiErrorModel(code:ResponseCode.CANCEL,messages:ResponseMessages.CANCEL);

//       case DataSource.RECIEVE_TIMEOUT:
//       //      return ApiErrorModel(code:ResponseCode.RECIEVE_TIMEOUT,messages:ResponseMessages.RECIEVE_TIMEOUT);

//       case DataSource.SEND_TIMEOUT:
//        //     return ApiErrorModel(code:ResponseCode.SEND_TIMEOUT,messages:ResponseMessages.SEND_TIMEOUT);

//       case DataSource.CACHE_ERROR:
//        //     return ApiErrorModel(code:ResponseCode.CACHE_ERROR,messages:ResponseMessages.CACHE_ERROR);

//       case DataSource.NO_INTERNET_CONNECTION:
//          //   return ApiErrorModel(code:ResponseCode.NO_INTERNET_CONNECTION,messages:ResponseMessages.NO_INTERNET_CONNECTION);

//       case DataSource.DEFAULT:
//       //      return ApiErrorModel(code:ResponseCode.DEFAULT,messages:ResponseMessages.DEFAULT);

//     }
//   }
// } 

// class ErrorHandler implements Exception {
//   late ApiErrorModel failure;
//   ErrorHandler.handle(dynamic error){
//     if(error is DioException) {
//       failure= _handleError(error);
//   }else{
//     failure= DataSource.DEFAULT.getFailure();
//   }
// }}

// ApiErrorModel _handleError(DioException error){
//   switch(error.type){
//     case DioExceptionType.connectionTimeout:
//     return DataSource.CONNECT_TIMEOUT.getFailure();

//     case DioExceptionType.sendTimeout:
//      return DataSource.SEND_TIMEOUT.getFailure();



//     case DioExceptionType.receiveTimeout:
//      return DataSource.RECIEVE_TIMEOUT.getFailure();


//     case DioExceptionType.badResponse:
//      if(error.response != null && error.response?.statusCode != null&& error.response?.statusMessage !=null) {
//         return ApiErrorModel.fromjson(error.response!.data);
//   }else{
//     return DataSource.DEFAULT.getFailure();
//   }
//    case DioExceptionType.cancel:
//    return DataSource.CANCEL.getFailure();

//    case DioExceptionType.connectionError:
//    case DioExceptionType.badCertificate:
//    case DioExceptionType.badResponse:
//    return DataSource.DEFAULT.getFailure();
// }
// }


// class ApiInternalStatus{
//   static const int SUCCESS = 0;
//   static const int FAILURE = 1;
// }
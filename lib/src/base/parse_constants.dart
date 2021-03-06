part of flutter_parse_sdk;

// Library
const String keySdkVersion = '1.0.5';
const String keyLibraryName= 'Flutter Parse SDK';

// End Points
const String keyEndPointUserName = '/users/me';
const String keyEndPointLogin = '/login';
const String keyEndPointVerificationEmail = '/verificationEmailRequest';
const String keyEndPointRequestPasswordReset = '/requestPasswordReset';
const String keyEndPointClasses = '/classes/';
const String keyEndPointHealth = '/health';

// ParseObject variables
const String keyVarClassName = 'className';
const String keyVarObjectId = 'objectId';
const String keyVarCreatedAt = 'createdAt';
const String keyVarUpdatedAt = 'updatedAt';
const String keyVarUsername = 'username';
const String keyVarEmail = 'email';
const String keyVarPassword = 'password';
const String keyVarAcl = 'ACL';

// Classes
const String keyClassMain = 'ParseMain';
const String keyClassUser = '_User';

// Headers
const String keyHeaderSessionToken = 'X-Parse-Session-Token';
const String keyHeaderRevocableSession = 'X-Parse-Revocable-Session';
const String keyHeaderUserAgent = 'user-agent';
const String keyHeaderApplicationId = 'X-Parse-Application-Id';
const String keyHeaderContentType = 'Content-Type';
const String keyHeaderContentTypeJson = 'application/json';
const String keyHeaderMasterKey = 'X-Parse-Master-Key';

// URL params
const String keyParamSessionToken = 'sessionToken';

// Storage
const String keyParseStoreBase = 'flutter_parse_sdk_';
const String keyParseStoreUser = "${keyParseStoreBase}user";
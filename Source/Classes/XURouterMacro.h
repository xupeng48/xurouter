//
//  XURouterMacro.h
//  XURouter
//
//  Created by peng xu on 2020/9/28.
//

#ifndef XURouterMacro_h
#define XURouterMacro_h

/**
 注册的宏
 
 @param xur_description endpoint的描述
 @param xur_domain endpoint的domain NSString *
 @param xur_path endpoint的path NSString *
 @param xur_class endpoint的类，实现了<XURouterEndpointProvider>
 @param xur_unique_key endpoint的唯一标识符，通常由app_path组成，能够唯一确认一个url
 */

#define XUR_Endpoint_Register(xur_domain, xur_path, xur_class, xur_unique_key) \
__attribute__((used)) static struct XURouterEndpointRegisterInfo XUR_ENDPOINT_##xur_unique_key __attribute__((used, section("__DATA, __XURouter"))) = {\
.domain = xur_domain,\
.path = xur_path,\
.clsName = xur_class,\
.filePath = __FILE__,\
.uniqueKey = #xur_unique_key\
};\



#define xuR_Endpoint_Register_Controller(xur_domain, xur_path, xur_class, xur_unique_key) \
XUR_Endpoint_Register(xur_domain, xur_path, xur_class, xur_unique_key)\
+ (XURouterEndpoint *)endpointFor:(NSString *)domain path:(NSString *)path {\
return [[XURouterEndpoint alloc] initWithDomain:domain path:path class:[self class]];\
}\

#define XUR_Endpoint_Register_Controller_NO_Paramters(xur_domain, xur_path, xur_class, xur_unique_key) \
XUR_Endpoint_Register(xur_domain, xur_path, xur_class, xur_unique_key)\
+ (XURouterEndpoint *)endpointFor:(NSString *)domain path:(NSString *)path {\
return [[XURouterEndpoint alloc] initWithDomain:domain path:path class:[self class]];\
}\
- (instancetype)initWithRouterParameters:(NSDictionary *)parameters {\
return [self init];\
}

#define XUR_Endpoint_Register_Action(xur_domain,xur_path,xur_class,xur_unique_key,block) \
XUR_Endpoint_Register(xur_domain,xur_path,xur_class,xur_unique_key)\
+ (XURouterEndpoint *)endpoint_##xur_unique_key##_For:(NSString *)domain path:(NSString *)path {\
BOOL(^handler)(XURouterCommand * command) = block;\
if(handler){\
return [[XURouterEndpoint alloc] initWithDomain:domain path:path customHander:handler];\
}\
return nil;\
}\

struct XURouterEndpointRegisterInfo{
    __attribute__((objc_ownership(none))) NSString * domain;
    __attribute__((objc_ownership(none))) NSString * path;
    __attribute__((objc_ownership(none))) NSString * clsName;
    char * filePath;
    char * uniqueKey;
};

#endif /* XURouterMacro_h */

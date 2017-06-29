//
//  HttpManager.m
//  NetWork12
//
//  Created by TJ on 2017/6/8.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "HttpManager.h"
#import "HttpRequestGen.h"
#import <AFNetworking.h>
@interface HttpManager()

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end


@implementation HttpManager

@synthesize appHostMode;

+ (instancetype)mamager{
    static dispatch_once_t onceToken;
    static HttpManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[HttpManager alloc] init];
    });
    return manager;
}

#pragma mark - Public Method
- (void)baseRequest:(NSURLRequest *)request complete:(void(^)(BOOL,id,id))complete{
    //起飞 Request
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
    // do something
    
    
    [self logRequest:request];
    
    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        CFAbsoluteTime end = CFAbsoluteTimeGetCurrent();
//        NSLog(@"网络请求总耗时 %f", end - start);
        [self logResponse:responseObject logError:error coastTime:(end - start) fromRequest:request];

        if (error || ![self validatorRemote:request response:responseObject]) {
            id errData = [self handErrorResponse:request response:responseObject];
            complete(false,responseObject,errData);
        }else{
            id successData = [self handSuccessResponse:request response:responseObject];
            complete(YES,responseObject,successData);
        }
        
    }];
    
    [task resume];
}

- (void)setRequestGeneratorDelegate:(id<HttpRequestGenProtocol>)reqGenDelegate{
    //保持保证不释放
    _requestGeneratorDelegate = reqGenDelegate;
    [HttpRequestGen shareInstance].genDelegate = _requestGeneratorDelegate;
}

#pragma mark - Private Method

- (Boolean)validatorRemote:(NSURLRequest *)request response:(id)responseObject{
    if ([self.dataValDelegate respondsToSelector:@selector(globalRemoteDateValidator:url:)]) {
        
        return  [self.dataValDelegate globalRemoteDateValidator:responseObject
                                                                    url:request.URL.absoluteString];
    }
    
    return YES;

}

- (id)handErrorResponse:(NSURLRequest *)request response:(id)responseObject{
    
    id errorHandle = nil;
    if ([self.dataValDelegate respondsToSelector:@selector(globalRomoteDateErrorHandle:url:)]) {
        
        errorHandle = [self.dataValDelegate globalRomoteDateErrorHandle:responseObject
                                                                    url:request.URL.absoluteString];
    }
    return errorHandle;
    
}

- (id)handSuccessResponse:(NSURLRequest *)request response:(id)responseObject{
    
    id successHandle = nil;
    if ([self.dataValDelegate respondsToSelector:@selector(globalRomoteDateSuccessHandle:url:)]) {
        
        successHandle = [self.dataValDelegate globalRomoteDateSuccessHandle:responseObject
                                                                        url:request.URL.absoluteString];
    }
    return successHandle;
}

- (void)logRequest:(NSURLRequest *)request{
    [self logRequest:request separate:YES];
}

- (void)logRequest:(NSURLRequest *)request separate:(BOOL)separate{
#if DEBUG
    if (!self.isLogEnable) {
        return;
    }
    //log someThing;
    NSLog(@"");
    NSMutableString *logString = [NSMutableString string];
    if (separate) {
        [logString appendString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    }
    [logString appendFormat:@"\n\nMethod:\t\t\t%@\n", request.HTTPMethod];
    [logString appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [logString appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [logString appendFormat:@"\n\nHTTP Body:\n\t%@", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] ? : @"\t\t\t\t\tN/A"];
    if (separate) {
        [logString appendFormat:@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n"];
    }
    NSLog(@"%@", logString);
    
    
    
#endif
}

- (void)logResponse:(id )responseData logError:(NSError *)error coastTime:(CFTimeInterval)time fromRequest:(NSURLRequest *)request{
#if DEBUG
    if (!self.isLogEnable) {
        return;
    }
    //log someThing;
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n==============================================================\n=                        API Response                        =\n==============================================================\n\n"];
    
    [logString appendFormat:@"网络总耗时 :\t\t\t\t\t\t\t%f\n", time];

    [logString appendFormat:@"Content:\n%@\n\n", responseData];

    if (error) {
        [logString appendFormat:@"Error Domain:\t\t\t\t\t\t\t%@\n", error.domain];
        [logString appendFormat:@"Error Domain Code:\t\t\t\t\t\t%ld\n", (long)error.code];
        [logString appendFormat:@"Error Localized Description:\t\t\t%@\n", error.localizedDescription];
        [logString appendFormat:@"Error Localized Failure Reason:\t\t\t%@\n", error.localizedFailureReason];
        [logString appendFormat:@"Error Localized Recovery Suggestion:\t%@\n\n", error.localizedRecoverySuggestion];
    }
    
    [logString appendString:@"\n---------------  Related Request Content  --------------\n"];
    
    [logString appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [logString appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [logString appendFormat:@"\n\nHTTP Body:\n\t%@", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] ?:@"\t\t\t\tN/A"];
    [logString appendFormat:@"\n\n==============================================================\n=                        Response End                        =\n==============================================================\n\n\n\n"];
    
    NSLog(@"%@",logString);
#endif
}


- (void)changeHostTools{
#if DEBUG
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"选择开发环境" message:@"仅开发模式可见" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *testAction = [UIAlertAction actionWithTitle:@"本地测试" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.appHostMode = AppHostModeTest;
    }];
    
    UIAlertAction *releaseAction = [UIAlertAction actionWithTitle:@"release 测试" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.appHostMode = AppHostModeRelease;

    }];

    UIAlertAction *devAction = [UIAlertAction actionWithTitle:@"开发" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.appHostMode = AppHostModeDev;

    }];

    UIAlertAction *productAction = [UIAlertAction actionWithTitle:@"产线" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.appHostMode = AppHostModeProduct;

    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    switch (self.appHostMode) {
        case AppHostModeTest:
            testAction.enabled = NO;
            break;
        case AppHostModeDev:
            devAction.enabled = NO;
            break;
        case AppHostModeProduct:
            productAction.enabled = NO;
            break;
        case AppHostModeRelease:
            releaseAction.enabled = NO;
            break;
        default:
            break;

    }
    [sheet addAction:testAction];
    [sheet addAction:releaseAction];
    [sheet addAction:devAction];
    [sheet addAction:productAction];
    [sheet addAction:cancelAction];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:sheet animated:YES completion:nil];
    
#endif
}

#pragma mark - Getter and Setter
- (AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

- (void)setAppHostMode:(AppHostMode)appHostMode1{
    
#if DEBUG
    

    if (appHostMode == appHostMode1 ) {
        return;
    }
    NSNumber *appHostModeNum = [[NSUserDefaults standardUserDefaults]
                                objectForKey:@"devModel"];
    if(appHostMode1 == [appHostModeNum integerValue]){
        return;
    }
    
    
    appHostMode = appHostMode1;
    [[NSUserDefaults standardUserDefaults] setObject:@(appHostMode) forKey:@"devModel"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([self.requestGeneratorDelegate respondsToSelector:@selector(debugHostChange:)]) {
        [self.requestGeneratorDelegate debugHostChange:appHostMode];
    }
    
#else
    appHostMode = AppHostModeProduct;
    
#endif
}

- (AppHostMode)appHostMode{

#if DEBUG

    NSNumber *appHostModeNum = [[NSUserDefaults standardUserDefaults]
                              objectForKey:@"devModel"];
    
    if (!appHostModeNum) {
        appHostModeNum = @(AppHostModeTest);
    }
     return [appHostModeNum integerValue];
    
#else
    return AppHostModeProduct;
#endif
    
}



@end

//
//  HttpRequestGen.m
//  NetWork12
//
//  Created by TJ on 2017/6/8.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "HttpRequestGen.h"
#import <AFNetworking.h>
@interface HttpRequestGen()

@property (nonatomic,strong) AFHTTPRequestSerializer *formSerializer;
@property (nonatomic,strong) AFHTTPRequestSerializer *jsonSerializer;

@end
@implementation HttpRequestGen

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static HttpRequestGen *gen;
    dispatch_once(&onceToken, ^{
        gen = [HttpRequestGen new];
    });
    return gen;
}

- (NSURLRequest *)generateRequestWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                            headerFields:(NSDictionary *)fields
                             requestType:(NSString *)type{
    
    
    AFHTTPRequestSerializer *serializer = self.jsonSerializer;
    if (fields) {
        if ([@"application/x-www-form-urlencoded" isEqualToString: fields[@"Content-Type"]]) {
            serializer = self.formSerializer;
        }
    }
        //全局配置变量
    
    //设置请求参数
    NSDictionary *tempParamDic = nil;
    
    if (self.genDelegate && [self.genDelegate respondsToSelector:@selector(globalParamsForMethod:host:)]) {
        tempParamDic = [self.genDelegate globalParamsForMethod:type
                                                          host:url];
    }
    
    NSMutableDictionary *requestParams = [@{} mutableCopy];
    [requestParams setValuesForKeysWithDictionary:params];
    [requestParams setValuesForKeysWithDictionary:tempParamDic];
    
    NSMutableURLRequest *request = [serializer requestWithMethod:type
                                                       URLString:url
                                                      parameters:requestParams
                                                           error:NULL];
    
    //设置请求头
    NSMutableDictionary *requestHeader = [@{} mutableCopy];
    NSDictionary *tempHeaderDic = nil;
    if (self.genDelegate && [self.genDelegate respondsToSelector:@selector(globalHeaderFieldsForMethod:host:)]) {
        tempHeaderDic = [self.genDelegate globalHeaderFieldsForMethod:type
                                                                 host:url];
    }
    [requestHeader setValuesForKeysWithDictionary:fields];
    [requestHeader setValuesForKeysWithDictionary:tempHeaderDic];
    [requestHeader enumerateKeysAndObjectsUsingBlock:^(NSString  * _Nonnull  key, NSString   * _Nonnull obj, BOOL * _Nonnull stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    
    //设置超时时间
    NSTimeInterval globalTimeout = 60;
    if (self.genDelegate && [self.genDelegate respondsToSelector:@selector(globalTimeOutForMethod:host:)]) {
        globalTimeout = [self.genDelegate globalTimeOutForMethod:type
                                                            host:url];
    }
    request.timeoutInterval = globalTimeout;
    
    return request;
}

- (NSURLRequest *)generateUploadRequestWithUrl:(NSString *)url params:(NSDictionary *)params headerFields:(NSDictionary *)fields fileData:(id)fileData{
    NSString *type = @"UPLOAD";
    
    AFHTTPRequestSerializer *serializer = self.jsonSerializer;
    if (fields) {
        if ([@"application/x-www-form-urlencoded" isEqualToString: fields[@"Content-Type"]]) {
            serializer = self.formSerializer;
        }
    }
    //全局配置变量
    
    //设置请求参数
    NSDictionary *tempParamDic = nil;
    
    if (self.genDelegate && [self.genDelegate respondsToSelector:@selector(globalParamsForMethod:host:)]) {
        tempParamDic = [self.genDelegate globalParamsForMethod:type
                                                          host:url];
    }
    
    NSMutableDictionary *requestParams = [@{} mutableCopy];
    [requestParams setValuesForKeysWithDictionary:params];
    [requestParams setValuesForKeysWithDictionary:tempParamDic];
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:fileData error:&serializationError];
    
    if (serializationError) {
        NSLog(@"生成request期间发生错误  Error, %@",serializationError);
        return nil;
        
    }

    
    
    //设置请求头
    NSMutableDictionary *requestHeader = [@{} mutableCopy];
    NSDictionary *tempHeaderDic = nil;
    if (self.genDelegate && [self.genDelegate respondsToSelector:@selector(globalHeaderFieldsForMethod:host:)]) {
        tempHeaderDic = [self.genDelegate globalHeaderFieldsForMethod:type
                                                                 host:url];
    }
    [requestHeader setValuesForKeysWithDictionary:fields];
    [requestHeader setValuesForKeysWithDictionary:tempHeaderDic];
    [requestHeader enumerateKeysAndObjectsUsingBlock:^(NSString  * _Nonnull  key, NSString   * _Nonnull obj, BOOL * _Nonnull stop) {
        [request setValue:obj forHTTPHeaderField:key];
    }];
    
    //设置超时时间
    NSTimeInterval globalTimeout = 120;
    if (self.genDelegate && [self.genDelegate respondsToSelector:@selector(globalTimeOutForMethod:host:)]) {
        globalTimeout = [self.genDelegate globalTimeOutForMethod:type
                                                            host:url];
    }
    request.timeoutInterval = globalTimeout;
    
    return request;
    
}

#pragma mark - Getters and Setters
- (AFHTTPRequestSerializer *)formSerializer{
    if (!_formSerializer) {
        _formSerializer = [AFHTTPRequestSerializer serializer];
    }
    return _formSerializer;
}


- (AFHTTPRequestSerializer *)jsonSerializer{
    if (!_jsonSerializer) {
        _jsonSerializer = [AFJSONRequestSerializer serializer];
    }
    return _jsonSerializer;
}

@end

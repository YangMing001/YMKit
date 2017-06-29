//
//  HttpTools.m
//  NetWork12
//
//  Created by TJ on 2017/6/8.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import "HttpTools.h"
#import "HttpManager.h"
#import "HttpRequestGen.h"
@implementation HttpTools


+ (void)GET:(NSString *)url  complete:(HttpToolResponse)complete{
    [HttpTools GET:url params:nil header:nil complete:complete];
}
+ (void)GET:(NSString *)url params:(NSDictionary *)params complete:(HttpToolResponse)complete{
    [HttpTools GET:url params:params header:nil complete:complete];
}

+ (void)GET:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header complete:(HttpToolResponse)complete{
    //生成 Request
    NSURLRequest *request = [[HttpRequestGen shareInstance] generateRequestWithUrl:url params:params headerFields:header requestType:@"GET"];;
    //起飞
    [[HttpManager mamager] baseRequest:request complete:complete];
}

+ (void)POST:(NSString *)url  complete:(HttpToolResponse)complete{
    [HttpTools POST:url params:nil header:nil complete:complete];
}
+ (void)POST:(NSString *)url params:(NSDictionary *)params complete:(HttpToolResponse)complete{
    [HttpTools POST:url params:params header:nil complete:complete];
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header complete:(HttpToolResponse)complete{
    //生成 Request
    NSURLRequest *request = [[HttpRequestGen shareInstance] generateRequestWithUrl:url params:params headerFields:header requestType:@"POST"];;
    //起飞
    [[HttpManager mamager] baseRequest:request complete:complete];
}

+ (void)UploadFile:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header fileData:(void (^)(id<CopyAFMultipartFormData>))data complete:(HttpToolResponse)complete{
    
    //生成 Request
    NSURLRequest *request = [[HttpRequestGen shareInstance] generateUploadRequestWithUrl:url params:params headerFields:header fileData:data];;
    //起飞
    [[HttpManager mamager] baseRequest:request complete:complete];
    
}


+ (void)PUT:(NSString *)url  complete:(HttpToolResponse)complete{
    [HttpTools GET:url params:nil header:nil complete:complete];
}
+ (void)PUT:(NSString *)url params:(NSDictionary *)params complete:(HttpToolResponse)complete{
    [HttpTools PUT:url params:params header:nil complete:complete];
}

+ (void)PUT:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header complete:(HttpToolResponse)complete{
    //生成 Request
    NSURLRequest *request = [[HttpRequestGen shareInstance] generateRequestWithUrl:url params:params headerFields:header requestType:@"PUT"];;
    //起飞
    [[HttpManager mamager] baseRequest:request complete:complete];
}

+ (void)DEL:(NSString *)url  complete:(HttpToolResponse)complete{
    [HttpTools DEL:url params:nil header:nil complete:complete];
}
+ (void)DEL:(NSString *)url params:(NSDictionary *)params complete:(HttpToolResponse)complete{
    [HttpTools DEL:url params:params header:nil complete:complete];
}
+ (void)DEL:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header complete:(HttpToolResponse)complete{
    //生成 Request
    NSURLRequest *request = [[HttpRequestGen shareInstance] generateRequestWithUrl:url params:params headerFields:header requestType:@"DELETE"];;
    //起飞
    [[HttpManager mamager] baseRequest:request complete:complete];
}







@end

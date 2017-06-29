//
//  HttpTools.h
//  NetWork12
//
//  Created by TJ on 2017/6/8.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CopyAFMultipartFormData.h"

typedef void(^HttpToolResponse)(BOOL isSuccess,id remoteData,id responseData);

@interface HttpTools : NSObject

/****----GET-----****/
+ (void)GET:(NSString *)url  complete:(HttpToolResponse)complete;
+ (void)GET:(NSString *)url params:(NSDictionary *)params complete:(HttpToolResponse)complete;
+ (void)GET:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header complete:(HttpToolResponse)complete;
/****----POST-----****/
+ (void)POST:(NSString *)url   complete:(HttpToolResponse)complete;
+ (void)POST:(NSString *)url params:(NSDictionary *)params  complete:(HttpToolResponse)complete;
+ (void)POST:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header  complete:(HttpToolResponse)complete;

+ (void)UploadFile:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header fileData:(void (^)(id<CopyAFMultipartFormData> formData))data  complete:(HttpToolResponse)complete;


/****----PUT-----****/
+ (void)PUT:(NSString *)url   complete:(HttpToolResponse)complete;
+ (void)PUT:(NSString *)url params:(NSDictionary *)params  complete:(HttpToolResponse)complete;
+ (void)PUT:(NSString *)url params:(NSDictionary *)params  header:(NSDictionary *)header  complete:(HttpToolResponse)complete;

/****----DEL-----****/
+ (void)DEL:(NSString *)url   complete:(HttpToolResponse)complete;
+ (void)DEL:(NSString *)url params:(NSDictionary *)params  complete:(HttpToolResponse)complete;
+ (void)DEL:(NSString *)url params:(NSDictionary *)params header:(NSDictionary *)header  complete:(HttpToolResponse)complete;




@end

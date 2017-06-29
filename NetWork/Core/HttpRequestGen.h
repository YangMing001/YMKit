//
//  HttpRequestGen.h
//  NetWork12
//
//  Created by TJ on 2017/6/8.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestGenProtocol.h"

@interface HttpRequestGen : NSObject

+ (instancetype)shareInstance;

@property (nonatomic,assign) id<HttpRequestGenProtocol> genDelegate;

- (NSURLRequest *)generateRequestWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                            headerFields:(NSDictionary *)fields
                             requestType:(NSString *)type;

- (NSURLRequest *)generateUploadRequestWithUrl:(NSString *)url
                                  params:(NSDictionary *)params
                            headerFields:(NSDictionary *)fields
                                      fileData:(id)fileData;


@end

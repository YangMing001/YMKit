//
//  HttpManager.h
//  NetWork12
//
//  Created by TJ on 2017/6/8.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestGenProtocol.h"
#import "HttpRemoteDataValidatorProtocol.h"

@interface HttpManager : NSObject

+ (instancetype)mamager;

/*!
 * 开发模式
 */
@property (nonatomic,assign) AppHostMode appHostMode;

/*!
 * 是否打印日志
 */
@property (assign,nonatomic,getter=isLogEnable) BOOL apiLogEnable;


/*!
 * 数据验证
 */
@property (strong,nonatomic) id<HttpRemoteDataValidatorProtocol> dataValDelegate;

/*!
 * 请求生成全局代理
 */
@property (nonatomic,strong) id<HttpRequestGenProtocol> requestGeneratorDelegate;


/**
 *  更改开发环境工具，仅开发模式下有效
 */
- (void)changeHostTools;

/**
 *  发送 Request 对象
 */
- (void)baseRequest:(NSURLRequest *)request complete:(void(^)(BOOL,id,id))complete;


@end

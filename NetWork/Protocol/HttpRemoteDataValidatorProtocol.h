//
//  LMRemoteDataValidatorProtocol.h
//  NetWork12
//
//  Created by TJ on 2017/6/8.
//  Copyright © 2017年 TJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpRemoteDataValidatorProtocol <NSObject>

/**
 *  全局网络数据验证拦截器
 */
- (BOOL)globalRemoteDateValidator:(id)remoteData url:(NSString *)url;

/**
 *  全局网络成功数据处理
 */
- (id)globalRomoteDateSuccessHandle:(id)remoteData url:(NSString *)url;

/**
 *  全局网络失败数据处理
 */
- (id)globalRomoteDateErrorHandle:(id)remoteData url:(NSString *)url;



@end

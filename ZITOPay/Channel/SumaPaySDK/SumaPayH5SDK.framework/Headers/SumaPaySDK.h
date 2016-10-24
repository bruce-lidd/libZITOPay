//
//  P2PFunction.h
//  MoneyDemo
//
//  Created by pk on 15/4/8.
//  Copyright (c) 2015年 iss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


typedef void(^CompletionBlock)(id resultDic, NSError *error);


@interface SumaPaySDK : NSObject

/**
 *  RA-002 从服务端请求SDK的初始化参数
 *
 *  @param merchantCode 商户编码
 *  @param bizName      业务类型名称，多业务用逗号分割
 *  @param EnvFlag  0:正式地址  1:预上线地址
 */
+ (void)setServiceWithMerchantCode:(NSString *)merchantCode andBizName:(NSString *)bizName EnvFlag:(NSString *)envFlag callback:(CompletionBlock)completionBlock;

/**
 *  RA-003 商户app调用SDK通用接口，已启动SDK
 *
 *  @param dictionary 商户APP打包的相关参数
 */
+ (void)startService:(NSDictionary *)dictionary  callback:(CompletionBlock)completionBlock;


/**
 *  RA-004 商户app调用SDK通用接口，获取目前SDK最新版本
 *
 */
+ (void)getSDKVersion:(CompletionBlock)completionBlock;

@end

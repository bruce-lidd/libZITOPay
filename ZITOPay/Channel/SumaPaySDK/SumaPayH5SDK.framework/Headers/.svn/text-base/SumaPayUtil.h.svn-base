//
//  SumaPayUtil.h
//  SumaPayH5
//
//  Created by King on 15/11/10.
//  Copyright © 2015年 pk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SumaPayUtil : NSObject


/**
 *  RA-008 AES加密
 *
 *  @param signString
 *  @param Key
 *  @return 返回AES加密后得字符串
 */
- (NSString *) encryptForAES:(NSString *)decryptString Key:(NSString *)key;

/**
 *  RA-008 AES解密
 *
 *  @param unSignString
 *  @param Key
 *  @return 返回AES解密后的字符串
 */
- (NSString *) decryptForAES:(NSString *)encryptString  Key:(NSString *)key;


/**
 *  RA-009 RSA加密
 *
 *  @param decryptString      加密数据
 *  @param pubKey             公钥
 *
 *  @return RSA加密后的字符串
 */
- (NSString *)encryptByPublicKeyForRSA:(NSString *)decryptString publicKey:(NSString *)pubKey;

/**
 *  RA-009 RSA解密
 *
 *  @param encryptString      加密数据
 *  @param priKey                私钥
 *
 *  @return 返回解密后得字符串
 */
- (NSString *)decryptByPrivateKeyForRSA:(NSString *)encryptString privateKey:(NSString *)privKey;

/**
 *  RA-0010 得到一个随机数
 *
 *  @param startNum long  开始区间
 *  @param endNum   long  结束区间
 *
 *  @return 得到一个long  类型的位于 startNum 与 endNum 之间的数值
 */
- (NSString *)getRandomNum:(long long)startNum endNum:(long long)endNum;

/**
 *  得到固定长度的字母字符串
 *
 *  @param length 字符串的长度
 *
 *  @return 字符串
 */
- (NSString *)getRandomStr:(int)length;

@end

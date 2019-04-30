//
//  TLBaseModel.h
//  TLBaseModel
//
//  Created by hello on 2019/4/30.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* _Nullable const UserKey0 = @"UserKey0";
static NSString* _Nullable const UserKey1 = @"UserKey1";

NS_ASSUME_NONNULL_BEGIN

@interface TLBaseModel : NSObject<NSSecureCoding>

+ (instancetype)sharedInstance:(NSString *)key;
+ (void)saveData:(NSString *)key;
+ (void)clearData:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

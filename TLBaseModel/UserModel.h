//
//  UserModel.h
//  TLBaseModel
//
//  Created by hello on 2019/4/30.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLBaseModel.h"
@class FatherModel;

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : TLBaseModel

@property (nonatomic ,strong)FatherModel   *father;
@property (nonatomic ,strong)NSDictionary  *dic;
@property (nonatomic ,copy  )NSString      *name;
@property (nonatomic ,assign)int            age;

@end

NS_ASSUME_NONNULL_END

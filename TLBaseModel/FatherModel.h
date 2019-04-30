//
//  FatherModel.h
//  TLBaseModel
//
//  Created by hello on 2019/4/30.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLBaseModel.h"
@class WifeModel;



@interface FatherModel : TLBaseModel

@property (nonatomic ,strong)WifeModel     *wife;
@property (nonatomic ,strong)NSArray       *arr;
@property (nonatomic ,copy  )NSString      *name;
@property (nonatomic ,assign)NSInteger      phone;

@end

NS_ASSUME_NONNULL_BEGIN
NS_ASSUME_NONNULL_END

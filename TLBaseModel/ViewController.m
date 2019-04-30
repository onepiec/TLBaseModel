//
//  ViewController.m
//  TLBaseModel
//
//  Created by hello on 2019/4/30.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "ViewController.h"
#import "UserModel.h"
#import "FatherModel.h"
#import "WifeModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *arr = @[@"存储",@"更新",@"清空"];
    for (int i =0; i <arr.count; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(50, 50 +100 *i, 100, 50);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.tag = 10 +i;
    }
    
}
- (void)click:(UIButton *)btn{
    
    if (10 == btn.tag) {
        
        UserModel *userModel = [UserModel sharedInstance:UserKey0];
        userModel.dic = @{@"sex":@"man"};
        userModel.name = @"tl";
        userModel.age = 25;
        
        FatherModel *fatherModel = [FatherModel new];
        fatherModel.arr = @[@"1",@"2",@"3"];
        fatherModel.name = @"xxx";
        fatherModel.phone = 18599990001;
        userModel.father = fatherModel;
        
        WifeModel *wifeModel = [WifeModel new];
        wifeModel.name = @"yyy";
        wifeModel.height = 165;
        wifeModel.weight = 56.5;
        fatherModel.wife = wifeModel;
        
        [UserModel saveData:UserKey0];
        
        UserModel *newModel = [UserModel sharedInstance:UserKey0];
        NSLog(@"----------%@",newModel);
        
    }else if (11 == btn.tag){
        
        UserModel *userModel = [UserModel sharedInstance:UserKey0];
        FatherModel *fatherModel = userModel.father;
        WifeModel *wifeModel = fatherModel.wife;
        
        userModel.age = 30;
        fatherModel.arr = nil;
        fatherModel.name = @"yyy";
        wifeModel.name = nil;
        
        [UserModel saveData:UserKey0];
        
        UserModel *newModel = [UserModel sharedInstance:UserKey0];
        NSLog(@"----------%@",newModel);
        
    }else{
        [UserModel clearData:UserKey0];
        
        UserModel *newModel = [UserModel sharedInstance:UserKey0];
        NSLog(@"----------%@",newModel);
        
    }
    
    
}

@end

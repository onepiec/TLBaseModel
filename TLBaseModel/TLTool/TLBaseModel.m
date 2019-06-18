//
//  TLBaseModel.m
//  TLBaseModel
//
//  Created by hello on 2019/4/30.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLBaseModel.h"
#import <objc/runtime.h>

static TLBaseModel *_config = nil;
static dispatch_once_t _predicate;


@implementation TLBaseModel

+ (instancetype)sharedInstance:(NSString *)key{
    
    if (!key || key.length ==0) return nil;
    dispatch_once(&_predicate, ^{
        
        NSError *error = nil;
        NSData *archiver = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (!archiver) {
            _config = [[self alloc]init];
        }else{
            _config = [NSKeyedUnarchiver unarchivedObjectOfClass:[self class] fromData:archiver error:&error];
            if (error) {
                NSLog(@"解档失败:%@", error);
                _config = [[self alloc]init];
            }
        }
    });
    return _config;
}
+ (void)saveData:(NSString *)key{
    
    if (!key || key.length ==0) return;
    NSError *error = nil;
    
    NSData *archiver = [NSKeyedArchiver archivedDataWithRootObject:[self sharedInstance:key] requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"更新数据失败:%@", error);
    }
    [[NSUserDefaults standardUserDefaults] setObject:archiver forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _config = nil;
    _predicate = 0l;
}
+ (void)clearData:(NSString *)key{
    
    if (!key || key.length ==0) return;
    _config = nil;
    _predicate = 0l;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)supportsSecureCoding{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i ++) {
        
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        
        NSString *strName = [NSString stringWithUTF8String:propertyName];
        [aCoder encodeObject:[self valueForKey:strName] forKey:strName];
    }
    free(propertys);
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        
        unsigned int propertyCount = 0;
        objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
        
        for (int i = 0; i < propertyCount; i ++) {
            
            objc_property_t property = propertys[i];
            const char * propertyName = property_getName(property);
            NSString *strName = [NSString stringWithUTF8String:propertyName];
            
            const char * property_attr = property_getAttributes(property);
            NSString *classNameStr = [self tlGetPropertyRealType:property_attr];
            
            if (classNameStr.length >0) {
                [self setValue:[aDecoder decodeObjectOfClass:NSClassFromString(classNameStr) forKey:strName] forKey:strName];
            }else{
                if ([aDecoder decodeObjectForKey:strName]) {
                    [self setValue:[aDecoder decodeObjectForKey:strName] forKey:strName];
                }
            }
        }
        free(propertys);
    }
    return self;
}
- (NSString *)tlGetPropertyRealType:(const char *)property_attr {
    
    NSString * type;
    if (property_attr[1] == '@') {
        
        char _property_attr[100];
        strcpy(_property_attr, property_attr);
        char str[5] = "\"";
        char *des_attr = strtok(_property_attr, str);
        des_attr = strtok(NULL, str);
        type = [[NSString alloc]initWithUTF8String:des_attr];
        des_attr = NULL;
        free(des_attr);
    }
    return type;
}
@end

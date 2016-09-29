//
//  MKRouterCenter.m
//  MKDevelopSolutions
//
//  Created by xmk on 16/9/26.
//  Copyright © 2016年 xiaomk. All rights reserved.
//

#define DN_REGEX_SCHEME  @"^([\\w- .]+)"
#define DN_REGEX_SCHEME_PREFIX  @"^([\\w- .]+)(://)"

#define DN_REGEX_STATIC_PATH    @"^([\\w- .]+)"
#define DN_REGEX_DYNAMIC_PATH  @"^(/)([\\w- .]+)(/:)"
#define DN_REGEX_DYNAMIC_VALUE_PATH @"(:[\\w- .]+)"

#define DN_REGEX_DYNAMIC_VALUE_SUFFIX @"([\\w- .]+)$"

#define DN_REGEX_PARAMS_SUFFIX @"(\\?[\\w- .&=]+)$"
#define DN_REGEX_PARAMS_UNIT @"([\\w- ]+)(=)([\\w- ]+)$"

#import "MKRouterCenter.h"
#import "UIViewController+MKRouterExtend.h"

@implementation MKRouterAction
@end


@interface MKRouterCenter()

@property (nonatomic, strong) NSMutableArray *pathPatterns;

@property (nonatomic, strong) NSMutableDictionary *nameActionMapping;
@property (nonatomic, strong) NSMutableDictionary *nameControllerMapping;

@property (nonatomic, strong) NSMutableDictionary *pathActionMapping;
@property (nonatomic, strong) NSMutableDictionary *pathControllerMapping;

@end

@implementation MKRouterCenter

+ (instancetype)defaultCenter{
    static MKRouterCenter *defalutCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defalutCenter = [[self alloc] init];
    });
    return defalutCenter;
}

- (void)addName:(NSString *)name path:(NSString *)path controller:(__kindof UIViewController *(^)(void))controller action:(void (^)(__kindof UIViewController *))action{
    
    path = [self mk_parsePath:path];
    
    self.nameActionMapping[name] = action;
    self.nameControllerMapping[name] = controller;
    self.pathActionMapping[path] = action;
    self.pathControllerMapping[path] = controller;
    
    if ([self mk_isDynamicPattern:path]) {
        [self.pathPatterns insertObject:path atIndex:0];
    }else{
        [self.pathPatterns addObject:path];
    }
}

- (MKRouterAction *)actionOfName:(NSString *)name{
    if (![self.nameControllerMapping objectForKey:name]) {
        return nil;
    }
    MKRouterAction *action = [[MKRouterAction alloc] init];
    action.action = self.nameActionMapping[name];
    action.controller = self.nameControllerMapping[name];
    action.behavior = MKActionBehavior_Attached;
    return action;
}

- (NSArray *)actionsOfPath:(NSString *)path{
    
    //是否带参数
    NSDictionary *queryItems = [self queryItemsInPath:&path];
    
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    
    NSRange ar = [self mk_rangeOfActionPattern:path];
    
    NSMutableString *mp = [path mutableCopy];
    
    NSString *scheme;
    //获取、 过滤scheme
    mp = [self mk_removeRangeOfSchemePattern:path scheme:&scheme];
    
    if ((scheme && ![[scheme lowercaseString] isEqualToString:[self.scheme lowercaseString]]) || !mp) {
        return nil;
    }
    
    //normal scheme action
    if (ar.length < 3) {
        MKRouterAction *pop = [self mk_popActionOfRange:ar];
        if (pop) {
            [actions addObject:pop];
        }
        
        if (ar.length > 0) {
            [mp deleteCharactersInRange:ar];
        }
        while (mp.length > 0) {
            NSString *pattern, *queryId;
            NSRange mpr = [self mk_rangeOfPattern:mp pattern:&pattern queryId:&queryId];
            
            if (mpr.location != NSNotFound) {
                MKRouterAction *action = [[MKRouterAction alloc] init];
                action.behavior = MKActionBehavior_Attached;
                action.queryItems = queryItems;
                action.queryId = queryId;
                
                action.controller = self.pathControllerMapping[pattern];
                action.action = self.pathActionMapping[pattern];
                
                [actions addObject:action];
                [mp deleteCharactersInRange:mpr];
            }else{
                mp = [@"" mutableCopy];
            }
        }
        return actions;
    }
    return nil;
}


#pragma mark - ***** private *****
- (NSString *)mk_parsePath:(NSString *)path{
   
    //remove the last '/' characters to make uniform path
    NSString *pattern = @"(/+)$";
    NSRange range = [path rangeOfString:pattern options:NSRegularExpressionSearch];
    
    if (range.location != NSNotFound) {
        path = [path stringByReplacingCharactersInRange:range withString:@""];
    }
    
    //the dynamic path should have prior right for matching
    NSRange dr = [path rangeOfString:DN_REGEX_DYNAMIC_PATH options:NSRegularExpressionSearch];
    
    if(dr.location != NSNotFound){
        dr = [path rangeOfString:DN_REGEX_DYNAMIC_VALUE_PATH options:NSRegularExpressionSearch];
        path = [path stringByReplacingCharactersInRange:dr withString:DN_REGEX_DYNAMIC_VALUE_SUFFIX];
    }
    
    //return path regex should match from head
    path = [NSString stringWithFormat:@"^%@", path];
    return path;
}

- (BOOL)mk_isDynamicPattern:(NSString *)path{
    if([path hasSuffix:DN_REGEX_DYNAMIC_VALUE_SUFFIX]){
        return YES;
    }
    return NO;
}

- (MKRouterAction *)mk_popActionOfRange:(NSRange)range{
    MKRouterAction *action = [[MKRouterAction alloc] init];
    if(range.length == 2) {
        action.behavior = MKActionBehavior_Pop;
        return action;
    }
    if(range.length == 0) {
        action.behavior = MKActionBehavior_PopToRoot;
        return action;
    }
    return nil;
}

//match scheme
- (NSMutableString *)mk_removeRangeOfSchemePattern:(NSString *)path scheme:(NSString **)scheme{
    NSRange range = [path rangeOfString:DN_REGEX_SCHEME_PREFIX options:NSRegularExpressionSearch];
    NSMutableString *ms = [path mutableCopy];
    
    if(range.location != NSNotFound){
        NSRange sr = [path rangeOfString:DN_REGEX_SCHEME options:NSRegularExpressionSearch];
        *scheme = [path substringWithRange:sr];
        [ms deleteCharactersInRange:NSMakeRange(sr.location, sr.length + 2)];
        return ms;
    }
    return ms;
}

//match ./ ../ or /
- (NSRange )mk_rangeOfActionPattern:(NSString *)path{
    NSString *pattern = @"^\\.*";
    NSRange range = [path rangeOfString:pattern options:NSRegularExpressionSearch];
    return range;
}

//match pattern
- (NSRange)mk_rangeOfPattern:(NSString *)path pattern:(NSString **)pattern queryId:(NSString **)queryId{
    NSRange range;
    for(NSString *p in self.pathPatterns){
        range = [path rangeOfString:p options:NSRegularExpressionSearch];
        
        if(range.location != NSNotFound){
            *pattern = p;
            if([self mk_isDynamicPattern:p]){
                NSString *dynamicPart = [path substringWithRange:range];
                NSRange dr = [path rangeOfString:DN_REGEX_DYNAMIC_VALUE_SUFFIX options:NSRegularExpressionSearch];
                if(dr.location != NSNotFound){
                    *queryId = [dynamicPart substringWithRange:dr];
                }
                return range;
            }
            return range;
        }
    }
    return range;
}

- (NSDictionary *)queryItemsInPath:(NSString **)path{
    
    NSMutableDictionary *queryItems = [[NSMutableDictionary alloc] init];
    NSRange paramsRange = [*path rangeOfString:DN_REGEX_PARAMS_SUFFIX options:NSRegularExpressionSearch];
    
    if (paramsRange.location == NSNotFound) {
        return nil;
    }
    
    NSMutableString *mParams = [[*path substringWithRange:paramsRange] mutableCopy];
    NSMutableString *mPath = [*path mutableCopy];
    [mPath deleteCharactersInRange:paramsRange];
    *path = mPath;
    
    while (mParams.length > 0) {
        NSRange r = [mParams rangeOfString:DN_REGEX_PARAMS_UNIT options:NSRegularExpressionSearch];
        
        if (r.location != NSNotFound) {
            NSString *matched = [mParams substringWithRange:r];
            NSArray *sliced = [matched componentsSeparatedByString:@"="];
            
            if(sliced.count == 2){
                NSString *key = [self mk_trimDontCareCharacters:sliced[0]];
                NSString *value = [self mk_trimDontCareCharacters:sliced[1]];
                queryItems[key] = value;
            }
            [mParams deleteCharactersInRange:NSMakeRange(r.location - 1, r.length + 1)];
        }
        else{
            mParams = [@"" mutableCopy];
        }
    }
    
    if(queryItems.allKeys.count == 0) return nil;
    
    return [queryItems copy];
}

- (NSString *)mk_trimDontCareCharacters:(NSString *)c{
    c = [c stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    c = [c stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=&?"]];
    return c;;
}





#pragma mark - ***** lazy *****
- (NSMutableArray *)pathPatterns{
    if (!_pathPatterns) {
        _pathPatterns = [[NSMutableArray alloc] init];
    }
    return _pathPatterns;
}

- (NSMutableDictionary *)nameActionMapping{
    if (!_nameActionMapping) {
        _nameActionMapping = [[NSMutableDictionary alloc] init];
    }
    return _nameActionMapping;
}

- (NSMutableDictionary *)nameControllerMapping{
    if (!_nameControllerMapping) {
        _nameControllerMapping = [[NSMutableDictionary alloc] init];
    }
    return _nameControllerMapping;
}

- (NSMutableDictionary *)pathActionMapping{
    if (!_pathActionMapping) {
        _pathActionMapping = [[NSMutableDictionary alloc] init];
    }
    return _pathActionMapping;
}

- (NSMutableDictionary *)pathControllerMapping{
    if (!_pathControllerMapping) {
        _pathControllerMapping = [[NSMutableDictionary alloc] init];
    }
    return _pathControllerMapping;
}

@end

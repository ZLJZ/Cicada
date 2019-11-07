//
//  AllAppsModel.m
//  OperationTag
//
//  Created by 张琦 on 2017/1/16.
//  Copyright © 2017年 com. All rights reserved.
//

#import "AllAppsModel.h"

@implementation AllAppsModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.picture forKey:@"picture"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.picture = [aDecoder decodeObjectForKey:@"picture"];
    }
    return self;
}

@end

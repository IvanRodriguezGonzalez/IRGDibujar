//
//  IRGPincelNormal.m
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 27/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRGPincelNormal.h"

@interface IRGPincelNormal ()




@end

@implementation IRGPincelNormal


-(instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGPincelNormal pincel]" userInfo:nil];
    return false;
}


+ (instancetype) sharedPincelNormal{
    
    static IRGPincelNormal *_pincelTmp;
    if(!_pincelTmp){
        _pincelTmp = [[IRGPincelNormal alloc]initPrivado];
    }
    return _pincelTmp;
}

-(instancetype) initPrivado{
    self = [super init];
    self.colorDelBorde = [UIColor clearColor];
    self.colorDelRelleno = [UIColor clearColor];
    return self;
}



@end

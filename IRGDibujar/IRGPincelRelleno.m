//
//  IRGPincelRelleno.m
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 27/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import "IRGPincelRelleno.h"

@implementation IRGPincelRelleno



-(instancetype) init {
    [NSException exceptionWithName:@"Invalid init" reason:@"Use [IRGPincelRelleno sharedPincelRelleno]" userInfo:nil];
    return false;
}


+ (instancetype) sharedPincelRelleno{
    
    static IRGPincelRelleno *_pincelTmp;
    if(!_pincelTmp){
        _pincelTmp = [[IRGPincelRelleno alloc]initPrivado];
    }
    return _pincelTmp;
}

-(instancetype) initPrivado{
    self = [super init];
    self.colorDelBorde = [UIColor blackColor];
    self.colorDelRelleno = [UIColor greenColor];
    return self;
}


@end

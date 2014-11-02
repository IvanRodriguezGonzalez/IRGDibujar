//
//  IRGPincel.h
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 1/11/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IRGPincel : NSObject

@property (nonatomic) UIColor * colorDeTrazoDelPincel;
@property (nonatomic) UIColor * colorDeRellenoDelPincel;
@property (nonatomic) NSUInteger grosorDelTrazoDelPincel;

@property (nonatomic) NSString *modoPincel;

+ (instancetype) sharedPincel;

@end

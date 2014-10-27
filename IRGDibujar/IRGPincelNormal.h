//
//  IRGPincelNormal.h
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 27/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IRGPincelNormal : NSObject

@property (nonatomic) UIColor *colorDelBorde;
@property (nonatomic) UIColor *colorDelRelleno;

+ (instancetype) sharedPincelNormal;

@end

//
//  IRGLienzo.h
//  IRGDibujar
//
//  Created by Leticia Vila Sexto on 1/11/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IRGLienzo : NSObject

@property (nonatomic) NSInteger filasDelLienzo;
@property (nonatomic) NSInteger columnasDelLienzo;
@property (nonatomic) NSInteger altoCelda;
@property (nonatomic) NSInteger anchoCelda;

@property (nonatomic) UIColor *colorDelTrazoDeLaCeldaSinPintar;
@property (nonatomic) UIColor *colorDelRellenoDeLaCeldaSinPintar;
@property (nonatomic) NSUInteger grosoDelTrazoDeLaCeldaSinPintar;

+ (instancetype) sharedLienzo;

-(bool) dibujarBorderDeLaCelda;

@end

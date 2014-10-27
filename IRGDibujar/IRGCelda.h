//
//  IRGCelda.h
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 26/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IRGCeldaProtocol.h"
@class IRGPincel;


@interface IRGCelda : UIView
@property (nonatomic) UIColor *colorDelBorde;
@property (nonatomic) id<IRGCeldaProtocol> delegado;


- (instancetype) initWithFrame:(CGRect)frame
                 colorDelBorde:(UIColor *)colorDelBorde;

@end

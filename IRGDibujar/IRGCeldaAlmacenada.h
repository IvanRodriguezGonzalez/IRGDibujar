//
//  IRGCeldaAlmacenada.h
//  IRGDibujar
//
//  Created by Ivan Rodriguez Gonzalez on 29/10/14.
//  Copyright (c) 2014 IvanRodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>

@interface IRGCeldaAlmacenada : NSObject

@property (nonatomic) NSUInteger numeroDeCelda;
@property (nonatomic) UIColor *colorDelRellenoAntiguo;
@property (nonatomic) UIColor *colorDelRellenoNuevo;
@property (nonatomic) UIColor *colorDelTrazoAntiguo;
@property (nonatomic) UIColor *colorDelTrazoNuevo;
@property (nonatomic) NSUInteger grosorDelTrazoAntiguo;
@property (nonatomic) NSUInteger grosorDelTrazoNuevo;




//designated initializer
- (instancetype) initWithCeldaAlmacenada: (NSUInteger) numeroDeCelda
                         colorDelRellenoAntiguo:(UIColor *) colorDelRellenoAntiguo
                    colorDelRellenoNuevo:(UIColor *) colorDelRellenoNuevo
                    colorDelTrazoAntiguo: (UIColor *) colorDelTrazoAntiguo
                      colorDelTrazoNuevo:(UIColor *) colorDelTrazoNuevo
                   grosorDelTrazoAntiguo:(NSUInteger) grosorDelTrazoAntiguo
                     grosorDelTrazoNuevo:(NSUInteger) gorsoeDelTrazoNuevo;

@end

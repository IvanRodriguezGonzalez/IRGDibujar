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

@property (nonatomic) CGRect frame;
@property (nonatomic) UIColor *colorDelRellenoAntiguo;
@property (nonatomic) UIColor *colorDelRellenoNuevo;
@property (nonatomic) BOOL rellenadaAntigua;
@property (nonatomic) BOOL rellenadaNueva;


//designated initializer
- (instancetype) initWithCeldaAlmacenada: (CGRect) frame
                         colorDelRellenoAntiguo:(UIColor *) colorDelRellenoAntiguo
                    colorDelRellenoNuevo:(UIColor *) colorDelRellenoNuevo
                        rellenadaAntigua: (bool) rellenadaAntigua
                          rellenadaNueva: (bool) rellenadaNueva;

@end

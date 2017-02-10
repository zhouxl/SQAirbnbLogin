//
//  SQLoginBoxView.h
//  SQAirbnbLogin
//
//  Created by 小六 on 09/02/2017.
//  Copyright © 2017 小六. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLoginProtocol.h"

@interface SQLoginBoxView : UIView <SQLoginProtocol>

@property (nonatomic, copy) void(^showLoginView)(void);

@end

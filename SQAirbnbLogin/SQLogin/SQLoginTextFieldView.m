//
//  SQLoginTextFieldView.m
//  SQAirbnbLogin
//
//  Created by 小六 on 09/02/2017.
//  Copyright © 2017 小六. All rights reserved.
//

#import "SQLoginTextFieldView.h"
#import "Masonry.h"

@interface SQLoginTextFieldView ()

@property (nonatomic, strong, readwrite) UITextField *textField;

@end

@implementation SQLoginTextFieldView

- (UITextField *)textField {
    if ( !_textField ) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.borderStyle = UITextBorderStyleNone;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(8);
            make.left.offset(16);
            make.bottom.offset(-8);
            make.right.offset(-16);
        }];
    }
    return _textField;
}

- (BOOL)becomeFirstResponder {
    return [_textField becomeFirstResponder];
}

@end

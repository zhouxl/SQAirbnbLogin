//
//  SQLoginView.m
//  SQAirbnbLogin
//
//  Created by 小六 on 09/02/2017.
//  Copyright © 2017 小六. All rights reserved.
//

#import "SQLoginView.h"
#import "SQLoginTextFieldView.h"
#import "Masonry.h"

#define margin 15


@interface SQLoginView ()

@property (nonatomic, strong) SQLoginTextFieldView *emailField;
@property (nonatomic, strong) SQLoginTextFieldView *passwordField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetButton;

@end

@implementation SQLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.forgetButton.alpha = 1;
    }
    return self;
}

- (void)loginButtonPressed:(UIButton *)sender {
    
}

- (void)forgetButtonPressed:(UIButton *)sender {
    
}

#pragma mark - delegate

- (void)appear {
    self.alpha = 1;
    self.emailField.alpha = 1;
    [UIView animateWithDuration:0.5 animations:^{
        self.passwordField.alpha = 1;
        self.loginButton.alpha = 1;
        self.forgetButton.alpha = 1;
    } completion:^(BOOL finished) {
        [self.emailField becomeFirstResponder];
    }];
}

- (void)disappear {
    self.emailField.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.passwordField.alpha = 0;
        self.loginButton.alpha = 0;
        self.forgetButton.alpha = 0;
    } completion:^(BOOL finished) {
        self.alpha = 0;
        if (self.dismiss) {
            self.dismiss();
        }
    }];
}

#pragma mark - get

- (SQLoginTextFieldView *)emailField {
    if ( !_emailField) {
        _emailField = [[SQLoginTextFieldView alloc] init];
        _emailField.alpha = 0;
        _emailField.backgroundColor = [UIColor whiteColor];
        _emailField.textField.placeholder = NSLocalizedString(@"邮箱地址", nil);
        [self addSubview:_emailField];
        [_emailField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(margin);
            make.right.offset(-margin);
            make.top.offset(10);
            make.height.mas_equalTo(44);
        }];
    }
    return _emailField;
}

- (SQLoginTextFieldView *)passwordField {
    if (!_passwordField) {
        _passwordField = [[SQLoginTextFieldView alloc] init];
        _passwordField.alpha = 0;
        _passwordField.backgroundColor = [UIColor whiteColor];
        _passwordField.textField.placeholder = NSLocalizedString(@"密码", nil);
        [self addSubview:_passwordField];
        [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(margin);
            make.right.offset(-margin);
            make.top.equalTo(self.emailField.mas_bottom).offset(10);
            make.height.mas_equalTo(44);
        }];
    }
    return _passwordField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.alpha = 0;
        [_loginButton setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];

        _loginButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:176/255.0 blue:240/255.0 alpha:1];
        _loginButton.layer.cornerRadius = 3;
        [_loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginButton];
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(margin);
            make.right.offset(-margin);
            make.top.equalTo(self.passwordField.mas_bottom).offset(20);
            make.height.mas_equalTo(44);
        }];
    }
    return _loginButton;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forgetButton.alpha = 0;
        [_forgetButton setTitle:NSLocalizedString(@"忘记密码", nil) forState:UIControlStateNormal];
        [_forgetButton addTarget:self action:@selector(forgetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_forgetButton];
        [_forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(margin);
            make.right.offset(-margin);
            make.top.equalTo(self.loginButton.mas_bottom).offset(10);
            make.height.mas_equalTo(44);
        }];
    }
    return _forgetButton;
}

@end

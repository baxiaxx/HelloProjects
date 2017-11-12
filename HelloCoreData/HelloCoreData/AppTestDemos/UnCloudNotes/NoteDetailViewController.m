//
//  NoteDetailViewController.m
//  HelloCoreData
//
//  Created by wesley_chen on 12/11/2017.
//  Copyright © 2017 wesley_chen. All rights reserved.
//

#import "NoteDetailViewController.h"

@interface NoteDetailViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textFieldTitle;
@property (nonatomic, strong) UITextView *textViewBody;
@property (nonatomic, strong) UIButton *buttonAttachPhoto;
@property (nonatomic, strong) UIImageView *imageViewAttachedPhoto;
@end

@implementation NoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.note.title;
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.textFieldTitle];
    [self.view addSubview:self.textViewBody];
}

#pragma mark - Getters

#define PADDING_H 20

- (UITextField *)textFieldTitle {
    if (!_textFieldTitle) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(PADDING_H, 64 + 10, screenSize.width - 2 * PADDING_H, 30)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.enabled = NO;
        textField.text = self.note.title;
        
        _textFieldTitle = textField;
    }
    
    return _textFieldTitle;
}

- (UITextView *)textViewBody {
    if (!_textViewBody) {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat spaceV = 10;
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(PADDING_H, CGRectGetMaxY(self.textFieldTitle.frame) + spaceV, screenSize.width - 2 * PADDING_H, screenSize.height - CGRectGetMaxY(self.textFieldTitle.frame) - PADDING_H - spaceV)];
        textView.text = self.note.body;
        textView.editable = NO;
        
        _textViewBody = textView;
    }
    
    return _textViewBody;
}

@end

//
//  EmployeePictureViewController.m
//  HelloCoreData
//
//  Created by wesley_chen on 09/09/2017.
//  Copyright © 2017 wesley_chen. All rights reserved.
//

#import "Employee2PictureViewController.h"

@interface Employee2PictureViewController ()
@property (nonatomic, strong) Employee2 *employee;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation Employee2PictureViewController

- (instancetype)initWithEmployee:(Employee2 *)employee {
    self = [super init];
    if (self) {
        _employee = employee;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
}

#pragma mark - Getters

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = [UIImage imageWithData:self.employee.pictureThumbnail];
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
        [imageView addGestureRecognizer:tapGesture];
        
        _imageView = imageView;
    }
    
    return _imageView;
}

#pragma mark - Actions

- (void)imageViewTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
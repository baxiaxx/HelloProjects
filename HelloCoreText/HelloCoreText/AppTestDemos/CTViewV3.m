//
//  CTViewV3.m
//  HelloCoreText
//
//  Created by wesley_chen on 13/11/2017.
//  Copyright © 2017 wesley_chen. All rights reserved.
//

#import "CTViewV3.h"
#import <CoreText/CoreText.h>

@interface CTViewV3 ()
@property (nonatomic, strong) NSAttributedString *attrString;
@end

@implementation CTViewV3

#pragma mark - Public Methods

- (void)importAttrString:(NSAttributedString *)attrString {
    self.attrString = attrString;
}

#pragma mark -

- (void)drawRect:(CGRect)rect {
    // Note: default coordinate of context is bottom-left origin and up for y, right for x
    // ^ y
    // |
    // |
    // |---------> x
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    // @see https://stackoverflow.com/questions/30756907/ctm-transforms-vs-affine-transforms-in-ios-for-translate-rotate-scale
    // CTM short for current transformation matrix
    
    // Note: move origin to upward based on bottom-left coordinate
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    // Note: flip y axis from upward to downward
    CGContextScaleCTM(context, 1, -1);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    NSAttributedString *attrString = self.attrString;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path, NULL);
    
    CTFrameDraw(frame, context);
}
@end
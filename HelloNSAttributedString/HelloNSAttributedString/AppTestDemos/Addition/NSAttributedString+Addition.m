//
//  NSAttributedString+Addition.m
//  Cocode
//
//  Created by Kyle Fuller on 06/11/2012.
//  Copyright (c) 2012-2014 Cocode. All rights reserved.
//

#import "NSAttributedString+Addition.h"

@implementation NSAttributedString (Addition)

+ (NSAttributedString *)attributedStringWithFormat:(NSString *)format, ... {
    NSMutableArray *attributes = [NSMutableArray array];

    va_list args;
    va_start(args, format);

    NSString *string = [format stringByReplacingOccurrencesOfString:@"%@" withString:@""];
    NSUInteger count = ([format length] - [string length]) / [@"%@" length];

    for (NSUInteger index = 0; index < count; index++) {
        id argument = va_arg(args, id);
        [attributes addObject:argument];
    }
    va_end(args);

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:format];
    [attributedString beginEditing];

    NSRange range = [format rangeOfString:@"%@" options:NSBackwardsSearch];
    for (NSUInteger index = 0; range.location != NSNotFound; index++) {
        id attribute = [attributes lastObject];
        [attributes removeLastObject];

        if ([attribute isKindOfClass:[NSAttributedString class]]) {
            [attributedString replaceCharactersInRange:range withAttributedString:attribute];
        } else {
            [attributedString replaceCharactersInRange:range withString:[attribute description]];
        }

        range = NSMakeRange(0, range.location);
        range = [format rangeOfString:@"%@" options:NSBackwardsSearch range:range];
    }

    [attributedString endEditing];
    return [attributedString copy];
}

// @sa http://stackoverflow.com/questions/13621084/boundingrectwithsize-for-nsattributedstring-returning-wrong-size
- (CGSize)textSizeForMultipleLineWithWidth:(CGFloat)width {
    if (width > 0) {
        return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  context:nil].size;
    }
    else {
        return CGSizeZero;
    }
}

@end


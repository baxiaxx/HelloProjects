//
//  MarkupParserV2SupportImage.h
//  HelloCoreText
//
//  Created by wesley_chen on 13/11/2017.
//  Copyright © 2017 wesley_chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarkupParserV2SupportImage : NSObject
@property (nonatomic, strong, readonly) NSMutableAttributedString *attrStringM;
@property (nonatomic, strong, readonly) NSMutableArray<NSDictionary<NSString *, id> *> *images;

- (void)parseMarkup:(NSString *)markup;
@end

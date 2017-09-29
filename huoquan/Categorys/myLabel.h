//
//  myLabel.h
//  Anywidepart
//
//  Created by Dora on 16/1/8.
//  Copyright © 2016年 Dora. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface myLabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;
@end

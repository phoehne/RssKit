//
//  Image.h
//  QuickChart
//
//  Created by Paul Hoehne on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssImage : NSObject {
    
}

@property (strong) NSString* url;
@property (strong) NSString* title;
@property (strong) NSString* link;
@property (assign) int width;
@property (assign) int height;

@end

//
//  Channel.h
//  RssKit
//
// Copyright (c) 2011, Paul C. Hoehne
// All rights reserved.
//
// Redistribution and use in source and binary forms, with 
// or without modification, are permitted provided that the 
// following conditions are met:
//
// Redistributions of source code must retain the above 
// copyright notice, this list of conditions and the 
// following disclaimer.
// 
// Redistributions in binary form must reproduce the above 
// copyright notice, this list of conditions and the 
// following disclaimer in the documentation and/or other 
// materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND 
// CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
// INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR 
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
// DAMAGE.
//


#import <Foundation/Foundation.h>

@class RssImage;
@class RssCloud;
@class RssTextInput;

@interface RssChannel : NSObject {
    
}

@property (strong) NSString* title;
@property (strong) NSString* copyright;
@property (strong) NSString* link;
@property (strong) NSString* description;
@property (strong) NSString* language;
@property (strong) NSDate* lastBuildDate;
@property (strong) NSString* managingEditor;
@property (strong) NSString* webMaster;
@property (strong) NSDate* pubDate;
@property (strong) NSArray* categories;
@property (strong) NSString* generator;
@property (strong) NSString* docs;
@property (strong) NSString* rating;
@property (strong) RssCloud* cloud;
@property (strong) NSArray* skipHours;
@property (strong) NSArray* skipDays;
@property (strong) NSString* ttl;
@property (strong) RssTextInput* textInput;
@property (strong) RssImage* image;
@property (strong) NSArray* items;
@end

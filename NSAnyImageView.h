//
//  NSAnyImageView.h
//  iConMerge
//
//  Created by Daniel Leping on 1/31/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSAnyImageView : NSImageView {
	bool dragAcceptedByParent;
	NSImage* firstImage;
}

- (bool) clear;
- (bool) loadFile:(NSString*)filename tryImage:(bool)tryImage;
- (bool) loadFile:(NSString*)filename;

@end

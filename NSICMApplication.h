//
//  NSICMApplication.h
//  iConMerge
//
//  Created by Daniel Leping on 2/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSICMApplication : NSApplication {
	
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication;

@end

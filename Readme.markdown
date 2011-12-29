RssKit
======

A simple static library for reading RSS 2.0 feeds.

Installation
------------

This is an Xcode project and currently requires Xcode to build.  Tests are
included.  It is a static library so it can be linked against your 
application.

Suggestions or feedback are appreciated.

Usage
-----

RssLocator* locator = \[\[RssLocator alloc\] init\];

\[locator setFeedUrl: \@"http://somedomain.tld/feed/url"\];
    
RssRoot* root = \[locator retrieveFeed\];

channel = \[root channel\];

item = \[\[channel items\] objectAtIndex: 0\];

Incorporating the project into Xcode
------------------------------------

What I've personally found is to create a workspace and add a UI project.  Then
you need to establish the connection between the UI project and the RssKit 
library.  To do that add the RssKit library to the workspace by dragging in
the .xcodeproj file into the workspace's list of projects.  

Now drag the RssKit project to the UI project.  You can now add the static library
by going to Build Phases for the UI application target and opening the Link Binary
With Libraries section.  Click the + button and you should see libRssKit.a in the
list of libraries.  You will also need to add libxml2.dylib.  

Going into the Build Settings tab, you will need to add header search paths so
that the compiler can find the RssKit headers.  I put my projects in one directory,
so ../RssKit would be the search path from the UI code.  I can then import the
files as #import "RssKit/RssLocator.h" (for example).  You will also need 
to add a search path for libxml2 (/usr/include/libxml2).


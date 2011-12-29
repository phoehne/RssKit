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

\[locator setFeedUrl: @\"http://somedomain.tld/feed/url\"\];
    
RssRoot* root = \[locator retrieveFeed\];

channel = \[root channel\];

item = \[\[channel items\] objectAtIndex: 0\];

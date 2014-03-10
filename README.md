# Assignment RSS Gem

## General Description

    We want to create a gem that abstracts an RSS-Feed (with its entries) and save them as an
    ActiveRecord object into the database. By doing so, we are able to (1) only download a feed once in the set cache lifetime, 
    and (2) also will lateron be able to use the classic rails active-record logic to e.g. fetch only specific entries of an
    rss feed, search through all feed entries, etc...

## Tips and Suggestions

    * Use any gem that you prefer to help you with any underlying functionality. For example, don't write a custom RSS-Parser, but instead use one of the existing RSS-Parser gems available. There's no limitation in what gems you may use for this.
    * For this assignment, we are interested only in the fields that are specified in the models (see rails/db/schema.rb for reference).
    * Different RSS-Feeds might not always provide the same value keys for where they store certain attributes. For example, one RSS Feed might use the 'description'- key for its content, while others might use 'content', 'content_encoded' or whatsoever. Think about a creative way to allow easy customization for this 'mapping'.
    * We have provided a functional rails- app that incorporates the gem, but it might require changes. Feel free to update the Rails-App if you find there's anything to remove, simplify or improve. Still, the focus should be on the gem.
    * Quality before speed: Although time/speed/efficiency should be considered, quality of the code is way more important. If you can't finish all of the gem, focus on what you've already accomplished.
    * The tests are written for just one specific rss-feed. Still, it should work with the additional feed-sources. Feel free to add/modify any tests.
    * In this test-suite, the 'test- database' gets recreated after every test step - just to avoid any confusion.

## Test-Driven-Development

    We've already created a test-suite that contains some explanation of the different steps to complete this gem. The test-suite also provides an ActiveRecord simulation with working rails models (see spec/support/* for reference).
    The documented test-suite is located at spec/assignment_rss_source_spec.rb

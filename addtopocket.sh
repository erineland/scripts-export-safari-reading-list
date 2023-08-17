#!/bin/bash
# Script to export Safari's reading list into a text file, then import this into Pocket or Evernote (or any service with a "email in content" feature).

# First take all of Safari's Reading List items and place them in a text file.
/usr/bin/plutil -convert xml1 -o - ~/Library/Safari/Bookmarks.plist | grep -E  -o '<string>http[s]{0,1}://.*</string>' | grep -v icloud | sed -E 's/<\/{0,1}string>//g' > readinglistlinksfromsafari.txt

# Now loop over each of those URls within that text file and add them to pocket.
while IFS= read -r line
do
    echo $line
/usr/sbin/sendmail -i -f ErinEland168@gmail.com add@getpocket.com <<END
Subject: $line
From: ErinEland168@gmail.com
To: add@getpocket.com

$line
END
done < readinglistlinksfromsafari.txt
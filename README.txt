My script focuses specifically on Evernote and Pocket as asked, but would work with any service which has the same "email your content in" feature.

The result is as desired, whereby the script: 

 - extracts all of the links in the reading list (BUG: takes all
   bookmarks from Safari, so I temporarly deleted all my bookmarks and
   just left the reading list, not ideal I know but it works).

 - Iterates over each of these links and sends them to Pocket/Evernote/whatever service individually.

To use the script yourself:

 - Simply open it up in any text editor and replace the email addresses with your Pocket/Evernote account email address depending on which service you want to use and the recipient email addresses with Evernote or Pocket "email in to us" URLs. (Change addresses on lines 11, 13 and 14 to your own).
 - If just using Pocket, you need to send FROM your Pocket account email address TO add@getpocket.com
 - If using Evernote, you can send FROM any of your email addresses TO your specific Evernote Email Adress.

Here is the script I wrote below... (note, I am using Mac OS X, and as such this is a bash script and may not work on other OSs)

    #!/bin/bash
    # Script to export Safari's reading list into a text file, then import this into Pocket or Evernote (or any service with a "email in content" feature).
    
    # First take all of Safari's Reading List items and place them in a text file.
    /usr/bin/plutil -convert xml1 -o - ~/Library/Safari/Bookmarks.plist | grep -E  -o '<string>http[s]{0,1}://.*</string>' | grep -v icloud | sed -E 's/<\/{0,1}string>//g' > readinglistlinksfromsafari.txt
    
    # Now loop over each of those URls within that text file and add them to pocket.
    while IFS= read -r line
    do
        echo $line
    /usr/sbin/sendmail -i -f {{CHANGE THIS insert your pocket account email address here}} {{CHANGE THIS TO EITHER add@getpocket.com OR YOUR EVERNOTE EMAIL ADDRESS}} <<END
    Subject: $line
    From: {{ CHANGE THIS to your pocket account email if using Pocket, otherwise any of your email accounts will do.}}
    To: add@getpocket.com {{ OR IF USING EVERNOTE YOUR EVERNOTE EMAIL ADDRESS}}
    
    $line
    END
    done < readinglistlinksfromsafari.txt

Above is the template for you to change, and below is the exact script I used, complete with email addresses for Pocket, to act as an example.

    #!/bin/bash
    # Script to export Safari's reading list into a text file, then import this into Pocket or Evernote (or any service with a "email in content" feature).
    
    # First take all of Safari's Reading List items and place them in a text file.
    /usr/bin/plutil -convert xml1 -o - ~/Library/Safari/Bookmarks.plist | grep -E  -o '<string>http[s]{0,1}://.*</string>' | grep -v icloud | sed -E 's/<\/{0,1}string>//g' > readinglistlinksfromsafari.txt
    
    # Now loop over each of those URls within that text file and add them to pocket.
    while IFS= read -r line
    do
        echo $line
    /usr/sbin/sendmail -i -f myemailaddress@gmail.com add@getpocket.com <<END
    Subject: $line
    From: myemailaddress@gmail.com
    To: add@getpocket.com
    
    $line
    END
    done < readinglistlinksfromsafari.txt

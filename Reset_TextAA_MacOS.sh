#!/bin/bash

#Run script as a cron.

function post_notification(){
    command="display notification \"$1\""
    osascript -e "$command"
}

#String would be empty if the current display is retina.
function hasExternalMonitorConnected(){
    connectionType=$(system_profiler SPDisplaysDataType | grep 'Connection Type')
    echo $connectionType
}

# 1 -> is disabled 0 -> is enabled
function isAADisabled(){
    isAADisabled=$(defaults read -g CGFontRenderingFontSmoothingDisabled)
    echo $isAADisabled
}

function switchAA(){
    #Check if the main display is the retina display and CGFontRenderingFontSmoothingDisabled is 0
    if   [[ -z $(hasExternalMonitorConnected) && $(isAADisabled) = 0 ]]
    then
            post_notification "Currently on Retina display. Disabling Subpixel AA and logging off"
            defaults write -g CGFontRenderingFontSmoothingDisabled -bool YES
            defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
            osascript -e 'tell app "System Events" to log out'
    fi

    #Check if the main display is External display and CGFontRenderingFontSmoothingDisabled is 1
    if   [[ ! -z $(hasExternalMonitorConnected) && $(isAADisabled) = 1 ]]
    then
            post_notification "Currently on External display. Enabling Subpixel AA and logging off"
            defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
            defaults -currentHost write -globalDomain AppleFontSmoothing -int 0
            osascript -e 'tell app "System Events" to log out'
    else
            post_notification "Text is already crispy."
                
    fi
}

switchAA






        

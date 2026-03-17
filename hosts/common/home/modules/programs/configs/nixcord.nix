{
  programs.nixcord = {
    config = {
      autoUpdate = true;
      autoUpdateNotification = true;
      useQuickCss = true;
      themeLinks = [ ];
      enabledThemes = [ ];
      enableReactDevtools = false;
      frameless = false;
      transparent = false;
      disableMinSize = false;

      plugins = {
        alwaysAnimate.enable = true;
        alwaysExpandRoles.enable = true;

        anonymiseFileNames = {
          enable = true;
          anonymiseByDefault = true;
          method = 0;
          randomisedLength = 7;
          consistent = "image";
        };

        betterRoleContext = {
          enable = true;
          roleIconFileFormat = "png";
        };

        betterSessions = {
          enable = true;
          backgroundCheck = false;
        };
        betterSettings = {
          enable = true;
          disableFade = true;
          organizeMenu = true;
          eagerLoad = true;
        };

        biggerStreamPreview.enable = true;

        callTimer = {
          enable = true;
          format = "stopwatch";
        };

        colorSighted.enable = true;
        crashHandler.enable = true;
        dontRoundMyTimestamps.enable = true;
        expressionCloner.enable = true;
        favoriteEmojiFirst.enable = true;

        favoriteGifSearch = {
          enable = true;
          searchOption = "hostandpath";
        };

        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        fullSearchContext.enable = true;
        gifPaste.enable = true;
        hideMedia.enable = true;

        imageZoom = {
          enable = true;
          size = 302.0216962524655;
          zoom = 2.2;
          saveZoomValues = true;
          nearestNeighbour = false;
          square = false;
          invertScroll = true;
          zoomSpeed = 0.5;
        };

        memberCount = {
          enable = true;
          toolTip = true;
          memberList = true;
          voiceActivity = true;
        };

        messageLogger = {
          enable = true;
          collapseDeleted = false;
          deleteStyle = "text";
          ignoreBots = false;
          ignoreSelf = false;
          ignoreUsers = "";
          ignoreChannels = "";
          ignoreGuilds = "";
          logEdits = true;
          logDeletes = true;
          inlineEdits = true;
        };

        MutualGroupDMs.enable = true;
        noOnboardingDelay.enable = true;

        noReplyMention = {
          enable = true;
          userList = "1234567890123445,1234567890123445";
          shouldPingListed = true;
          inverseShiftReply = false;
          roleList = "1234567890123445,1234567890123445";
        };

        OnePingPerDM = {
          enable = true;
          channelToAffect = "both_dms";
          allowMentions = false;
          allowEveryone = false;
        };

        petpet.enable = true;
        plainFolderIcon.enable = true;

        platformIndicators = {
          enable = true;
          colorMobileIndicator = true;
          list = true;
          messages = true;
        };

        previewMessage.enable = true;

        relationshipNotifier = {
          enable = true;
          offlineRemovals = true;
          groups = true;
          servers = true;
          friends = true;
          friendRequestCancels = true;
          notices = true;
        };

        replaceGoogleSearch = {
          enable = true;
          replacementEngine = "off";
        };

        reverseImageSearch.enable = true;

        ReviewDB.enable = true;

        roleColorEverywhere = {
          enable = true;
          chatMentions = true;
          memberList = true;
          voiceUsers = true;
          reactorsList = true;
          pollResults = true;
          colorChatMessages = false;
        };

        sendTimestamps = {
          enable = true;
          replaceMessageContents = true;
        };

        serverInfo.enable = true;

        serverListIndicators = {
          enable = true;
          mode = 2;
        };
        showConnections = {
          enable = true;
          iconSpacing = 1;
          iconSize = 32;
        };

        showHiddenChannels = {
          enable = true;
          showMode = 0;
          defaultAllowedUsersAndRolesDropdownState = true;
        };

        showHiddenThings.enable = true;

        showMeYourName = {
          enable = true;
          mode = "nick-user";
          displayNames = false;
          inReplies = false;
          friendNicknames = "dms";
        };

        showTimeoutDuration = {
          enable = true;
          displayStyle = "ssalggnikool";
        };

        silentMessageToggle = {
          enable = true;
          persistState = "none";
          autoDisable = true;
        };
        silentTyping = {
          enable = true;
          chatIcon = true;
          chatContextMenu = true;
          enabledGlobally = true;
        };

        translate = {
          enable = true;
          showChatBarButton = true;
          service = "google";
          autoTranslate = false;
        };

        typingIndicator = {
          enable = true;
          includeCurrentChannel = true;
          includeMutedChannels = false;
          includeBlockedUsers = false;
          indicatorMode = 3;
        };

        unlockedAvatarZoom = {
          enable = true;
          zoomMultiplier = 4.0;
        };
        userVoiceShow = {
          enable = true;
          showInUserProfileModal = true;
          showInMemberList = true;
          showInMessages = true;
        };

        validReply.enable = true;
        validUser.enable = true;

        viewIcons = {
          enable = true;
          format = "webp";
          imgSize = "1024";
        };
        viewRaw = {
          enable = true;
          clickMethod = "Left";
        };
        volumeBooster = {
          enable = true;
          multiplier = 2.0;
        };

        youtubeAdblock.enable = true;

        CustomRPC = {
          enable = true;
          config = {
            type = 0;
            timestampMode = 2;
            appID = "1083974045369892864";
            appName = "Aesthetic";
            details = "💜 My heart belongs ";
            imageBig = "https://media1.tenor.com/m/KRnusjcRbq4AAAAd/henya-vshojo.gif";
            state = "🧡 to the kettle";
          };
        };
      };
    };
  };
}

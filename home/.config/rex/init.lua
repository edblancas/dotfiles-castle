-- App settings (not configurable from init.lua).
-- Set in Rex's Settings window; stored in ~/Library/Preferences/com.superlogical.rex.plist
-- Apply with: defaults write com.superlogical.rex <key> <value>  (while Rex is closed)
--
-- | Setting                                        | Value               |
-- | ---------------------------------------------- | ------------------- |
-- | Workspace.appearance                           | system              |
-- | Workspace.darkThemeID                          | abyssal-trench      |
-- | Workspace.lightThemeID                         | merino-light        |
-- | Workspace.interfaceStyle                       | blendTheme          |
-- | Workspace.inactivePaneFadeMode                 | both                |
-- | Workspace.paneDensity                          | comfortable         |
-- | Workspace.showsPaneHeaders                     | 1                   |
-- | Workspace.sidebarPosition                      | left                |
-- | Workspace.sidebarWidth                         | 264                 |
-- | Workspace.tabStyle                             | horizontal          |
-- | Workspace.tabIconTintMode                      | off                 |
-- | Workspace.terminalFontName                     | Berkeley Mono       |
-- | Workspace.terminalFontPointSize                | 14                  |
-- | Workspace.tintsPanesWithProgramBackground      | 1                   |
-- | Workspace.usesPaneGlass                        | 1                   |
-- | Workspace.usesStandardInactiveWindowPaneStyles | 1                   |
-- | rex.client.remoteControl                       | 1                   |
-- | rex.server.block-plugin-reload-enabled         | 0                   |

rex.bind("ctrl+a>v", "pane.split", { direction = "right" })
rex.bind("ctrl+a>s", "pane.split", { direction = "down" })

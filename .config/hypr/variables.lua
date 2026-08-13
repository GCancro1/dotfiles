-- User-tunable variables
-- All configurable values live here for easy editing

local M = {}

-- Apps
M.terminal = "kitty"
M.browser = "zen-browser"
M.editor = "nvim"
M.fileExplorer = "dolphin"

-- Touchpad
M.touchpadDisableTyping = true
M.touchpadScrollFactor = 1
M.workspaceSwipeFingers = 4
M.gestureFingers = 3
M.gestureFingersMore = 4

-- Blur
M.blurEnabled = true
M.blurSpecialWs = false
M.blurPopups = true
M.blurInputMethods = true
M.blurSize = 8
M.blurPasses = 2
M.blurXray = false

-- Shadow
M.shadowEnabled = true
M.shadowRange = 15
M.shadowRenderPower = 4

-- Gaps
M.workspaceGaps = 1
M.windowGapsIn = 1
M.windowGapsOut = 1
M.singleWindowGapsOut = 2

-- Window styling
M.windowOpacity = 0.92
M.windowRounding = 15
M.windowBorderSize = 1

-- Misc
M.volumeStep = 10 -- In percent
M.cursorTheme = "sweet-cursors"
M.cursorSize = 24

-- Keybind modifiers (used as first arg to hl.bind)
-- Workspaces
M.kbMoveWinToWs = "SUPER + SHIFT"
M.kbMoveWinToWsGroup = "CTRL + SUPER + ALT"
M.kbGoToWs = "SUPER"
M.kbGoToWsGroup = "CTRL + SUPER"
M.kbNextWs = "CTRL + SUPER"
M.kbPrevWs = "CTRL + SUPER"
M.kbToggleSpecialWs = "SUPER"

-- Window groups
M.kbWindowGroupCycleNext = "ALT"
M.kbWindowGroupCyclePrev = "SHIFT + ALT"
M.kbUngroup = "SUPER"
M.kbToggleGroup = "SUPER"

-- Window actions
M.kbMoveWindow = "SUPER"
M.kbResizeWindow = "SUPER"
M.kbWindowPip = "SUPER + ALT"
M.kbPinWindow = "SUPER"
M.kbWindowFullscreen = "SUPER"
M.kbWindowBorderedFullscreen = "SUPER + ALT"
M.kbToggleWindowFloating = "SUPER + ALT"
M.kbCloseWindow = "SUPER"
M.kbMinimize = "SUPER"

-- Special workspace toggles
M.kbSystemMonitor = "CTRL + SHIFT"
M.kbMusic = "SUPER"
M.kbCommunication = "SUPER"
M.kbTodo = "SUPER"

-- Apps
M.kbTerminal = "SUPER"
M.kbBrowser = "SUPER"
M.kbEditor = "SUPER"
M.kbFileExplorer = "SUPER"

-- Misc
M.kbSession = "CTRL + ALT"
M.kbShowSidebar = "SUPER"
M.kbClearNotifs = "CTRL + ALT"
M.kbShowPanels = "SUPER"
M.kbLock = "SUPER"
M.kbRestoreLock = "SUPER + ALT"

return M

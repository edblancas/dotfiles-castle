// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // choose either `'stable'` for receiving highly polished,
    // or `'canary'` for less polished but more frequent updates
    updateChannel: 'canary',

    // default font size in pixels for all tabs
    fontSize: 16,

    // font family with optional fallbacks
    fontFamily: '"MonoLisa", Menlo, Consolas',

    // default font weight: 'normal' or 'bold'
    fontWeight: 'normal',

    // font weight for bold characters: 'normal' or 'bold'
    fontWeightBold: 'bold',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: 'rgba(248,28,229,0.8)',

    // terminal text color under BLOCK cursor
    cursorAccentColor: '#000',

    // `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
    cursorShape: 'BLOCK',

    // set to `true` (without backticks and without quotes) for blinking cursor
    cursorBlink: false,

    // color of the text
    foregroundColor: '#fff',

    // terminal background color
    // opacity is only supported on macOS
    backgroundColor: '#000',

    opacity: 0.95,

    // terminal selection color
    selectionColor: 'rgba(248,28,229,0.9)',

    // border color (window, tabs)
    borderColor: '#333',

    // custom CSS to embed in the main window
    css: '',

    // custom CSS to embed in the terminal window
    termCSS: '',

    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: '',

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: '',

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '12px 5px 10px 8px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#000000',
      red: '#C51E14',
      green: '#1DC121',
      yellow: '#C7C329',
      blue: '#0A2FC4',
      magenta: '#C839C5',
      cyan: '#20C5C6',
      white: '#C7C7C7',
      lightBlack: '#686868',
      lightRed: '#FD6F6B',
      lightGreen: '#67F86F',
      lightYellow: '#FFFA72',
      lightBlue: '#6A76FB',
      lightMagenta: '#FD7CFC',
      lightCyan: '#68FDFE',
      lightWhite: '#FFFFFF',
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    //
    // Windows
    // - Make sure to use a full path if the binary name doesn't work
    // - Remove `--login` in shellArgs
    //
    // Bash on Windows
    // - Example: `C:\\Windows\\System32\\bash.exe`
    //
    // PowerShell on Windows
    // - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
    shell: '',

    // for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
    // by default `['--login']` will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to `false` for no bell
    bell: 'SOUND',

    // if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
    defaultSSHApp: true,

    // if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
    // selection is present (`true` by default on Windows and disables the context menu feature)
    // quickEdit: true,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg

    hyperCustomTouchbar: [
      // the icons were obtain from Dash.app assets at (or dash ios project from github)
      // /Users/dan/macbook/projects/Dash-iOS/Dash/Images.xcassets/Platforms/vim.imageset/vim@2x.png
      // /Applications/Dash.app/Contents/Resources/git.tiff

      // if you just need a single button then don't add options array
      { label: 'clear', command: 'clear', backgroundColor: '#d13232' },
      //{ label: 'man', command: 'man ', prompt: true },
      {
        label: 'vim',
        icon: '/Users/dan/.utils/icons/vim.png',
        options: [
          // colors: blue #009ABF
          // esc command is to the code for the delete character, so it emulates esc as close as possible
          { label: 'esc', command: '\x7f', esc: true, prompt: true },
          { label: 'save', command: ':w', esc: true, backgroundColor: '#17A52E' },
          { label: 'vimux run last', command: ':VimuxRunLastCommand', esc: true, backgroundColor: '#FFFFFF'},
          { label: 'vimux prompt', command: ':VimuxPromptCommand', esc: true },
          { label: 'quit', command: ':q!', esc: true, backgroundColor: '#d13232' },
          { label: 'save & quit', command: ':x', esc: true, backgroundColor: '#F4D03F' },
        ]
      },
      {
        label: 'git',
        icon: '/Users/dan/.utils/icons/git.png', 
        options: [
          { label: 'diff', command: 'git diff' },          
          { label: 'status', command: 'git status' },  
          { label: 'log', command: 'git log' },
          { label: 'add .', command: 'git add .' },
          { label: 'clone', command: 'git clone ', prompt: true },
        ]
      },
      {
        label: '📁 cd',
        options: [
          { command: 'cd ~/Dropbox/', icon: '/Users/dan/.utils/icons/dropbox.png', label: 'cd', iconPosition: 'right' },
          { label: 'cd', icon: '/Users/dan/.utils/icons/downloads.png', iconPosition: 'right', command: 'cd ~/Downloads/', backgroundColor: '#17A52E' },
        ]
      },
    ]
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    //'hyper-snazzy',
    'hyper-dracula',
    'hyperterm-1password',
    'hyper-opacity',
    'hyper-custom-touchbar',
    "hyperminimal"
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    // Example
    // 'window:devtools': 'cmd+alt+o',
  },
};

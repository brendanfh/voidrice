/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 0;        /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const char *fonts[]          = { "SourceCodePro-Medium:bold:size=14", "monospace:size=10" };
static const char dmenufont[]       = "SourceCodePro-Medium:bold:size=14";

static char normbordercolor[] = "#444444";
static char normbgcolor[]     = "#222222";
static char normfgcolor[]     = "#bbbbbb";
static char selbordercolor[]  = "#005577";
static char selbgcolor[]      = "#005577";
static char selfgcolor[]      = "#eeeeee";
static char warnbordercolor[]  = "#005577";
static char warnbgcolor[]      = "#005577";
static char warnfgcolor[]      = "#eeeeee";
static char urgentbordercolor[]  = "#ff0000";
static char urgentbgcolor[]      = "#330000";
static char urgentfgcolor[]      = "#ff4444";

static const char *colors[][3]      = {
	/*               fg               bg             border   */
	[SchemeNorm]   = { normfgcolor,   normbgcolor,   normbordercolor   },
	[SchemeSel]    = { selfgcolor,    selbgcolor,    selbordercolor    },
	[SchemeWarn]   = { warnfgcolor,   warnbgcolor,   warnbordercolor   },
	[SchemeUrgent] = { urgentfgcolor, urgentbgcolor, urgentbordercolor },
};

/* tagging */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",        NULL,       NULL,       0,            1,            -1 },
	{ "Firefox",     NULL,       NULL,       1 << 1,       0,            -1 },
	{ "qutebrowser", NULL,       NULL,       1 << 1,       0,            -1 },
	{ "Chromium",    NULL,	     NULL,       1 << 1, 	   0,   		 -1 },
	{ "discord",     NULL,       NULL,       1 << 5, 	   0, 			 -1 },
	{ "Slack",       NULL,       NULL,       1 << 6, 	   0, 			 -1 },
	{ "Spotify",     NULL,       NULL,       1 << 8, 	   0, 			 -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

#include "layouts.c" // Grid layout

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "HHH", 	  grid },
	{ NULL, 	  NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {
	"dmenu_run",
	"-i",
	"-l", "10",
	"-p", "Run Program:",
	"-m", dmenumon,
	"-fn", dmenufont,
	"-nb", normbgcolor,
	"-nf", normfgcolor,
	"-sb", selbgcolor,
	"-sf", selfgcolor,
	NULL
};

static const char *termcmd[]  = { "/home/brendan/.scripts/utils/tmux_launch", NULL };
static const char *scriptscmd[] = { "/home/brendan/.scripts/scripts", NULL };
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", NULL };
static const char *notepadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", "-e", "vim", "/home/brendan/.notes", NULL };

static const char *downvolcmd[] = { "/usr/bin/pactl", "set-sink-volume", "0", "-5%", NULL };
static const char *mutecmd[] 	= { "/usr/bin/pactl", "set-sink-mute", 	 "0", "toggle", NULL };
static const char *upvolcmd[] 	= { "/usr/bin/pactl", "set-sink-volume", "0", "+5%", NULL };

static const char *brightupcmd[] = { "/bin/xbacklight", "+5%", NULL };
static const char *brightdowncmd[] = { "/bin/xbacklight", "-5%", NULL };

static const char *laptopcmd[]  = { "/home/brendan/.screenlayout/laptop.sh", NULL };
static const char *lockcmd[] = { "/home/brendan/.scripts/tools/lock", NULL };

#define APP(cmd) { .v = (const char*[]) { cmd, NULL } }
#define TERM(cmd) { .v = (const char*[]) { "st", "-e", cmd, NULL } }

#include "selfrestart.c"
#include "push.c"

static Key keys[] = {
	/* modifier                     key        function        argument */
	// SHORTCUTS
	{ MODKEY,                       XK_space,  		spawn,          { .v = dmenucmd } },
	{ MODKEY, 			            XK_Return, 		spawn,          { .v = termcmd } },
	{ MODKEY,						XK_o,	   		spawn,          { .v = scriptscmd } },
	{ MODKEY,                       XK_grave,  		togglescratch,  { .v = scratchpadcmd } },
	{ MODKEY|ShiftMask,             XK_grave,  		togglescratch,  { .v = notepadcmd } },
	{ MODKEY|ShiftMask,				XK_z,	   		spawn,		    { .v = laptopcmd } },
	{ MODKEY,						XK_semicolon,	spawn,		    { .v = lockcmd } },
	{ MODKEY,                       XK_F1,     		spawn,          APP("chromium") },
	{ MODKEY,                       XK_F2,     		spawn,          APP("spotify") },
	{ MODKEY,                       XK_F3,     		spawn,          APP("Discord") },
	{ MODKEY,                       XK_F4,     		spawn,          APP("slack") },
	{ MODKEY,                       XK_F7,     		spawn,			TERM("calcurse") },
	{ MODKEY,                       XK_F8,     		spawn,			TERM("/home/brendan/.config/vifm/scripts/vifmrun") },
	{ MODKEY,                       XK_F9,     		spawn,			TERM("ncpamixer") },
	{ MODKEY,                       XK_F10,    		spawn,			TERM("htop") },

	// MOVEMENT
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },

	// LAYOUT
	{ MODKEY|ControlMask,			XK_comma,  cyclelayout,    {.i = -1 } },
	{ MODKEY|ControlMask,			XK_period, cyclelayout,    {.i = +1 } },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[3]} },
//  { MODKEY,                       XK_h,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[5]} },
	{ MODKEY,                       XK_p,      setlayout,      {0} },

	// STACK MODIFY
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY|ControlMask, 			XK_j,      pushdown,       {0} },
	{ MODKEY|ControlMask,           XK_k,      pushup,         {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },

	// WINDOW MANAGE
	{ MODKEY, 			            XK_q,      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },

	// DWM CONTROL
	{ MODKEY,                       XK_F5,     xrdb,           {.v = NULL } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
    { MODKEY|ShiftMask,             XK_r,      self_restart,   {0} },
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },

	// TAGKEYS
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)

	// SPECIAL KEYS
	{ 0,							XF86XK_AudioLowerVolume, spawn, { .v = downvolcmd } },
	{ 0,							XF86XK_AudioMute, spawn, { .v = mutecmd } },
	{ 0,							XF86XK_AudioRaiseVolume, spawn, { .v = upvolcmd } },

	{ 0,							XF86XK_MonBrightnessUp, spawn, { .v = brightupcmd } },
	{ 0,							XF86XK_MonBrightnessDown, spawn, { .v = brightdowncmd } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

static const char *xres = "/home/brendan/.cache/wal/colors.Xresources";

/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[] = "xft:Terminus:pixelsize=11:style=Regular";
static const char normbordercolor[] = "#000000";
static const char selbordercolor[]  = "#FFFFFF";
static const char normfgcolor[]     = "#808080";
static const char normbgcolor[]     = "#151515";
static const char selfgcolor[]      = "#000000";
static const char selbgcolor[]      = "#E6E6E6";
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int gappx     = 10;        /* gap pixel between windows */
static const unsigned int snap      = 10;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

static const char *tags[] = {"1", "2", "3", "4", "5"};
static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            True,        -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "urxvt", "-e", "tmux", "-2", NULL };
static const char *filecmd[] = { "urxvt", "-e", "ranger", NULL };
static const char *webcmd[] = { "google-chrome-unstable", NULL };
static const char *volup[] = { "amixer", "-c", "0", "set", "Master", "3+", NULL};
static const char *voldown[] = { "amixer", "-c", "0", "set", "Master", "3-", NULL};
static const char *volmute[] = { "amixer", "-c", "0", "set", "Master", "1+", "toggle", NULL};
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,						XK_Down,   spawn,		   {.v = volmute } },
	{ MODKEY,						XK_Right,  spawn,		   {.v = volup } },
	{ MODKEY,						XK_Left,   spawn,		   {.v = voldown } },
	{ MODKEY,						XK_w,	   spawn,		   {.v = webcmd } },	
	{ MODKEY,						XK_f,	   spawn,		   {.v = filecmd } },	
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,             			XK_t, 	   spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY|ShiftMask,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,                       XK_h,      setmfact,       {.f = -0.02} },
	{ MODKEY|ShiftMask,                       XK_l,      setmfact,       {.f = +0.02} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,      focusstack,     {.i = +1 } },
	{ MODKEY,             			XK_q,      killclient,     {0} },
	{ MODKEY|ShiftMask,                       XK_e,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ShiftMask,                       XK_r,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
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


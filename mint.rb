# keybind
###############################################################################
## mfiler
################################################################################

# reload
keycommand NOMETA, KEY_END, "*", "mark_clear(adir);reread(adir)"

# jump menu
defmenu("jump menu",
"~ Home", KEY_1, "dir_move adir(), '~'",
"e /etc", KEY_e, "dir_move adir(), '/etc'",
"o /opt", KEY_o, "dir_move adir(), '/opt'",
"p ~/projects", KEY_p, "dir_move adir(), '/projects'",
"h /var/www/html", KEY_h, "dir_move adir(), '/var/www/html'",
"s sub menu", KEY_s, "menu('sub menu')")
keycommand NOMETA, KEY_j, "*", "menu('jump menu')"

# sub menu
defmenu("sub menu",
"~ Home", KEY_1, "dir_move adir(), '~'")

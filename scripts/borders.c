#include <stdio.h>
#include <gtk/gtk.h>
#include <gdk/gdk.h>

int main(int argc, char **argv) {
  gtk_init(&argc, &argv);
  GdkScreen *screen = gdk_screen_get_default();
  if (screen == NULL) {
    return 0;
  }
  GdkWindow *window = gdk_screen_get_active_window(screen);
  GdkWMDecoration dec;
  gdk_window_get_decorations(window, &dec);
  switch (dec) {
    case 0:
    case GDK_DECOR_ALL:
    case GDK_DECOR_BORDER:
    case GDK_DECOR_TITLE:
    case GDK_DECOR_MINIMIZE:
    case GDK_DECOR_MAXIMIZE:
      gdk_window_set_decorations(window, GDK_DECOR_RESIZEH);
      break;
    default:
      gdk_window_set_decorations(window, GDK_DECOR_BORDER);
  }
  gdk_window_process_all_updates();
  return 0;
}

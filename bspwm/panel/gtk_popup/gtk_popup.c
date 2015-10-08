#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <gtk/gtk.h>

static char *read_stdin(void) {
  size_t cap = 4096, len = 0;
  char *buffer = malloc(cap * sizeof (char));
  int c;
  while ((c = fgetc(stdin)) != EOF && !feof(stdin)) {
    buffer[len] = c;
    if (++len == cap)
      buffer = realloc(buffer, (cap *= 2) * sizeof (char));
  }
  buffer = realloc(buffer, (len + 1) * sizeof (char));
  buffer[len] = '\0';
  return buffer;
}

gboolean focus_out(GtkWidget *widget, GdkEvent *event, gpointer user_data) {
  gtk_main_quit();
  return TRUE;
}

gboolean key_press(GtkWidget *widget, GdkEventKey *event, gpointer user_data) {
  if (event->keyval == GDK_KEY_Escape && event->state == 0)
    gtk_main_quit();
  return TRUE;
}

int main(int argc, char **argv) {
  GtkCssProvider *css;
  GtkWidget *win, *label;
  GdkScreen *screen;
  gchar *value;
  static const gchar *css_data =
    "GtkWindow {"
    "  background-color: #1c1c1c;"
    "}"
    "GtkLabel {"
    "  font-family: DejaVu Sans Mono;"
    "  font-size: 10px;"
    "  color: #bbb;"
    "  font-weight: 100;"
    "  padding: 10px;"
    "}"
    "b {"
    "  color: #ff0000;"
    "}";

  gtk_init(&argc, &argv);
  css = gtk_css_provider_new();
  gtk_css_provider_load_from_data(css, css_data, strlen(css_data), NULL);
  win = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  screen = gtk_window_get_screen(GTK_WINDOW(win));
  gtk_style_context_add_provider_for_screen(screen, GTK_STYLE_PROVIDER(css),
      GTK_STYLE_PROVIDER_PRIORITY_USER);
  value = read_stdin();
  label = gtk_label_new(value);
  gtk_label_set_markup(GTK_LABEL(label), value);
  gtk_container_add(GTK_CONTAINER(win), label);
  gint width, height;
  gtk_window_set_type_hint(GTK_WINDOW(win), GDK_WINDOW_TYPE_HINT_DIALOG);
  gtk_widget_show_all(win);
  gtk_window_get_size(GTK_WINDOW(win), &width, &height);
  gtk_window_move(GTK_WINDOW(win), 1920 - width - 25, 18);
  g_signal_connect(win, "focus-out-event", G_CALLBACK(focus_out), NULL);
  g_signal_connect(win, "button-press-event", G_CALLBACK(focus_out), NULL);
  g_signal_connect(win, "key-press-event", G_CALLBACK(key_press), NULL);
  gtk_main();
  g_free(value);
  g_object_unref(css);
  gtk_widget_destroy(win);
  return 0;
}

all:
	gcc -std=c11 ./gtk_popup.c -o gtk_popup `pkg-config --libs --cflags gtk+-3.0`
	
run: all
	./cal.sh | ./gtk_popup

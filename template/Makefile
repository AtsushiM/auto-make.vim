SRC = file1 file2
COMBINE = file_combine
# COMPRESS = file_min
 
$(COMBINE) : $(SRC)
	cat $^ > $@

# gcc
#	java -jar /Applications/gcc/compiler.jar --js $(COMBINE) --js_output_file $(COMPRESS)
# gcc & growlnotify
#	((java -jar /Applications/gcc/compiler.jar --js $(COMBINE) --js_output_file $(COMPRESS)) && growlnotify -t 'auto-make' -m 'make complete.') || growlnotify -t 'auto-make' -m 'make error.'
 
.PHONY: clean
clean :
	rm -f $(COMBINE) $(COMPRESS)


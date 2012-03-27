SRC = file1 file2
COMBINE = file_combine
# COMPRESS = file_min
 
$(COMBINE) : $(SRC)
	cat $^ > $@

#	java -jar /Applications/gcc/compiler.jar --js $(COMBINE) --js_output_file $(COMPRESS)
 
.PHONY: clean
clean :
	rm -f $(COMBINE) $(COMPRESS)


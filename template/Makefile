SRC = js/main.js js/ather.js
COMBINE = js/main.combine.js
COMPRESS = js/main.min.js
 
$(COMBINE) : $(SRC)
	cat $^ > $@

#	java -jar /Applications/gcc/compiler.jar --js $(COMBINE) --js_output_file $(COMPRESS)
 
.PHONY: clean
clean :
	rm -f $(COMBINE) $(COMPRESS)


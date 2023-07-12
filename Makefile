LIBA_NAME = a
LIBA_1_OBJ = lib$(LIBA_NAME).1.so
LIBA_2_OBJ = lib$(LIBA_NAME).2.so
LIBA_LINK = lib$(LIBA_NAME).so
LIBA_1_SRC = a.c
LIBA_2_SRC = b.c
MAIN_1_OBJ = main1
MAIN_2_OBJ = main2
MAIN_SRC = main.c

CC_BIN = gcc
CFLAGS = -Wall

.PHONY: all clean
.PHONY: ver1 ver2

all:
	@echo "make <ver1|ver2>"
	@echo "    ver1, main1 will link $(LIBA_1_OBJ) with $(LIBA_LINK)."
	@echo "    ver2, main2 will link $(LIBA_2_OBJ) with $(LIBA_LINK)."

ver1: $(MAIN_1_OBJ)
ver2: $(MAIN_2_OBJ)

$(MAIN_1_OBJ): $(LIBA_1_OBJ) $(MAIN_SRC)
	ln -snf $< $(LIBA_LINK)
	$(CC_BIN) $(CFLAGS) -L./ -l$(LIBA_NAME) -Wl,-rpath=./ $(MAIN_SRC) $(LIBA_LINK) -o $@

$(MAIN_2_OBJ): $(LIBA_2_OBJ) $(MAIN_2_SRC)
	ln -snf $< $(LIBA_LINK)
	$(CC_BIN) $(CFLAGS) -L./ -l$(LIBA_NAME) -Wl,-rpath=./ $(MAIN_SRC) $(LIBA_LINK) -o $@

$(LIBA_1_OBJ): $(LIBA_1_SRC)
	$(CC_BIN) $(CFLAGS) -fPIC -shared $< -o $@

$(LIBA_2_OBJ): $(LIBA_2_SRC)
	$(CC_BIN) $(CFLAGS) -fPIC -shared $< -o $@

clean:
	-rm $(LIBA_1_OBJ) $(LIBA_2_OBJ)
	-rm $(LIBA_LINK)
	-rm $(MAIN_1_OBJ) $(MAIN_2_OBJ)

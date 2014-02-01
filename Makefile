OBJ_DIR = _obj

SRCS = $(shell find src -name "*.d")
OBJS = $(patsubst src/%.d, $(OBJ_DIR)/%.o, $(SRCS))

TARGET = henhouse

$(OBJ_DIR)/%.o: src/%.d
	@echo "  DMD  src/$*.d"
	@mkdir -p $(dir $@)
	@dmd -c -w -of$@ src/$*.d

$(TARGET): $(OBJS)
	@echo "  LD   $@"
	@dmd -of$@ $(OBJS)
	@echo "> OK <"


all: $(TARGET)

clean:
	@rm -rf $(TARGET) $(OBJ_DIR)

run: $(TARGET)
	@./$(TARGET)


.PHONY: all clean run

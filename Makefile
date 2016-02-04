OBJ_DIR := _obj

SRCS := $(shell find src -name "*.d")
OBJS := $(patsubst src/%.d, $(OBJ_DIR)/%.o, $(SRCS))

DMD_FLAGS     :=
DMD_LIB_FLAGS := -Isrc -c -w

TARGET := henhouse


$(OBJ_DIR)/%.o: src/%.d
	@echo "  DMD  src/$*.d"
	@mkdir -p $(dir $@)
	@dmd $(DMD_LIB_FLAGS) -of$@ src/$*.d

$(TARGET): clean $(OBJS)
	@echo "  LD   $@"
	@rm -f $@
	@dmd $(DMD_FLAGS) -of$@ $(OBJS)
	@echo "> OK <"

$(TARGET)_test: clean $(OBJS)
	@echo "  LD   $@"
	@rm -f $@
	@dmd $(DMD_FLAGS) -of$@ $(OBJS)
	@echo "> OK <"


clean:
	@rm -rf $(OBJ_DIR)

default: $(TARGET)

test: DMD_FLAGS := $(DMD_FLAGS) -unittest
test: DMD_LIB_FLAGS := $(DMD_LIB_FLAGS) -unittest
test: $(TARGET)_test
	@./$(TARGET)_test
	@rm $(TARGET)_test

.PHONY: clean default test
.DEFAULT_GOAL := default

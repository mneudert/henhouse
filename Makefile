OBJ_DIR := _obj

ifneq (, $(shell which dmd))
	COMP          := dmd
	COMP_LOG      := DMD
	FLAG_OUTPUT   := -of
	FLAG_UNITTEST := -unittest
else ifneq (, $(shell which gdc))
	COMP          := gdc
	COMP_LOG      := GDC
	FLAG_OUTPUT   := -o
	FLAG_UNITTEST := -funittest
else
	$(error No usable compiler found. Tried: dmd, gdc)
endif

SRCS := $(shell find src -name "*.d")
OBJS := $(patsubst src/%.d, $(OBJ_DIR)/%.o, $(SRCS))

COMP_FLAGS     :=
COMP_LIB_FLAGS := -Isrc -c -w

TARGET := henhouse


$(OBJ_DIR)/%.o: src/%.d
	@echo "  $(COMP_LOG)  src/$*.d"
	@mkdir -p $(dir $@)
	@$(COMP) $(COMP_LIB_FLAGS) $(FLAG_OUTPUT)$@ src/$*.d

$(TARGET): clean $(OBJS)
	@echo "  LD   $@"
	@rm -f $@
	@$(COMP) $(COMP_FLAGS) $(FLAG_OUTPUT)$@ $(OBJS)
	@echo "> OK <"

$(TARGET)_test: clean $(OBJS)
	@echo "  LD   $@"
	@rm -f $@
	@$(COMP) $(COMP_FLAGS) $(FLAG_OUTPUT)$@ $(OBJS)
	@echo "> OK <"


clean:
	@rm -rf $(OBJ_DIR)

default: $(TARGET)

test: COMP_FLAGS     := $(COMP_FLAGS) $(FLAG_UNITTEST)
test: COMP_LIB_FLAGS := $(COMP_LIB_FLAGS) $(FLAG_UNITTEST)
test: $(TARGET)_test
	@./$(TARGET)_test
	@rm $(TARGET)_test

.PHONY: clean default test
.DEFAULT_GOAL := default

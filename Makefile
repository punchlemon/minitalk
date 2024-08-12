NAMECL		=	client
NAMESV		=	server
LIB			=	ft
LIB_DIR		=	lib
INC_DIR		=	inc
SRC_DIR		=	src
OBJ_DIR		=	obj
CC			=	gcc
SRCCL_FILE	=	 \
				client \

SRCSV_FILE	=	 \
				server \

CFLAGS		=	-Wall -Werror -Wextra
IFLAGS		=	-I$(INC_DIR) -I$(LIB_DIR)/$(INC_DIR)
LFLAGS		=	-L$(LIB_DIR) -l$(LIB)
VFLAGS		=	 \
				--track-origins=yes \
				--leak-check=full \
				# --show-leak-kinds=all \
				-s \

LOGFILE		=	valgrind_result.log

SRCCL 		= 	$(addprefix $(SRC_DIR)/, $(addsuffix .c, $(SRCCL_FILE)))
OBJCL 		= 	$(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(SRCCL_FILE)))

SRCSV 		= 	$(addprefix $(SRC_DIR)/, $(addsuffix .c, $(SRCSV_FILE)))
OBJSV 		= 	$(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(SRCSV_FILE)))

OBJ_EXIST	=	.obj

$(OBJ_DIR)/%.o:	$(SRC_DIR)/%.c | $(OBJ_EXIST)
				@$(CC) $(CFLAGS) $(IFLAGS) -c $< -o $@

$(OBJ_EXIST):
				@mkdir -p $(OBJ_DIR)

all:			$(NAMECL) $(NAMESV)

$(NAMECL):		$(OBJCL)
				@make all --no-print-directory -C $(LIB_DIR)
				@$(CC) $(OBJCL) $(LFLAGS) -o $(NAMECL)

$(NAMESV):		$(OBJSV)
				@$(CC) $(OBJSV) $(LFLAGS) -o $(NAMESV)

lib_clean:
				@make clean --no-print-directory -C $(LIB_DIR)

clean:			lib_clean
				@$(RM) -r $(OBJ_DIR)

fclean:			clean
				@$(RM) $(NAMECL) $(NAMESV)
				@$(RM) $(LOGFILE)

re:				fclean all

norm:
				@$(call check_norminette, $(SRC_DIR))
				@$(call check_norminette, $(INC_DIR))
				@$(call check_norminette, $(LIB_DIR))

define check_norminette
				@if norminette $1 | grep -q Error!; then \
					norminette $1 | grep Error! | sed -E 's/^[^\\]*\\([^\\]*)\\.*(.{7})/\1\2/'; \
				else \
					echo "$1: OK!"; \
				fi
endef

.PHONY:			all clean fclean re norm

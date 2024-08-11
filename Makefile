NAMECL		=	client
NAMESV		=	server
INC			=	inc
IFLAGS		=	-Iinc
SRC_DIR		=	src
OBJ_DIR		=	obj
CC			=	gcc
FLAGS		=	-Wall -Werror -Wextra
RM			=	rm -f
SRCCL_FILE	=	 \
				client \
				ft_atoi \

SRCSV_FILE	=	 \
				server \
				ft_itoa \
				ft_strdup \

SRCCL 		= 	$(addprefix $(SRC_DIR)/, $(addsuffix .c, $(SRCCL_FILE)))
OBJCL 		= 	$(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(SRCCL_FILE)))

SRCSV 		= 	$(addprefix $(SRC_DIR)/, $(addsuffix .c, $(SRCSV_FILE)))
OBJSV 		= 	$(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(SRCSV_FILE)))

OBJ_EXIST	=	.obj

all:	$(NAMECL) $(NAMESV)

$(NAMECL):	$(OBJCL) $(OBJ_EXIST)
			@$(CC) $(FLAGS) $(OBJCL) $(IFLAGS) -o $(NAMECL)

$(NAMESV):	$(OBJSV) $(OBJ_EXIST)
			@$(CC) $(FLAGS) $(OBJSV) $(IFLAGS) -o $(NAMESV)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(OBJ_EXIST)
			@$(CC) $(FLAGS) $(IFLAGS) -c $< -o $@

$(OBJ_EXIST):
			@mkdir -p $(OBJ_DIR)

clean:
			@$(RM) -r $(OBJ_DIR)

fclean:		clean
			@$(RM) $(NAMECL) $(NAMESV)

re:			fclean all

norm:
			@norminette $(SRC) $(INC) | grep KO | wc -l

.PHONY:		all clean fclean re norm

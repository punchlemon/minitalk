# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ajordan- <ajordan-@student.42urduliz.com>  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/19 15:23:08 by ajordan-          #+#    #+#              #
#    Updated: 2024/06/24 23:08:06 by retanaka         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAMECL		=	client
NAMESV		=	server
LIBFT		=	libft
INC			=	inc
HEADER		=	-I inc -I libft/include
SRC_DIR		=	src/
OBJ_DIR		=	obj/
CC			=	cc
FLAGS		=	-Wall -Werror -Wextra
RM			=	rm -f
SRCCL_FILE	=	client
SRCSV_FILE	=	server

SRCCL 		= 	$(addprefix $(SRC_DIR), $(addsuffix .c, $(SRCCL_FILE)))
OBJCL 		= 	$(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRCCL_FILE)))

SRCSV 		= 	$(addprefix $(SRC_DIR), $(addsuffix .c, $(SRCSV_FILE)))
OBJSV 		= 	$(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRCSV_FILE)))

OBJF		=	.cache_exists

start:
			@make extend -C $(LIBFT)
			@make all

all:		$(NAMECL) $(NAMESV)

$(NAMECL):	$(OBJCL) $(OBJF)
			@$(CC) $(FLAGS) $(OBJCL) $(HEADER) libft/libft.a -o $(NAMECL)

$(NAMESV):	$(OBJSV) $(OBJF)
			@$(CC) $(FLAGS) $(OBJSV) $(HEADER) libft/libft.a -o $(NAMESV)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c $(OBJF)
			@$(CC) $(FLAGS) $(HEADER) -c $< -o $@

$(OBJF):
			@mkdir -p $(OBJ_DIR)

clean:
			@$(RM) -r $(OBJ_DIR)
			@make clean -C $(LIBFT)

fclean:		clean
			@$(RM) $(NAMECL) $(NAMESV)
			@$(RM) $(LIBFT)/libft.a

re:			fclean start

norm:
			@norminette $(SRC) $(INC) $(LIBFT) | grep -v Norme -B1 || true

.PHONY:		start all clean fclean re norm

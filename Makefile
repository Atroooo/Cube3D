 .PHONY:     			all $(NAME) mkbuild lib clean fclean re minilibx sanitize

NAME					= cub3D

BUILD_DIR				= build/
	
HEADER_DIR				= includes/


DIR						= srcs/
SRC			 			= main.c \
						  free_functions/free.c \
						  free_functions/free_mlx.c \
						  parsing/parsing.c \
						  parsing/parsing_utils.c \
						  parsing/get_texture.c \
						  parsing/get_color.c \
						  parsing/get_map.c \
						  parsing/get_map_utils.c \
						  parsing/error_message_parsing.c \
						  execution/init_mlx_create_win.c \
						  execution/key_hook.c \
						  delete.c \
							
OBJECTS			    	= $(SRC:%.c=$(BUILD_DIR)%.o)
	
LIBFT					= libft.a
LIB_DIR					= libft/

MINILIB_DIR				= minilibx_linux/
LINUX					= -Lminilibx_linux -L/usr/lib -Iminilibx_linux -lXext -lX11 -lm -lz

MINILIB					= libmlx.a

GCC						= gcc
CFLAGS					= -Wall -Wextra -Werror -g3  

RM 						= rm -rf

$(BUILD_DIR)%.o:		$(DIR)%.c $(HEADER_DIR) Makefile 
						@mkdir -p $(@D)
						$(GCC) $(CFLAGS) -I$(HEADER_DIR) -I$(LIB_DIR) -c $< -o $@
					
all: 					 minilibx mkbuild lib $(HEADER_DIR) $(NAME)

mkbuild:
						@mkdir -p build
					
$(NAME): 				$(OBJECTS) $(LIB_DIR)$(LIBFT)
						$(GCC) $(CFLAGS) -I{HEADER_DIR} $(OBJECTS) -o $(NAME) $(LIB_DIR)$(LIBFT) $(MINILIB_DIR)$(MINILIB) $(LINUX)

sanit :					$(OBJECTS) $(LIB_DIR)$(LIBFT)
						$(GCC) $(SANITIZE) $(OBJECTS) -o $(NAME) $(LIB_DIR)$(LIBFT) $(MINILIB_DIR)$(MINILIB) $(LINUX)

lib:
						@make -C $(LIB_DIR)

minilibx:
						@make -C $(MINILIB_DIR)
		
clean:					
						@${RM} $(OBJECTS)
						@make clean -C $(LIB_DIR)
						@make clean -C $(MINILIB_DIR)
						@${RM} $(BUILD_DIR)

fclean:					clean
						@${RM} ${NAME}
						@make fclean -C $(LIB_DIR)
						@make clean -C $(MINILIB_DIR)

re:						fclean all
						$(MAKE) all

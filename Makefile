######### Sources #########

SOURCES	=				# SOURCE FILES HERE

HEADERS	=				# HEADER FILES HERE

HEADERS_DIRECTORIES	=	# HEADERS DIRECTORIES, DON'T FORGET THE TRAILING /

######### Details #########

NAME	=	# NAME HERE
SOURCES_EXTENSION = # c/cpp...

######### Compilation #########

COMPILE		=	#COMPILER
DELETE		=	#rm -f

FLAGS		=	#-Wall -Werror -Wextra

######### Additional Paths #########

vpath	%.h $(HEADERS_DIRECTORIES)

# ################################### #
#        DO NOT ALTER FURTHER!        #
# ################################### #

######### Additional Paths #########

vpath	%.o $(OBJS_DIR)
vpath	%.d $(DEPS_DIR)

######### Implicit Macros #########

OBJS_DIR	= .objs/
DEPS_DIR	= .deps/

OBJS	=	$(addprefix $(OBJS_DIR), $(SOURCES:.$(SOURCES_EXTENSION)=.o))
DEPS	=	$(addprefix $(DEPS_DIR), $(SOURCES:.$(SOURCES_EXTENSION)=.d))

#########  Rules  #########

all		:	$(OBJS_DIR) $(DEPS_DIR) $(NAME)

$(NAME) :	$(OBJS)
			$(COMPILE) $(FLAGS) $^ -o $@

clean	: clean_deps clean_objs

fclean	:	clean clean_bin

re		:	fclean
			@make --no-print-directory all

#########  Sub Rules  #########

objs	:	$(OBJS_DIR) $(DEPS_DIR) $(OBJS)

clean_deps:
			$(DELETE) -r $(DEPS_DIR)
clean_objs:
			$(DELETE) -r $(OBJS_DIR)
clean_bin:
			$(DELETE) $(NAME)

#########  Implicit Rules  #########

$(OBJS_DIR)		:
					@mkdir -p $(OBJS_DIR)

$(DEPS_DIR)		:
					@mkdir -p $(DEPS_DIR)

$(OBJS_DIR)%.o		:	%.$(SOURCES_EXTENSION)
			$(COMPILE) $(FLAGS) -MMD -MP -MF $(DEPS_DIR)$*.d -c $< -o $@

.PHONY	:	all clean fclean re

#########  Includes  #########

-include $(DEPS)
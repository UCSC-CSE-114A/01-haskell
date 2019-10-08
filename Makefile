
#####################################################################################################
COURSE=cse116
ASGN=hw1
NAME=haskell
STACK=stack
#####################################################################################################

test: clean
   ./tests/banned.sh tests/taboo
	$(STACK) test --allow-different-user 

bin:
	$(STACK) build --allow-different-user

clean:
	$(STACK) clean --allow-different-user

distclean: clean 
	rm -rf .stack-work 

prepare: 
	rm -rf ./$(ASGN)-$(NAME).tgz
	tar -zcvf ../$(ASGN)-$(NAME).tgz --exclude .stack-work --exclude .git .
	mv ../$(ASGN)-$(NAME).tgz .  


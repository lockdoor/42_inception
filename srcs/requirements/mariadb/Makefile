NAME = maria

up:
	mkdir -p data
	docker build -t $(NAME) .
	docker run -d -v $(PWD)/data:/var/lib/mysql --name $(NAME) $(NAME)

down:
	docker rm -f $(NAME)
# docker rmi $(NAME)
# rm -rf data
it:
	docker exec -it $(NAME) bash

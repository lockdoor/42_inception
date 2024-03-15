NAME = ftp

up:
	# mkdir -p data
	docker build -t $(NAME) .
	docker run -v /Users/pitsanunamnil/Documents/code/42/42cursus/docker/debian/srcs/data/wordpress:/var/www/html -p 20-21:20-21 -p 21100-21110:21100-21110 --name $(NAME) $(NAME)

down:
	docker rm -f $(NAME)
	docker rmi $(NAME)
# rm -rf data

it:
	docker exec -it $(NAME) bash

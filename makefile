build:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker build --rm -f udemy-python.dockerfile -t fcarta29/udemy-python:$$TAG .; \
	docker tag fcarta29/udemy-python:$$TAG fcarta29/udemy-python:latest

clean:
	docker stop udemy-python
	docker rm udemy-python

rebuild: clean build

#ADD this back in with project examples are ready -v $$PWD/deploy:/deploy 
run:
	docker run --name udemy-python -v $$PWD/config/kube.conf:/root/.kube/config -v $$PWD/udemy:/udemy -td fcarta29/udemy-python:latest
	docker exec -it udemy-python bash -l

join:
	docker exec -it udemy-python bash -l
start:
	docker start udemy-python
stop:
	docker stop udemy-python

default: build

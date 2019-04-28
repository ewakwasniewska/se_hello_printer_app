 .PHONY: test

deps:
		pip install -r requirements.txt; \
		pip install -r test_requirements.txt

lint:
		flake8 hello_world test

test:
		PYTHONPATH=. py.test --verbose -s

test_cov:
	PYTHONPATH=. py.test --verbose -s --cov=. 	
	PYTHONPATH=. py.test --verbose -s --cov=. --cov-report xml

test_xuni:
	 PYTHONPATH=. py.test --verbose -s --cov=. --cov-report xml --junit-xml=test_results.xml




run:
	 PYTHONPATH=. FLASK_APP=hello_world flask run

# JENKINS 
run_jenkins:
	docker run -d --name jenkins-wsb \
		-p 8080:8080 \
		-v $$(pwd)/jenkins:var/jenkins_home \
		devops/jenkins

start_jenkins:
	docker start jenkins-wsb

bash_jenkins:
	docker exec -ti jenkins-wsb  /bin/bash

build jenkins:
	docker build -t devops/jenkind -f Dockerfile .

show_me_password:
	cat jenkins/secrets/initialAdminPassword

docker_build:
		docker build -t hello-world-printer .

docker_run: docker_build
		docker run \
			--name hello-world-printer-dev \
			 -p 5000:5000 \
			 -d hello-world-printer

USERNAME=wsbtester1
TAG=$(USERNAME)/hello-world-printer

docker_push: docker_build
		@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
		docker tag hello-world-printer $(TAG); \
		docker push $(TAG); \
		docker logout;

test_smoke:
	curl --fail 127.0.0.1:5000





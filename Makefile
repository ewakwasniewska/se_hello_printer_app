.PHONY: test

deps:
		pip  instll -r requirements.txt;\
		pip install -r test requirements.txt

lint:
		flake8 hello_world test

test:
		PYTHONPATH . py.test --verbose -s\

run:
	 PYTHONPATH . FLASK_APP hello_world flas run

docker_build:
		docker build -t hello-world-printer .

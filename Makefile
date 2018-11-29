.PHONY: build
build:
	docker build -t operable-users -f Dockerfile .

.PHONY: deploy
deploy:
	helm install --name operable-users charts/operable-users

.PHONY: delete
delete:
	helm del operable-users --purge

.PHONY: template
template:
	helm template charts/operable-users

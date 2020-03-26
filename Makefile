.PHONY: test generate

test:
	@pub run test ./test

generate:
	@pub run build_runner build

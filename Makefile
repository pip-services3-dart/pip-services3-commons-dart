.PHONY: test generate gendoc docview

test:
	@pub run test ./test

generate:
	@pub run build_runner build

gendoc:
	@dartdoc --no-auto-include-dependencies --no-include-source --show-progress --output ./docs/

docview:
	@dhttpd --path docs
